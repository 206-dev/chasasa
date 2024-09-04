$(function(){
	
	//취소버튼 클릭
	//$("#btnList").click(function(){
	//	console.log("취소버튼");
	//	$("#actionForm").submit();
	//});
		
	//삭제버튼 클릭
	$("#btnDelete").click(function(){
		console.log("삭제버튼");
		let choice = confirm("정말 삭제할꺼에요?");
		console.log("choice : " + choice);
		if(choice){
			//삭제
			console.log("삭제처리");
			$("#formDelete").prepend($("#actionForm > input"));
			$("#formDelete").submit();
		};
	});
});



//시간
function toDateString(milli){
	let d = new Date(milli);
	let year = d.getFullYear();
	let month = make2digits(d.getMonth() + 1);
	let date = make2digits(d.getDate());
	let hour = make2digits(d.getHours());
	let minute = make2digits(d.getMinutes());
	let second = make2digits(d.getSeconds());
	return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
};

function make2digits(val){
	return (val < 10) ? "0" + val : val;
};

