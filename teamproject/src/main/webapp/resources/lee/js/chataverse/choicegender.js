$(function(){
	let gender = "";
	let url = "/lee/chataverse/choiceGenderRun/";
	$("#btnMan").click(function(){
		console.log("남자");
		gender = "M";
		url = url + gender;
		window.location.href = url;
	});
	$("#btnWoman").click(function(){
		console.log("여자");
		gender = "W";
		url = url + gender;
		window.location.href = url;
	});
});