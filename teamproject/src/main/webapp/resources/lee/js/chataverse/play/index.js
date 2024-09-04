import  { MyUser } from "./myUser.js";
// import { Collision } from "./collision.js";/
import { MatrixManager } from "./matrixManager.js";
import {MAX_CANVAS_WIDTH, MAX_CANVAS_HEIGHT, BASIC_LENGTH}  from "./constant.js"
$(function(){
    
    //캔버스
    const canvas = $("#canvas")[0];
    const ctx = canvas.getContext('2d');
    // const MAX_CANVAS_HEIGHT = 900;
    // const MAX_CANVAS_WIDTH = 1900;
    canvas.width = MAX_CANVAS_WIDTH ;
    canvas.height = MAX_CANVAS_HEIGHT;


    //구조 관리
    let matrixManager = new MatrixManager();

    //배경 구조
    let obstacles = matrixManager.getObstacles();
    //유저생성
    let user = new MyUser(obstacles);
 
    //업데이트********************************
    function update(){
        //화면초기화
        ctx.clearRect(0,0, canvas.width, canvas.height);
        //배경들 그리기
        matrixManager.update(ctx);
        //플레이어 업데이트 + 플레이어 그리기
        user.update(ctx);
    }

    // 게임 루프
    function loop(){
        update();
        requestAnimationFrame(loop);
    };
    loop();
});