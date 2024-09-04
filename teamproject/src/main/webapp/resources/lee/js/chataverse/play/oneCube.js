import { MyObject } from "./myObject.js"
import { BASIC_LENGTH } from "./constant.js"
export class OneCube extends MyObject{
    constructor(data){
        super(data.x, data.y)
        if(data.name){
            this.name = data.name;
        }
        this.width = BASIC_LENGTH*2,
        this.height = BASIC_LENGTH*2,
        this.backColor = data.backColor,
        this.lineColor = data.lineColor

        //이미지
        this.image = null;
        if(data.image){
            this.image = new Image();
            this.image.src = data.image;
        }
        // console.log("onecube 생성후image : ", this.image);
        // this.imageRsrc = null;
        // this.imageLsrc = null;
        // if(this.imageRsrc !== null){
            
        // }

        if(data.imageRsrc!==null){
            this.imageR = new Image();
            this.imageR.src = data.imageRsrc;
            this.imageL = new Image();
            this.imageL.src = data.imageLsrc;
        }
    
        //스프라이트
        this.spriteImage = null;
        if(data.spriteImage){
            // console.log("data.imageSrc 있음");
            // console.log(data.imageSrc);
            this.spriteImage = new Image();
            this.spriteImage.src = data.spriteImage;

            this.frameWidth = BASIC_LENGTH * 2;
            this.frameHeight = BASIC_LENGTH * 2;
            this.totalFrames = 4;
            this.currentFrame = 0;
            this.frameCount = 0;
            this.animationSpeed = 30;
        }
    }

    updateSprite(){
        this.frameCount++;
        if(this.frameCount >= this.animationSpeed){
            this.currentFrame = (this.currentFrame + 1) % this.totalFrames;
            this.frameCount = 0;
        }
    }

    drawSprite(ctx){
        ctx.drawImage(
            this.spriteImage,
            this.currentFrame * this.frameWidth, 0,
            this.frameWidth, this.frameHeight,
            this.x, this.y,
            this.width, this.height
        );
    }

    drawImage(ctx){
        ctx.drawImage(
            this.image,
            this.x, this.y,
            this.width, this.height
        );
    }

    moveObject(e){
        super.moveObject(e);
    }
    stopObject(e){
        super.stopObject(e);
    }
    
    carry(ctx, player){
        // super.carry(ctx, player);
        if(this.imageR !== null){
            if(player.isRight){
                ctx.drawImage(this.imageR, player.x + this.width, player.y, this.width, this.height);
            }else{
                ctx.drawImage(this.imageL, player.x - this.width, player.y, this.width, this.height);
            }
        }
    }
    
    
    // draw(ctx, player){
    //     console.log("onecube, draw, player: ", player);
    //     super.draw(ctx);
        // let x;
        // if(player !== null){
        //     if(player.isRight){
        //         //오른쪽
        //         x = player.x + this.width;
                
        //         if(type === "car"){
        //             //차
        //         }else{
        //             //텐트
        //         }
        //     }else{
        //         //왼쪽
        //         x = player.x - this.width;
        //     }
        //     //배경그리기
        //     ctx.fillStyle = this.backColor;
        //     ctx.fillRect(x, this.y, this.width, this.height);
        //        //선그리기
        //     ctx.strokeStyle = this.lineColor;
        //     ctx.lineWidth = 2;
        //     ctx.strokeRect(x, this.y, this.width, this.height);
        // }
    // }

    update(ctx){
        // console.log("sprite.....");
        if(this.spriteImage !== null && this.spriteImage !== ""){
            // console.log("스프라이트 이미지 있음");
            this.updateSprite(ctx);
            this.drawSprite(ctx);
        }else if(this.image !== null && this.image !== ""){
            // console.log("oneCube 이미지 있음. 업데이트");
            this.drawImage(ctx);
        }else{
            this.draw(ctx);
        }
    }
}