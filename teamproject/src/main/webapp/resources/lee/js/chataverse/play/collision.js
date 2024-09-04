import {MAX_CANVAS_HEIGHT, MAX_CANVAS_WIDTH} from "./constant.js";
export class Collision{
    constructor(){}
    
    //인터넷창 충돌 처리
    BoundaryCollision(object) {
        // 구석에 대한 조건문은 가장 먼저 처리
        if (object.x <= 0 && object.y <= 0) {
            // 왼쪽 상단 구석
            object.x = 0;
            object.y = 0;
        } else if (object.x <= 0 && object.y + object.height >= MAX_CANVAS_HEIGHT) {
            // 왼쪽 하단 구석
            object.x = 0;
            object.y = MAX_CANVAS_HEIGHT - object.height;
        } else if (object.x + object.width >= MAX_CANVAS_WIDTH && object.y <= 0) {
            // 오른쪽 상단 구석
            object.x = MAX_CANVAS_WIDTH - object.width;
            object.y = 0;
        } else if (object.x + object.width >= MAX_CANVAS_WIDTH && object.y + object.height >= MAX_CANVAS_HEIGHT) {
            // 오른쪽 하단 구석
            object.x = MAX_CANVAS_WIDTH - object.width;
            object.y = MAX_CANVAS_HEIGHT - object.height;
        } else if (object.x <= 0) {
            // 왼쪽 벽
            object.x = 0;
        } else if (object.x + object.width >= MAX_CANVAS_WIDTH) {
            // 오른쪽 벽
            object.x = MAX_CANVAS_WIDTH - object.width;
        } else if (object.y <= 0) {
            // 상단 벽
            object.y = 0;
        } else if (object.y + object.height >= MAX_CANVAS_HEIGHT) {
            // 하단 벽
            object.y = MAX_CANVAS_HEIGHT - object.height;
        }
    
        // 충돌 시 플레이어의 이동을 멈추기 위해 dx와 dy를 0으로 설정
        
    }

    //충돌 감지
    isCollision(object, obstacle){
                return object.x < obstacle.x + obstacle.width &&
                object.x + object.width > obstacle.x &&
                object.y < obstacle.y + obstacle.height &&
                object.y + object.height > obstacle.y;    
    }

    // 플레이어와 구조물 충돌 처리 함수
    checkCollisions(object, obstacles){
        for(let obstacle of obstacles){
            let isCollision = this.isCollision(object, obstacle);
            // console.log("충돌 : " + isCollision);
            // if(typeof obstacle == Player){
            //     console.log("object : ", object);
            //     console.log("obstacles : ", obstacles);
            // }
            // console.log("object : ", object);
            // console.log("obstacles : ", obstacles);
            if(isCollision){
            	// console.log("충돌!");
                if(obstacle.isTouchable){
                    let result = this.handlingCollision(object, obstacle);
                    if(result){
                        return result;
                    }
                }   
            }
        }
    }

    //충돌시 처리 함수
    handlingCollision(object, obstacle) {
        // console.log("handlingCollision");
        let dx = object.dx;
        let dy = object.dy;

        let objectX = object.x;
        let objectY = object.y;
        let objectWidth = object.width;
        let objectHeight = object.height
        let objectRight = objectX + objectWidth;
        let objectBottom = objectY + objectHeight;
        let obstacleRight = obstacle.x + obstacle.width;
        let obstacleBottom = obstacle.y + obstacle.height;
        
        // X축 충돌 처리
        if (dx > 0 && objectRight > obstacle.x && objectX < obstacle.x) {
            object.x = obstacle.x - objectWidth; // 플레이어의 오른쪽이 구조물의 왼쪽에 닿음
        } else if (dx < 0 && objectX < obstacleRight && objectRight > obstacleRight) {
            object.x = obstacleRight; // 플레이어의 왼쪽이 구조물의 오른쪽에 닿음  
        }
        // console.log("ox:", object.x);
    
        // Y축 충돌 처리
        if (dy > 0 && objectBottom > obstacle.y && objectY < obstacle.y) {
            object.y = obstacle.y - objectHeight; // 플레이어의 아래쪽이 구조물의 위쪽에 닿음
        }else if (dy < 0 && objectY < obstacleBottom && objectBottom > obstacleBottom) {
            object.y = obstacleBottom; // 플레이어의 위쪽이 구조물의 아래쪽에 닿음
        }

        // if (dx !== 0 && dy !== 0) {
        //     if (Math.abs(object.x - obstacle.x) < Math.abs(object.y - obstacle.y)) {
        //         // Y축 충돌 우선 처리
        //         if (dy > 0) {
        //             object.y = obstacle.y - objectHeight;
        //         } else {
        //             object.y = obstacleBottom;
        //         }
        //     } else {
        //         // X축 충돌 우선 처리
        //         if (dx > 0) {
        //             object.x = obstacle.x - objectWidth;
        //         } else {
        //             object.x = obstacleRight;
        //         }
        //     }
        // }

        // console.log(obstacle.type);
        if(obstacle.type === "car" || obstacle.type === "tent"){
            return obstacle;
        }
    }

    handleCollision(object, obstacles){
        this.BoundaryCollision(object);
        return this.checkCollisions(object, obstacles);
    }
}