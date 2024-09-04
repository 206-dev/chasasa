import { MyObject  } from "./myObject.js";
const BASIC_LENGTH = 25;
export class OneBlock extends MyObject{
    constructor(x, y, backColor, lineColor){
        super();
        this.x = x;
        this.y = y;
        this.width = BASIC_LENGTH;
        this.height = BASIC_LENGTH;
        this.backColor = backColor;
        this.lineColor = lineColor;
    }
}