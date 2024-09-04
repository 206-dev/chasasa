import { MyObject } from "./myObject.js";
import { BASIC_LENGTH } from "./constant.js"
export class MyItem extends MyObject{

    constructor(data){
        super(data.x, data.y);
        this.name = data.name;
        this.width = data.width;
        this.height = data.height;
        
        this.type = data.type;
        this.isRight = true;

        if(data.imageR !== null){
            this.imageR = new Image();
            this.imageR.src = data.srcR;
            this.imageL = new Image();
            this.imageL.src = data.srcL;
        }     
        if(data.src !==null){
            this.image = new Image();
            this.image.src = data.src;
        }
        
       
    }//construct

    setItemData(){}
}

