import { task } from "@trigger.dev/sdk/v3";

import { askAgent } from "../ai/agent.js";


export const analyticsChat =
task({

    id: "analytics-chat",

    run: async (
        payload: {
            conversationId: string;
            question: string;
        }
    ) => {


      const response =
        await askAgent(payload.conversationId, [
            {
                role:"user",
                content: payload.question
            }
        ]);


        return {
            response
        };

    }

});