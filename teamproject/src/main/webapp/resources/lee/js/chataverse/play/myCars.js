import { MyItem } from "./myItem.js";

export class MyCars extends MyItem{
    constructor(data){
        super(data);
        this.speed = data.speed;
        this.isParked = false;
        this.isRight = data.isRight;
        this.capacity = data.capacity;
    }

    getItemData(){
        return{
            name : this.name,
            isParked : this.isParked,
            isRight : this.isRight
        }
    }    
    setItemData(data){
        super.setItemData();
        this.name = data.name;
        this.isParked = data.isParked;
        this.isRight = data.isRight;
    }
    drive(ctx, player){
        // console.log("드라이브");
        if(this.capacity === 1){
            if(player.isRight){
                this.x = player.x - (this.width-player.width);
                this.y = player.y + (player.height-this.height)+10;
            }else{
                this.x = player.x;
                this.y = player.y + (player.height-this.height)+10;
            }
        }else if(this.capacity === 2){
            if(player.isRight){
                this.x = player.x - ((this.width-player.width)/2);
                this.y = player.y;
            }else{
                this.x = player.x - ((this.width-player.width)/2);
                this.y = player.y;
            }
           
        }
        if(player.isRight){
            ctx.drawImage(this.imageR, this.x, this.y, this.width, this.height);
        }else{
            ctx.drawImage(this.imageL, this.x, this.y, this.width, this.height);
        }
          
    }

    park(ctx){
        // console.log("파킹");
        if(this.capacity === 1){
            if(this.isRight){
                ctx.drawImage(this.imageR, this.x, this.y, this.width, this.height);
            }else{
                ctx.drawImage(this.imageL, this.x, this.y, this.width, this.height);
            }
        }else if(this.capacity === 2){
            if(this.isRight){
                ctx.drawImage(this.imageR, this.x, this.y, this.width, this.height);
            }else{
                ctx.drawImage(this.imageL, this.x, this.y, this.width, this.height);
            }
        }
       
    }

    drive2(player){
        // console.log("드라이브");
        // console.log("car x,y : ", this.x, this.y);
        // console.log("player x,y : ", player.x, player.y);
        if(player!==null){
            if(this.capacity === 1){
                if(player.isRight){
                    this.x = player.x - (this.width-player.width);
                    this.y = player.y + (player.height-this.height)+10;
                }else{
                    this.x = player.x;
                    this.y = player.y + (player.height-this.height)+10;
                }
            }else if(this.capacity === 2){
                if(player.isRight){
                    this.x = player.x - ((this.width-player.width)/2);
                    this.y = player.y;
                }else{
                    this.x = player.x - ((this.width-player.width)/2);
                    this.y = player.y;
                }
               
            }

            // ctx.fillStyle = "gray";
            // ctx.fillRect(this.x, this.y, this.width, this.height);
            //    //선그리기
            // ctx.strokeStyle = "black";
            // ctx.lineWidth = 2;
            // ctx.strokeRect(this.x, this.y, this.width, this.height);
        }
    }
    park2(){
        // console.log("파킹");
        if(this.capacity === 1){
            // ctx.fillStyle = "gray";
            // ctx.fillRect(this.x, this.y+10, this.width, this.height);
            //    //선그리기
            // ctx.strokeStyle = "block";
            // ctx.lineWidth = 2;
            // ctx.strokeRect(this.x, this.y+10, this.width, this.height);
        }else if(this.capacity === 2){
            // if(this.isRight){
            //     ctx.drawImage(this.imageR, this.x, this.y, this.width, this.height);
            // }else{
            //     ctx.drawImage(this.imageL, this.x, this.y, this.width, this.height);
            // }
        }
    }

    update(ctx, player){
        // console.log("myCars, update(), player : ", player);
        if(this.isParked){
            this.park(ctx);
        }else{
            this.drive(ctx, player);
        }
    }

    update2(player){
        // console.log("myCars, update(), player : ", player);
        if(this.isParked){
            this.park2(player);
        }else{
            this.drive2(player);
        }
    }

}