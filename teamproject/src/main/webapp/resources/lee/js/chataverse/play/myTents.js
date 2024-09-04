import { BASIC_LENGTH } from "./constant.js";
import { MyItem } from "./myItem.js";
// import { MyObject } from "./myObject.js";
// import { MySlot } from "./mySlot.js";
export class MyTents extends MyItem{
    constructor(data){
        super(data);
        this.speed = data.speed;
        this.isSetup = false;
        this.isSleep = false;
        this.capacity = data.capacity;
        this.selectBars = new Array();

        // this.createSelectBar();
    }

    getItemData(){
        return{
            name : this.name,
            isSetup : this.isSetup,
            isSleep : this.isSleep
        }
    }
    
    setItemData(data){
        super.setItemData();
        //console.log("myTents, setItemData data : ", data);
        this.name = data.name;
        this.isSetup = data.isSetup;
        this.isSleep = data.isSleep;
    }
    
    carry(ctx, player){
        // console.log("들고다니기");
        if(this.capacity === 1){
            if(player.isRight){
                this.x = player.x + player.width;
                this.y = player.y + (player.height-this.height);
            }else{
                this.x = player.x - this.width;
                this.y = player.y + (player.height-this.height);
            }
        }else if(this.capacity === 2){
            if(player.isRight){
                this.x = player.x + player.width;
                this.y = player.y + (player.height-BASIC_LENGTH*3);
            }else{
                this.x = player.x - BASIC_LENGTH*4;
                this.y = player.y + (player.height-BASIC_LENGTH*3);
            }
           
        }
        if(player.isRight){
            ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
        }else{
            ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
        }
       
        
    }

    setup(ctx){
        // console.log("설치");
        // console.log("isSetup : ", this.isSetup);
        if(this.capacity === 1){
            if(this.isRight){
                ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
            }else{
                ctx.drawImage(this.image, this.x, this.y , this.width, this.height);
            }

            if(this.isSleep){
                ctx.fillStyle = "white";
                ctx.font = "20px serif";
                ctx.fontColor = "black"
                ctx.textAlign = "center"
                ctx.textBaseline = "middle"
                ctx.fillText("zZzzZ", this.x + this.width/2, this.y - 25);
            }
        }else if(this.capacity === 2){
            if(this.isRight){
                ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
            }else{
                ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
            }
            if(this.isSleep){
                ctx.fillStyle = "white";
                ctx.font = "20px serif";
                ctx.fontColor = "black"
                ctx.textAlign = "center"
                ctx.textBaseline = "middle"
                ctx.fillText("zZzzZ", this.x + this.width/2, this.y - 25);
            }
        }
    }

    carry2(player){
        console.log("들고다니기");
        console.log("player.isRight : ", player.isRight);
        if(this.capacity === 1){
            if(player.isRight){
                this.x = player.x + player.width;
                this.y = player.y + (player.height-this.height);
            }else{
                this.x = player.x - this.width;
                this.y = player.y + (player.height-this.height);
            }
        }else if(this.capacity === 2){
            if(player.isRight){
                this.x = player.x + player.width;
                this.y = player.y + (player.height-BASIC_LENGTH*3);
            }else{
                this.x = player.x - BASIC_LENGTH*4;
                this.y = player.y + (player.height-BASIC_LENGTH*3);
            }
           
        }
        // ctx.fillStyle = "gray";
        // ctx.fillRect(this.x, this.y, this.width, this.height);
        //    //선그리기
        // ctx.strokeStyle = "block";
        // ctx.lineWidth = 2;
        // ctx.strokeRect(this.x, this.y, this.width, this.height);
        
    }

    setup2(ctx){
        // console.log("설치");
        // console.log("isSetup : ", this.isSetup);
        if(this.capacity === 1){
            // if(this.isRight){
            //     ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
            // }else{
            //     ctx.drawImage(this.image, this.x, this.y , this.width, this.height);
            // }

            // if(this.isSleep){
            //     ctx.fillStyle = "white";
            //     ctx.font = "20px serif";
            //     ctx.fontColor = "black"
            //     ctx.textAlign = "center"
            //     ctx.textBaseline = "middle"
            //     ctx.fillText("zZzzZ", this.x + this.width/2, this.y - 25);
            // }
        }else if(this.capacity === 2){
            // if(this.isRight){
            //     ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
            // }else{
            //     ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
            // }

            // if(this.isSleep){
            //     ctx.fillStyle = "white";
            //     ctx.font = "20px serif";
            //     ctx.fontColor = "black"
            //     ctx.textAlign = "center"
            //     ctx.textBaseline = "middle"
            //     ctx.fillText("zZzzZ", this.x + this.width/2, this.y - 25);
            // }
        }
    }

    update(ctx, player){
        // console.log("텐트 setup : " + this.isSetup)
        if(this.isSetup){
            this.selectBars.forEach(selectBar => {
                selectBar.update(ctx);
            });
            this.setup(ctx);
        }else{
            this.carry(ctx, player);
        }
    }

    update2(player){
        // console.log("텐트 setup : " + this.isSetup)
        if(!this.isSetup){
            this.carry2(player);
        }
    }


}