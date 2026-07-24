import { useState } from "react";
import { ask } from "../api/chat";
import WidgetRenderer from "./WidgetRenderer";
import { useEffect } from "react";

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



export default function ChatBox(){

    const [question,setQuestion] =
        useState("");

    const [answer,setAnswer] =
        useState<any>();

    const [loading,setLoading] =
        useState(false);

    const [conversationId] =
        useState(()=>{

            let id =
                localStorage.getItem(
                    "mr_conversation_id"
                );


            if(!id)
            {
                id =
                crypto.randomUUID();

                localStorage.setItem(
                    "mr_conversation_id",
                    id
                );
            }


            return id;

        });

    const [thinkingStep, setThinkingStep] =
        useState(0);

    const [fade, setFade] = useState(false);

    useEffect(() => {

        if (!loading) {
            setThinkingStep(0);
            return;
        }

        const timer = setInterval(() => {

            setFade(true);

            setTimeout(() => {

                setThinkingStep(current =>
                    (current + 1) % thinkingSteps.length
                );

                setFade(false);

            }, 300);

        }, 1800);

        return () => clearInterval(timer);

    }, [loading]);

    async function send(
        questionOverride?:string
    ){

        const currentQuestion =
            questionOverride ?? question;


        if(!currentQuestion.trim())
            return;

        setQuestion("");
        setLoading(true);

        setAnswer(undefined);


        try {

            const result =
                await ask(conversationId, currentQuestion);

            setAnswer(result)
        }

        catch(error){

            console.error(error);

            setAnswer({

                title:"Errore",

                summary:
                    "Si è verificato un errore durante l'analisi.",

                widgets:[]

            });

        }

        finally {

            setLoading(false);

        }

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

                    color:"#667085",

                    marginTop:0

                }}
            >
                Get insights into your business and visualize insights.
            </p>



            {/* Esempi */}

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
                        exampleQuestions.map(
                            (q,index)=>(

                                <button

                                    key={index}

                                    onClick={()=>
                                        send(q)
                                    }

                                    style={{

                                        background:"#fff",

                                        border:
                                            "1px solid #ddd",

                                        borderRadius:20,

                                        padding:
                                            "10px 16px",

                                        cursor:"pointer",

                                        fontSize:14

                                    }}

                                >

                                    {q}

                                </button>

                            )
                        )
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

                        gap:12,

                        marginBottom:20

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

                        justifyContent:"center",

                        fontSize:20,

                        animation:"pulse 1.5s infinite"

                    }}
                    >
                    🤖
                    </div>


                    <div>

                    <h3
                    style={{
                        margin:0
                    }}
                    >
                    AI Analytics Agent
                    </h3>


                    <p
    className={`thinking-text ${fade ? "fade" : ""}`}
    style={{
        marginTop:8,
        color:"#667085"
    }}
>
                    {thinkingSteps[thinkingStep]}

                    <span className="dots">
                    ...</span>

                    </p>


                    </div>


                    </div>


                </div>

            }





            {
                answer &&

                <div>


                    <div
                        className="card"
                    >

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
                        answer.widgets &&

                        <div
                            style={{

                                marginTop:24

                            }}
                        >

                            <WidgetRenderer

                                widgets={
                                    answer.widgets
                                }

                            />

                        </div>

                    }


                </div>

            }




            {/* Input */}

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


                    value={question}


                    onChange={
                        e =>
                        setQuestion(
                            e.target.value
                        )
                    }


                    onKeyDown={
                        e => {

                            if(e.key==="Enter")
                                send();

                        }
                    }


                    placeholder=
                        "Ask something about your online business..."


                    style={{

                        flex:1,

                        padding:
                            "14px 18px",

                        borderRadius:12,

                        border:
                            "1px solid #ddd",

                        fontSize:16

                    }}

                />



                <button

                    onClick={()=>
                        send()
                    }


                    style={{

                        background:
                            "#ff5a1f",

                        color:
                            "white",

                        border:"none",

                        borderRadius:12,

                        padding:
                            "0 25px",

                        fontWeight:600,

                        cursor:"pointer"

                    }}

                >

                    Ask

                </button>


            </div>


        </div>

    );

    
}