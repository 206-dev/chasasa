import { MyObject } from "./myObject.js";
import { BASIC_LENGTH } from "./constant.js";
export class Player extends MyObject{
    constructor(player, userId, nickname, gender){
        super(player.x, player.y);
        console.log("player 생성......................");
        console.log("input userId : ", userId);
        this.width = BASIC_LENGTH * 2;
        this.height = BASIC_LENGTH * 2;
  
        this.userId = userId;
        console.log("this.userId : ", this.userId);
        this.nickname = nickname;
        this.gender = gender;

        this.isOpenMenu = false;
        this.control = true;
        this.isCarry = false;
        this.isSleep = false;
        this.isRight = true;

        this.isTouchable = true;

        //스프라이트
        this.spriteRightImage = new Image();
        this.spriteLeftImage = new Image();
        this.spriteStandRImage = new Image();
        this.spriteStandLImage = new Image();
        // console.log("player Gender : ",this.gender);
        if(this.gender === "M"){
            this.spriteRightImage.src = "/resources/lee/image/chabak/sprite/manR.png";
            this.spriteLeftImage.src = "/resources/lee/image/chabak//sprite/manL.png";
            this.spriteStandRImage.src = "/resources/lee/image/chabak//sprite/manStandR.png";
            this.spriteStandLImage.src = "/resources/lee/image/chabak//sprite/manStandL.png";
        }else{
            this.spriteRightImage.src = "/resources/lee/image/chabak/sprite/witchRight.png";
            this.spriteLeftImage.src = "/resources/lee/image/chabak//sprite/witchLeft.png";
            this.spriteStandRImage.src = "/resources/lee/image/chabak//sprite/witchStandR.png";
            this.spriteStandLImage.src = "/resources/lee/image/chabak//sprite/witchStandL.png";
        }
        this.frameWidth = BASIC_LENGTH * 2;
        this.frameHeight = BASIC_LENGTH * 2;
        this.totalFrames = 4;
        this.currentFrame = 0;
        this.frameCount = 0;
        this.animationSpeed = 10;
    }
   
    updateSprite(){
        this.frameCount++;
        if(this.frameCount >= this.animationSpeed){
            this.currentFrame = (this.currentFrame + 1) % this.totalFrames;
            this.frameCount = 0;
        }
    }

    drawSprite(ctx){
        let spriteImage;
        if(this.dx > 0 || this.dy !== 0 && this.isRight){
            spriteImage = this.spriteRightImage;
        }else if(this.dx < 0 || this.dy !== 0 && !this.isRight){
            spriteImage = this.spriteLeftImage;
        }else if(this.dx==0){
            if(this.isRight){
                spriteImage = this.spriteStandRImage;
            }else{
                spriteImage = this.spriteStandLImage;
            }
        }
        if(spriteImage!==null && spriteImage !== ""){
        	// console.log("drawSprite");
        	ctx.drawImage(
	            spriteImage,
	            this.currentFrame * this.frameWidth, 0,
	            this.frameWidth, this.frameHeight,
	            this.x, this.y,
	            this.width, this.height
     	   );
        }

    }
    getPlayData(){
        return {
            x : this.x,
            y : this.y,
            dx: this.dx,
            dy: this.dy,
            isRight : this.isRight,
            isSleep : this.isSleep,
            isTouchable : this.isTouchable
        }
    }

    setPlayData(data, id){
        // console.log("player setPlayData()..............................");
        // console.log("my Id : ", this.userId);
        // console.log("otehr player Id : ", id);
        if(this.userId){
            if(this.userId === id){
                this.x = data.x;
                this.y = data.y;
                this.dx = data.dx;
                this.dy = data.dy;
                this.isRight = data.isRight;
                this.isSleep = data.isSleep;
                this.isTouchable = data.isTouchable
            }
        }  
    }

    setMyData(data){
        this.x = data.x;
                this.y = data.y;
                this.dx = data.dx;
                this.dy = data.dy;
                this.isRight = data.isRight;
                this.isSleep = data.isSleep;
                this.isTouchable = data.isTouchable
    }

    update(ctx){
        // this.draw(ctx);
        this.updateSprite();
        // this.itemsUpdate(ctx, this);
        if(this.control){
            this.move();
        }
        if(!this.isSleep){
            this.drawSprite(ctx);

            ctx.strokeStyle = "white";
            ctx.font = "20px serif";
            ctx.fontColor = "black"
            ctx.textAlign = "center"
            ctx.textBaseline = "middle"
            ctx.strokeText(this.nickname, this.x + this.width/2, this.y - 15);
        }
    }

    update2(ctx){
        this.updateSprite();
        if(!this.isSleep){
            this.drawSprite(ctx);

            ctx.strokeStyle = "white";
            ctx.font = "20px serif";
            ctx.fontColor = "black"
            ctx.textAlign = "center"
            ctx.textBaseline = "middle"
            ctx.strokeText(this.nickname, this.x + this.width/2, this.y - 15);
        }
    }

    
}