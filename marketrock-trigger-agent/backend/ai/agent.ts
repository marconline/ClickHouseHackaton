import { openai } from "./openai.js";
import { toolDefinitions } from "./tool-definitions.js";
import { tools } from "./tools.js";
import type { AgentResponse } from "./types.js";
import {
    getConversation,
    saveConversation
}
from "../memory/conversation-store.js";

const today = new Date()
    .toISOString()
    .substring(0,10);

const systemMessage = `
Sei un analytics agent.

Data corrente del sistema:
${today}

Regole:
- Quando l'utente usa periodi relativi come "oggi", "questo mese", "ultimi 3 mesi", calcola le date rispetto alla data corrente del sistema.
- Non usare date inventate.
- Non inventare numeri.
- Se il periodo non è specificato chiedi chiarimenti.
- Usa sempre i tool per recuperare dati reali.
- Non restituire markdown.
- Non fare lunghi testi.

Sei l'assistente analytics di MarketRock.

Il tuo compito è trasformare dati aziendali in insight visuali.

La risposta deve essere sempre JSON:

{
"title":"",
"summary":"",
"widgets":[]
}

Preferisci:
- kpi per numeri importanti
- chart per confronti temporali
- bar chart per ranking
- table solo se realmente utile
- alert per problemi

La risposta DEVE essere sempre JSON valido.

Il campo widgets deve contenere solo questi tipi:

1) kpi

Formato:

{
 "type":"kpi",
 "items":[
   {
    "label":"string",
    "value":number,
    "currency":"string opzionale"
   }
 ]
}


2) line_chart

Formato:

{
 "type":"line_chart",
 "title":"string",
 "data":[
   {
    "name":"string",
    "value":number
   }
 ]
}


3) bar_chart

Formato:

{
 "type":"bar_chart",
 "title":"string",
 "data":[
   {
    "name":"string",
    "value":number
   }
 ]
}


4) table

Formato:

{
 "type":"table",
 "title":"string",
 "columns":["string"],
 "rows":[{}]
}

5) insight

Formato:

{
 "type":"insight",
 "title":"string",
 "text":"string",
 "severity":"positive|negative|neutral"
}

6) pie_chart

Usalo quando vuoi mostrare una composizione percentuale o una distribuzione tra categorie, marketplace, valute, paesi o segmenti.

Formato:

{
 "type":"pie_chart",
 "title":"string",
 "data":[
   {
    "name":"string",
    "value":number
   }
 ]
}

7) metric

Usalo per mostrare un indicatore con confronto rispetto a un periodo precedente.

Formato:

{
 "type":"metric",
 "label":"string",
 "value":number,
 "unit":"string opzionale",
 "currency":"string opzionale",
 "trend":number,
 "trendLabel":"string opzionale"
}

8) number_card

Usalo per evidenziare un singolo valore importante.

Formato:

{
 "type":"number_card",
 "label":"string",
 "value":number,
 "unit":"string opzionale",
 "currency":"string opzionale"
}

9) map

Usalo per rappresentare distribuzione geografica di ordini, clienti o consegne.

Formato:

{
 "type":"map",
 "title":"string",
 "markers":[
   {
    "lat":number,
    "lng":number,
    "label":"string",
    "value":number
   }
 ]
}

Non usare mai:
- chart
- chartType
- xAxis
- yAxis
- series
- kpi singoli senza items

Il testo è solo una descrizione breve.
La visualizzazione è la risposta principale.
`;


export async function askAgent(
    conversationId:string,
    messages:any[]
)
{

    const oldMessages = getConversation(conversationId);
    const conversation =  [...oldMessages, ...messages];


    let response =
        await openai.chat.completions.create({

            model:"gpt-4.1-mini",

            messages:[
                {
                    role:"system",
                    content:systemMessage
                },
                ...conversation
            ],

            tools:toolDefinitions,
            tool_choice:"required"

        });

    let message =
        response.choices[0].message;

        console.log(
    "FIRST RESPONSE:",
    JSON.stringify(message,null,2)
);

    if(!message.tool_calls)
    {
        return parseAgentResponse(
            message.content
        );
    }

    conversation.push(message);


    for(const call of message.tool_calls)
    {

        const result =
            await tools[
                call.function.name
            ](
                JSON.parse(
                    call.function.arguments
                )
            );


        conversation.push({

            role:"tool",

            tool_call_id:
                call.id,

            content:
                JSON.stringify(result)

        });

    }


    response =
        await openai.chat.completions.create({

            model:"gpt-4.1-mini",

            messages:[
                {
                    role:"system",
                    content:systemMessage
                },
                ...conversation
            ]

        });

    saveConversation(
        conversationId,
        messages.slice(-10)
    );

    return parseAgentResponse(
        response
            .choices[0]
            .message
            .content
    );

}

function parseAgentResponse(
    content:string | null
):AgentResponse
{

    if(!content)
    {
        return {
            title:"No response",
            summary:"",
            widgets:[]
        };
    }


    try {

        return JSON.parse(content);

    }
    catch(e){

        return {

            title:"Analytics response",

            summary:content,

            widgets:[
                {
                    type:"insight",
                    text:content
                }
            ]

        };

    }

}