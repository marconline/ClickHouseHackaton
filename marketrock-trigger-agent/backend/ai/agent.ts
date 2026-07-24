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
You are MarketRock's analytics assistant.

System current date:
${today}

Rules:
- When the user uses relative periods such as "today," "this month," or "last 3 months," calculate the dates relative to the system current date.
- Do not use made-up dates.
- Do not invent numbers.
- If the period is not specified, ask for clarification.
- Always use tools to retrieve real data.
- Do not return markdown.
- Do not write long text.

Your job is to transform business data into visual insights.

The response must always be JSON:

{
"title":"",
"summary":"",
"widgets":[]
}

Prefer:
- KPIs for important numbers
- Charts for time comparisons
- Bar charts for rankings
- Tables only if really useful
- Alerts for problems
- Pie charts for data split on different dimensions (eg. orders per marketplace, shippings per carrier)

The response MUST always be valid JSON.

The widgets field must contain only these types:

1) kpi

Format:

{
 "type":"kpi",
 "items":[
   {
    "label":"string",
    "value":number,
    "currency":"string optional"
   }
 ]
}


2) line_chart

Format:

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

Format:

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

Format:

{
 "type":"table",
 "title":"string",
 "columns":["string"],
 "rows":[{}]
}

5) insight

Format:

{
 "type":"insight",
 "title":"string",
 "text":"string",
 "severity":"positive|negative|neutral"
}

6) pie_chart

Use it when you want to show a percentage breakdown or distribution across categories, marketplaces, currencies, countries, or segments.

Format:

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

Use it to show an indicator compared to a previous period.

Format:

{
 "type":"metric",
 "label":"string",
 "value":number,
 "unit":"string optional",
 "currency":"string optional",
 "trend":number,
 "trendLabel":"string optional"
}

8) number_card

Use it to highlight a single important value.

Format:

{
 "type":"number_card",
 "label":"string",
 "value":number,
 "unit":"string optional",
 "currency":"string optional"
}

Never use:
- chart
- chartType
- xAxis
- yAxis
- series
- kpi singoli senza items

The text is just a short description.
The visualization is the primary response.
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