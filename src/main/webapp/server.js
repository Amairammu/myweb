const http = require('http');
const fs = require('fs');
const path = require('path');
const socketio = require('socket.io');

const server = http.createServer((req, res) => {
    const filePath = path.join(__dirname, 'index.html');
    fs.readFile(filePath, 'utf-8', (err, content) => {
        if (err) {
            res.writeHead(500);
            res.end('Error loading index.html');
        } else {
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(content);
        }
    });
});

const io = socketio(server);

io.on('connection', (socket) => {
    socket.on('message', (message) => {
        io.emit('message', message); // Broadcast the message to all connected clients
    });
});

server.listen(3000, () => {
    console.log('Server listening on port 3000');
});
