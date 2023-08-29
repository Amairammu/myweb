<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Random Chat</title>
<style>
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background-color: #f2f2f2;
  }

  #chat-container {
    width: 400px;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 20px;
    background-color: #fff;
  }

  #messages {
    max-height: 300px;
    overflow-y: auto;
  }

  #input-message {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 3px;
    margin-top: 10px;
  }

  #send-button {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
  }
</style>
</head>
<body>
<div id="chat-container">
  <div id="messages"></div>
  <input type="text" id="input-message" placeholder="Type your message...">
  <button id="send-button">Send</button>
</div>

<script>
  const messagesContainer = document.getElementById('messages');
  const inputMessage = document.getElementById('input-message');
  const sendButton = document.getElementById('send-button');

  sendButton.addEventListener('click', () => {
    const messageText = inputMessage.value.trim();
    if (messageText !== '') {
      const messageElement = document.createElement('div');
      messageElement.className = 'message';
      messageElement.textContent = messageText;
      messagesContainer.appendChild(messageElement);
      inputMessage.value = '';
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  });

  inputMessage.addEventListener('keydown', (event) => {
    if (event.key === 'Enter') {
      sendButton.click();
    }
  });
</script>
</body>
</html>
