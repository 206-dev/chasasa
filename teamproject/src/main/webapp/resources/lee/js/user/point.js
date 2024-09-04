const START_POINT = 100;
const GROWTH_RATE = 1.1;
const PERCENT = 0.01;
function showLevelInfo(userid){
	// console.log("showLevelInfo,,  userid: ", userid);
	if(userid !== "" && userid !== null){
		let url = "/lee/user/getLevelInfo/" + userid;
		// console.log("url : " + url);
		$.ajax({
			type : "get",
			url : url,
			success : function(rData){
				// console.log(rData);
				let level = rData.userlevel;
				let point = rData.point;
				let profile = rData.profile
				// console.log("level : " + level);
				// console.log("point : " + point);
				
				let points = getNeedPoints(level, START_POINT);
				let nextPoint = points.nextPoint;
				let prePoint = points.prePoint;
				
				let needPoint = nextPoint - prePoint;
				
				let percent = getCurPer(point-prePoint, needPoint);
				
				showExp(level, point, nextPoint, profile);
				drawExpBar(percent);
			}
		});
	}
}

//nextpoint prepoint 구하기
function getNeedPoints(level, START_POINT){
	// console.log("getNextPoint........")
	let prePoint = 0;
	let incresePoint = START_POINT;
	let nextPoint = START_POINT;
	for(let i=1; i<level; i++){
		incresePoint = Math.floor(incresePoint*GROWTH_RATE);
 		nextPoint = incresePoint + nextPoint;
 		prePoint = nextPoint - incresePoint;
	};
	return {nextPoint, prePoint};
};

//텍스트 보여주기
function showExp(level, point, nextPoint, profile){
	const MY_POINT = $("#my_point");
	const NEXT_POINT = $("#next_point");
	const PROFILE_LEVEL = $("#profile_level");
	PROFILE_LEVEL.html(level);
	MY_POINT.html(point);
	NEXT_POINT.html(nextPoint);
	//console.log("profile : " + profile);
	if(profile == null){
		console.log("profile 널");
		profile = "/resources/lee/image/empty_profile.jpg";
		$("#login-profile-img").attr("src", profile);
	}else{
		//console.log("profile 안널");
		$("#login-profile-img").attr("src", profile);
	}
}

//현재 경험치 퍼센트 구하기
function getCurPer(point, needPoint){
	let percent = Math.floor(point * needPoint * PERCENT);
	if(percent > 100){
		percent = 100;
	}
	return percent;
}

//경험치바 그리기
function drawExpBar(percent){
		// console.log("drawExpBar....................");
		// console.log("percent : " + percent);
	const DIV_EXP = $("#div_exp");
	let strPercent = String(percent) + "%";
		
	if(percent < 40){
		DIV_EXP.css("border-radius", "10px 0 0 10px;");
	}else if(percent > 80 && percent != 100){
// 		DIV_EXP.css("border-radius", "6px 0 0 6px")
	}else if(percent == 100){
		DIV_EXP.css("border-radius", "8px");
	}
// 	percent
	DIV_EXP.width(strPercent);
}