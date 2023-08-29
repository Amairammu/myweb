<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Creative Chloe's Chat Corner</title>
    <link
      href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.3/dist/tailwind.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background: linear-gradient(#bde1ff, #ffe8c4);
      }
    </style>
  </head>
  <body>
    <div class="bg-white p-5 shadow-lg mb-10 flex flex-wrap justify-center items-center w-full">
      <h1 class="font-bold text-3xl">Creative Chloe's Chat Corner</h1>
    </div>
    <div class="flex justify-center mx-auto">
      <div class="px-2 w-full max-w-2xl">
        <div id="chatbox" class="flex flex-col items-start flex-grow overflow-y-scroll h-64 rounded-lg border-2 border-gray-300 bg-white"></div>
        <div class="flex flex-row my-5">
          <input
            class="shadow flex-grow rounded p-2 mr-2 text-black my-2"
            id="messageInput"
            type="text"
          />
          <button
            class="bg-yellow-500 hover:bg-yellow-600 rounded py-2 px-4 text-white font-bold"
            id="sendButton"
          >
            Paint Your Message
          </button>
        </div>
      </div>
    </div>
    <script>
      const chatbox = document.getElementById("chatbox");
      const messageInput = document.getElementById("messageInput");
      const sendButton = document.getElementById("sendButton");
      const chatId = crypto.randomUUID();

      let receiving = false;
      const systemPrompt = "You are Creative Chloe, an imaginative and artistic chatbot who thrives on sparking creativity in users. With a whimsical and poetic tone, engage in brainstorming sessions, help users generate ideas, and provide feedback on creative projects. Encourage users to embrace their artistic side and think outside the box in areas like writing, design, music, and art.";

      function createMessageElement(text, alignment) {
        const messageElement = document.createElement("div");

        messageElement.className = `inline-block my-2.5 p-2.5 rounded border ${
          alignment === "left" ? "border-blue-400 bg-blue-200 self-start" : "border-green-400 bg-green-200 self-end"
        }`;
        messageElement.textContent = text;
        return messageElement;
      }

      function connectWebSocket(message) {
        receiving = true;
        const url = "wss://backend.buildpicoapps.com/api/chatbot/chat";
        const websocket = new WebSocket(url);

        websocket.addEventListener("open", () => {
          websocket.send(
            JSON.stringify({
              chatId: chatId,
              appId: "clearly-wish",
              systemPrompt: systemPrompt,
              message: message,
            })
          );
        });

        const messageElement = createMessageElement("", "left");
        chatbox.appendChild(messageElement);

        websocket.onmessage = (event) => {
          messageElement.innerText += event.data;
          chatbox.scrollTop = chatbox.scrollHeight;
        };

        websocket.onclose = (event) => {
          if (event.code === 1000) {
            receiving = false;
          } else {
            messageElement.textContent += "Error getting response from server. Refresh the page and try again.";
            chatbox.scrollTop = chatbox.scrollHeight;
            receiving = false;
          }
        };
      }

      sendButton.addEventListener("click", () => {
        if (!receiving && messageInput.value.trim() !== "") {
          const messageText = messageInput.value.trim();
          messageInput.value = "";
          const messageElement = createMessageElement(messageText, "right");
          chatbox.appendChild(messageElement);
          chatbox.scrollTop = chatbox.scrollHeight;

          connectWebSocket(messageText);
        }
      });

      messageInput.addEventListener("keydown", (event) => {
        if (
          event.key === "Enter" &&
          !receiving &&
          messageInput.value.trim() !== ""
        ) {
          event.preventDefault();
          sendButton.click();
        }
      });
    </script>
  </body>
</html>
