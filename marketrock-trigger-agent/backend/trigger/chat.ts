import { task } from "@trigger.dev/sdk/v3";
import { chat } from "@trigger.dev/sdk/ai";



export const analyticsChat =
task({

    id:"analytics-chat",


    run: async(payload:{

        conversationId:string;

        message:string;

    })=>{


        const result =
            await chat.local({

                agent:
                "marketrock-analytics",

                sessionId:
                payload.conversationId,

                message:
                payload.message

            });


        return result;

    }

});