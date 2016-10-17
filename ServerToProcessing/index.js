var express = require('express');
var app = express();
var server = app.listen(5000, listen)

var data;

app.use(express.static('public'));

app.get('/HelloWorld', function (req, res) {
	res.send('Hello World!');
});

function listen() {
	console.log('App listening on port 3000!')
};

app.get('/CAsequence', function (req, res) {
	res.send(data);
});

var io = require('socket.io')(server);

io.sockets.on('connection', function(socket) {
	console.log("New Client: " + socket.id);

	socket.on('user', function(data) {
		this.data = data;
	});

	socket.on('disconnect', function() {
		console.log("Client has disconnected: " + socket.id);
	});
});