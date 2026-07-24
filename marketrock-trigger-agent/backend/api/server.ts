import "dotenv/config";
import express from "express";
import { tasks, runs } from "@trigger.dev/sdk/v3";
import cors from "cors";

const app = express();

app.use(express.json());
app.use(cors());


app.post("/chat", async(req,res)=>{

    const handle = await tasks.trigger(
        "analytics-chat",
        {
            question: req.body.question
        }
    );


    let run;

    do {

        run = await runs.retrieve(handle.id);

        if(run.isSuccess)
        {
            break;
        }


        if(run.isFailed)
        {
            throw new Error(
                "Trigger failed"
            );
        }


        await new Promise(
            resolve => setTimeout(resolve,1000)
        );

    } while(true);

    res.json(
        run.output.response
    );

});


app.listen(
    3001,
    ()=>{
        console.log(
            "API running on 3001"
        );
    }
);