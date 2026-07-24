"use client";

import { useState, useEffect } from "react";
import { useChat } from "@ai-sdk/react";
import { useTriggerChatTransport } from "@trigger.dev/sdk/chat/react";
import type { analyticsAgent } from "../../../backend/trigger/analyticsAgent";

import WidgetRenderer from "./WidgetRenderer";

import {
  mintChatAccessToken,
  startChatSession
} from "@/app/actions";


const exampleQuestions = [
  "How's business going?",
  "What are our best-selling products?",
  "Which marketplace generates the most revenue?",
  "Are there any fulfillment issues?",
  "How have our shipping times been over the last month?",
];


const thinkingSteps = [
  "🔎 Analyzing business data...",
  "🧠 Interpreting business metrics...",
  "📊 Creating visualizations...",
  "💡 Generating key insights..."
];


export default function Chat(){


  const transport = useTriggerChatTransport<typeof analyticsAgent>({
    task:"marketrock-analytics",

    accessToken:({chatId}) =>
      mintChatAccessToken(chatId),

    startSession:({chatId,clientData}) =>
      startChatSession({
        chatId,
        clientData
      })
  });


  const {
    messages,
    sendMessage,
    stop,
    status
  } = useChat({
    transport
  });


  const [input,setInput] =
    useState("");


  const [thinkingStep,setThinkingStep] =
    useState(0);


  const [fade,setFade] =
    useState(false);



  const loading =
    status === "streaming";



  useEffect(()=>{

    if(!loading)
    {
      setThinkingStep(0);
      return;
    }


    const timer =
      setInterval(()=>{

        setFade(true);

        setTimeout(()=>{

          setThinkingStep(
            current =>
              (current + 1)
              %
              thinkingSteps.length
          );

          setFade(false);

        },300);


      },1800);


    return ()=>clearInterval(timer);


  },[loading]);



  /*
     Prendo ultima risposta AI
  */

  const lastAssistantMessage =
    [...messages]
      .reverse()
      .find(
        m => m.role==="assistant"
      );


  let answer:any = undefined;


  if(lastAssistantMessage)
  {
    const text =
      lastAssistantMessage.parts
        .filter(p=>p.type==="text")
        .map(p=>p.text)
        .join("");


    try {

      answer =
        JSON.parse(text);

    }
    catch {

      answer = {

        title:"Analytics",

        summary:text,

        widgets:[]

      };

    }
  }




  function send(question?:string){

    const value =
      question ?? input;


    if(!value.trim())
      return;


    sendMessage({
      text:value
    });


    setInput("");

  }





return (

<div
style={{
 maxWidth:1000,
 margin:"40px auto",
 padding:"0 20px"
}}
>


<h1
style={{
fontSize:32,
marginBottom:5
}}
>
Intelligent eCommerce Analytics
</h1>


<p
style={{
color:"#667085"
}}
>
Get insights into your business and visualize insights.
</p>




<div
style={{
marginTop:30,
marginBottom:30
}}
>

<div
style={{
fontSize:14,
color:"#667085",
marginBottom:12
}}
>
Try to ask:
</div>


<div
style={{
display:"flex",
flexWrap:"wrap",
gap:10
}}
>

{
exampleQuestions.map((q,index)=>(

<button
key={index}
onClick={()=>send(q)}
style={{
background:"#fff",
border:"1px solid #ddd",
borderRadius:20,
padding:"10px 16px",
cursor:"pointer"
}}
>
{q}
</button>

))
}

</div>

</div>





{
loading &&

<div
className="card"
style={{
marginBottom:30
}}
>


<div
style={{
display:"flex",
alignItems:"center",
gap:12
}}
>


<div
style={{
width:36,
height:36,
borderRadius:"50%",
background:"#2563eb",
color:"white",
display:"flex",
alignItems:"center",
justifyContent:"center"
}}
>
🤖
</div>


<div>

<h3>
AI Analytics Agent
</h3>


<p
className={
`thinking-text ${fade?"fade":""}`
}
style={{
color:"#667085"
}}
>
{thinkingSteps[thinkingStep]}
<span className="dots">
...
</span>
</p>


</div>

</div>


</div>

}





{
answer &&

<div>

<div className="card">

<h2>
{answer.title}
</h2>


{
answer.summary &&
<p>
{answer.summary}
</p>
}

</div>


{
answer.widgets?.length > 0 &&

<div
style={{
marginTop:24
}}
>

<WidgetRenderer
widgets={answer.widgets}
/>

</div>

}


</div>

}





<div

style={{
position:"sticky",
bottom:20,
marginTop:40,
background:"#fff",
padding:16,
borderRadius:20,
boxShadow:
"0 10px 40px rgba(0,0,0,.12)",
display:"flex",
gap:12
}}

>


<input

value={input}

onChange={
e=>setInput(e.target.value)
}

onKeyDown={
e=>{
 if(e.key==="Enter")
   send();
}
}

placeholder=
"Ask something about your online business..."

style={{
flex:1,
padding:"14px 18px",
borderRadius:12,
border:"1px solid #ddd"
}}

/>



<button

onClick={()=>send()}

style={{
background:"#ff5a1f",
color:"white",
border:"none",
borderRadius:12,
padding:"0 25px",
fontWeight:600
}}

>
Ask
</button>



{
loading &&
<button
type="button"
onClick={stop}
>
Stop
</button>
}


</div>


</div>

);

}