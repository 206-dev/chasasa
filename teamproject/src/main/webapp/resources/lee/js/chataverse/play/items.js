// import { OneCube } from "./oneCube.js";
// import { CubeMatrix } from "./cubeMatrix.js";

// import { OneCube } from "./oneCube";
import { BASIC_LENGTH } from "./constant.js";
import { MyCars } from "./myCars.js";
import { MyTents } from "./myTents.js";
export class Items{

    constructor(player){
        // console.log("items 호출");
        this.items = new Array()
    
        this.createItems(player);
        // console.log("items : ", this.items);
        // console.log("createItems 후 items : ",this.items);
    }
    createItems(player){
        // console.log("createItems()");
        this.createRearcar(player);
        this.createSmallcar(player);
        this.createNewpapaer(player);
        this.createSmalltent(player);
        // console.log("createItems 후 items : ",this.items);
    }

    createRearcar(player){
        // console.log("createRearcar()");
        let x;
        let y;
        if(player.isRight){
            x = player.x - BASIC_LENGTH;
            y = player.y + BASIC_LENGTH;
        }else{
            x = player.x;
            y = player.y + BASIC_LENGTH;
        }
        let rearcarData = {
            name : "rearcar",
            x : x,
            y : y,
            speed : 4,
            width : player.width + BASIC_LENGTH,
            height : BASIC_LENGTH,
            type : "car",
            srcR : "/resources/lee/image/chabak/image/rearcarR.png",
            srcL : "/resources/lee/image/chabak/image/rearcarL.png",
            isRight : player.isRight,
            capacity : 1
        }
        let rearcar = new MyCars(rearcarData);
        this.items.push(rearcar)
    }

    createSmallcar(player){
        // console.log("createSmallcar()");
        let x;
        let y;
        if(player.isRight){
            x = player.x - BASIC_LENGTH*2;
            y = player.y;
        }else{
            x = player.x - BASIC_LENGTH*2;
            y = player.y;
        }
        let smallcarData = {
            name : "smallcar",
            x : x,
            y : y,
            speed : 8,
            width : player.width*3,
            height : player.height + BASIC_LENGTH,
            type : "car",
            srcR : "/resources/lee/image/chabak/image/smallcarR.png",
            srcL : "/resources/lee/image/chabak/image/smallcarL.png",
            isRight : player.isRight,
            capacity : 2
        }
        let smallcar = new MyCars(smallcarData);
        // console.log("smallcar : ", smallcar);
        this.items.push(smallcar);
    }

    createNewpapaer(player){
        // console.log("createNewpapaer()");
        let x;
        let y;
        if(player.isRight){
            x = player.x + player.width;
            y = player.y + (player.height-BASIC_LENGTH);
        }else{
            x = player.x - BASIC_LENGTH*2;
            y = player.y + (player.height-BASIC_LENGTH);
        }
        let newspaperData = {
            name : "newspaper",
            x : x,
            y : y,
            width : BASIC_LENGTH*2,
            height : BASIC_LENGTH,
            type : "tent",
            src : "/resources/lee/image/chabak/image/newspaper.png",
            isRight : player.isRight,
            capacity : 1
        }
        let newspaper = new MyTents(newspaperData);
        this.items.push(newspaper)
    }

    createSmalltent(player){
        // console.log("createSmalltent()");
        let x;
        let y;
        if(player.isRight){
            x = player.x + player.width;
            y = player.y + (player.height-BASIC_LENGTH*3);
        }else{
            x = player.x - BASIC_LENGTH*4;
            y = player.y + (player.height-BASIC_LENGTH*3);
        }
        let newspaperData = {
            name : "smalltent",
            x : x,
            y : y,
            width : BASIC_LENGTH*4,
            height : BASIC_LENGTH*3,
            type : "tent",
            src : "/resources/lee/image/chabak/image/smalltent.png",
            isRight : player.isRight,
            capacity : 1
        }
        let newspaper = new MyTents(newspaperData);
        this.items.push(newspaper)
    }
    
    getItem(itemName){
        // console.log("getItem(), itemName : ", itemName);
        let item = this.items.find((item) => item.name === itemName);
        // console.log("item : " , item);
        return item; 
    }


    // createSmallcar(){

    // }
    // createNewpaper(){

    // }
    // createSmallcar(){

    // }

}