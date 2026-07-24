import { chat } from "@trigger.dev/sdk/ai";
import { analyticsAgent } from "./analyticsAgent.js";


export const chatHandler =
    chat.withUIMessage({
        agent: analyticsAgent
    });