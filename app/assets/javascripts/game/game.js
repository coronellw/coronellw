// regular canvas
var canvas, context;
// createjs variables
var stage;

function initGameModule(){
	console.log("Initializing game module...");
	var contenedor = document.getElementById("contenedor");
	canvas = document.createElement("canvas");
	canvas.height = 480;
	canvas.width = 640;
	context = canvas.getContext("2d");
	contenedor.appendChild(canvas);

	initListeners();
	console.log("Game module loaded...");
}

function initListeners(){
	// canvas.addEventListener();
}
