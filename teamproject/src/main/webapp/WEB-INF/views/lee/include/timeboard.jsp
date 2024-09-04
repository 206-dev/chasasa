<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/lee/css/timeboard.css">

<script>
	$(function(){
		let timeboardDatas = [
			{
				"name" : "timeboard1",
				"type" : "timeboard-left",
				"src" : "/resources/common/banner/ad1.png"
			  },
			  {
				"name" : "timeboard2",
				"type" : "timeboard-right",
				"src" : "/resources/common/banner/ad2.png"
			  }
		];

		function setTimeboard(){
			timeboardDatas.forEach((timeboardData) => {
			let type = timeboardData.type;
			let src = timeboardData.src;
			switch(type){
			case "timeboard-left" :
					$("#timeboard-left-img").attr("src", src);
					break;
				case "timeboard-right" :
					$("#timeboard-rigth-img").attr("src", src);
					break;
				}
			});
		}
		
		setTimeboard();
	});

</script>
<a class="timeboard-Container lee-left-20">
	<img src="" alt="timeboard-left" id="timeboard-left-img">
</a>
<a class="timeboard-Container lee-right-20">
    <img src="" alt="timeboard-right" id="timeboard-rigth-img">
</a>
 
    