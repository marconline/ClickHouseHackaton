"use client";

import { useState } from "react";
import { useChat } from "@ai-sdk/react";
import { useTriggerChatTransport } from "@trigger.dev/sdk/chat/react";
import type { analyticsAgent } from "../../../backend/trigger/analyticsAgent";
import { mintChatAccessToken, startChatSession } from "@/app/actions";

export function Chat() {
  const transport = useTriggerChatTransport<typeof analyticsAgent>({
    task: "marketrock-analytics",
    accessToken: ({ chatId }) => mintChatAccessToken(chatId),
    startSession: ({ chatId, clientData }) =>
  startChatSession({ chatId, clientData }),
  });

  const { messages, sendMessage, stop, status } = useChat({ transport });

  console.log("STATUS:", status);
console.log("MESSAGES:", messages);

  const [input, setInput] = useState("");

  return (
    <div>
     {messages.map((m) => (
  <div key={m.id}>
    <strong>{m.role}:</strong>

    {m.parts.map((part, i) =>
      part.type === "text" ? (
        <span key={i}>
          {part.text}
        </span>
      ) : null
    )}
  </div>
))}

      <form
        onSubmit={(e) => {
          e.preventDefault();
          if (input.trim()) {
            sendMessage({ text: input });
            setInput("");
          }
        }}
      >
        <input
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder="Type a message..."
        />
        <button type="submit" disabled={status === "streaming"}>
          Send
        </button>
        {status === "streaming" && (
          <button type="button" onClick={stop}>
            Stop
          </button>
        )}
      </form>
    </div>
  );
}