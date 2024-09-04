import { MyVector } from "./myVector.js";
import { BASIC_LENGTH } from "./constant.js"
export class MyObject extends MyVector {
    constructor(x, y){
        super();
        this.x = x;
        this.y = y;
        this.width = BASIC_LENGTH,
        this.height = BASIC_LENGTH;
        this.backColor = "gray";
        this.lineColor = "black";

        this.isTouchable = false;
        this.control = false;
        this.speed = 2;

        this.moveObject = this.moveObject.bind(this);
        this.stopObject = this.stopObject.bind(this);
        window.addEventListener('keydown', this.moveObject);
        window.addEventListener('keyup', this.stopObject);
       
    }

    // 키핸들러
    moveObject(e){
        if(["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight", " "].includes(e.key)){
            e.preventDefault();
        };
        if(this.control){
            switch(e.key){
                case 'ArrowUp' :
                case 'W' :
                case 'w' :
                    this.dy = - this.speed        
                    break;
                case 'ArrowDown' :
                case 'S' :
                case 's' :
                    this.dy = this.speed        
                    break;
                case 'ArrowLeft' :
                case 'A' :
                case 'a' :
                    // console.log("오브젝트 좌 , e : ", e);
                    this.dx = - this.speed    
                    this.isRight = false;      
                    break;
                case 'ArrowRight' :    
                case 'D' :
                case 'd' :
                    // console.log("오브젝트 우 , e : ", e);
                    this.dx = this.speed  
                    this.isRight = true;      
                    break;
                case " " :
                    break;
            }
        }
        
    }

    stopObject(e){
        switch(e.key){
            case 'ArrowUp' :
            case 'ArrowDown' :
            case 'W' :
            case 'w' :
            case 'S' :
            case 's' :
                this.dy = 0;       
                break;
            case 'ArrowLeft' :
            case 'ArrowRight' :
            case 'A' :
            case 'a' :
            case 'D' :
            case 'd' :
                this.dx =0;     
                break;
        }
    }
 

    move(){
        if(this.control){
            this.x += this.dx;
            this.y += this.dy;
            // console.log("myObject, x, y :" + this.x + ", " + this.y);
        }
    }

    draw(ctx){
        //배경그리기
        ctx.fillStyle = this.backColor;
        ctx.fillRect(this.x, this.y, this.width, this.height);
           //선그리기
        ctx.strokeStyle = this.lineColor;
        ctx.lineWidth = 2;
        ctx.strokeRect(this.x, this.y, this.width, this.height);
    }

    drawImage(ctx){
        ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
    }
    
    update(ctx){
        if(this.image){
            this.drawImage(ctx);
        }else{
            // console.log("업데이트.. 드로우");
            this.draw(ctx);
        }

    }

}