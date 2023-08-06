<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.3/dist/tailwind.min.css" rel="stylesheet">
    <title>Wanderlust Companion</title>
    <style>
        body {
            font-family: 'Courier New', monospace;
            background-image: url('https://png.pngtree.com/back_origin_pic/03/88/06/20451a964fa12319a324f2e99aac9632.jpg');
            background-size: cover;
            background-position: center;
        }
        h1, p, label, button {
            font-size: 18px;
        }
    </style>
</head>
<body class="bg-gray-200 min-h-screen">
    <div class="container mx-auto p-4">
        <h1 class="text-4xl text-center my-10">Wanderlust Companion</h1>
        <form id="travelForm" class="bg-white rounded-lg p-6">
            <div class="mb-4">
                <label for="place" class="block mb-2">Place to travel:</label>
                <input type="text" id="place" name="place" class="form-input w-full px-4 py-2 border rounded-lg" required>
            </div>
            <div class="mb-4">
                <label for="days" class="block mb-2">How many days:</label>
                <input type="number" id="days" name="days" class="form-input w-full px-4 py-2 border rounded-lg" required>
            </div>
            <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg">Let the adventure begin!</button>
        </form>
        <div id="output" class="bg-white text-black mt-6 p-4 rounded-lg break-all leading-7"></div>
        <footer class="text-center mt-8 text-black">
            <a href="#" class="text-xl">Made with ❤️</a>
        </footer>
    </div>
    <script>
        const form = document.getElementById("travelForm");
        const output = document.getElementById("output");

        form.addEventListener("submit", (e) => {
            e.preventDefault();
            const place = form.elements["place"].value;
            const days = form.elements["days"].value;
            
            const substitutedPrompt = `Create a personalized and unforgettable travel itinerary for ${place} for a duration of ${days} days, tailored to the traveler's interests, budget, and pace. Provide real-time recommendations, local insights, and must-visit attractions to make their journey truly memorable.`;
            
            console.log(substitutedPrompt);
            output.textContent = '';
            
            const ws = new WebSocket(`wss://backend.buildpicoapps.com/ask_ai_streaming?app_id=box-begin&prompt=${encodeURIComponent(substitutedPrompt)}`);

            ws.addEventListener("message", (event) => {
                console.log(event.data);
                output.innerText = `${output.innerText}${event.data}`;
            });

            ws.addEventListener("close", (event) => {
                console.log("Connection closed", event.code, event.reason);
                if (event.code != 1000) {
                    alert("Oops, we ran into an error. Refresh the page and try again.");
                }
            });

            ws.addEventListener("error", (error) => {
              console.log('WebSocket error', error);
              alert("Oops, we ran into an error. Refresh the page and try again.");
            });
        });
    </script>
</body>
</html>
