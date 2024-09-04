import { OneBlock } from "./oneBlock.js";
import { BASIC_LENGTH } from "./constant.js"

export class BlockMatrix{
    constructor(data){
        // console.log("BlockMatrix 생성..");
        // console.log(data);
        this.name = data.name,
        this.x = data.x,
        this.y = data.y,
        this.width = BASIC_LENGTH*data.cols;
        this.height = BASIC_LENGTH*data.rows;
        this.cols = data.cols,
        this.rows = data.rows,
        this.backColor = data.backColor,
        this.lineColor = data.lineColor,
        this.blocks = this.getBlocks();
        this.isTouchable = false;
        this.image = null;
        if(data.imageSrc){
            // console.log("data.imageSrc 있음");
            // console.log(data.imageSrc);
            this.image = new Image();
            this.image.src = data.imageSrc;
        }

    }

    getBlocks(){
        let blocks = [];
        for(let row=0; row<this.rows; row++){
            for(let col=0; col<this.cols; col++){
                let block = new OneBlock(
                    this.x + (col* BASIC_LENGTH), 
                    this.y + (row * BASIC_LENGTH), 
                    this.backColor, 
                    this.lineColor);
                blocks.push(block);
            };
        }
        return blocks;
    }

    draw(ctx){
        if(this.image != null && this.image != ""){
            ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
        }else{
            if(this.name != "sea"){
                this.blocks.forEach(block => {
                    block.draw(ctx);
                });
            } 
        }  
    }
}