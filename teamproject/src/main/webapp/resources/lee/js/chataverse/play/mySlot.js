import { OneCube } from "./oneCube.js";
export class MySlot extends OneCube{
    constructor(data){
        super(data);
        this.type = data.type;
        this.name = data.name
        if(data.text){
            this.text = data.text;
        }
    }

    setPositon(x, y){
        this.x = x;
        this.y = y;
    }

    draw(ctx){
        super.draw(ctx);
        if(this.text){
            ctx.fillStyle = "black";
            ctx.font = "16px serif";
            ctx.fontColor = "black"
            ctx.textAlign = "center"
            ctx.textBaseline = "middle"
            ctx.fillText(this.text, this.x + this.width/2, this.y + this.height/2);
        }
    }
}