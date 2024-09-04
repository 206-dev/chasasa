 $(function(){
	const CANVAS = $("#LOADING_CANVAS")[0];
	const CTX = CANVAS.getContext('2d');
	CANVAS.width = 50;
	CANVAS.height = 50;

	const IMAGE = new Image();
	IMAGE.src = "/resources/lee/image/chabak/sprite/witchRight.png";

	const FRAME_WIDTH = 50;
	const FRAME_HEIGHT = 50;
	const TOTAL_FRAMES = 4;
	let current_frame = 0;
	let frame_count = 0;
	const ANIMATION_SPEED = 10;

	function updateSprite(){
		frame_count++;
		if(frame_count >= ANIMATION_SPEED){
			frame_count = 0;
			current_frame = (current_frame + 1) % TOTAL_FRAMES;
		}
	}

	function drawSprite(){
		CTX.drawImage(
			IMAGE,
			current_frame * FRAME_WIDTH, 0,
			FRAME_WIDTH, FRAME_HEIGHT,
			0, 0,
			CANVAS.width, CANVAS.height
		);
	}

	function update(){
		CTX.clearRect(0,0, CANVAS.width, CANVAS.height);
		updateSprite();
		drawSprite();
	}

	function loop(){
		update();
		requestAnimationFrame(loop);		
	};
	IMAGE.onload = function (){
		loop();		
	};
	
	let loadingBar = $("#loadingBar");
	let loadingText = $("#loadingText")
	let width = 0;
	
	let region = $("#regionInput").val();
	console.log("region : ", region); 
	
	function updateLoadingBar(){
		if(width >= 100){
			clearInterval(loadingInterval);
			location.href = "/lee/chataverse/play/" + region;
		}else{
			width++;
			loadingBar.width(width + "%");
			loadingText.html(width + "%");
		}
	}
	
	let loadingInterval = setInterval(updateLoadingBar, 20);
});