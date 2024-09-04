import { MyItem } from "./myItem";
import { MyObject } from "./myObject";
import { Collision } from "./collision";
const BASIC_LENGTH = 25;
export class Car extends MyItem{
    //탑승이면 
    // this.x = player.x - BASIC_LENGTH-car.boarder,
    // this.y = player.y - BASIC_LENGTH-car.boarder,
    // car만들고
    car = {
        border : 1,
        seater : 1 // 이건 미구현으로..
    }
    borders = [];
    borderObjects = [];
    constructor(player){
        //나중에 player랑 객체 넣어야됨
        console.log();
        this.name = "pushcart";

        this.x = player.x - BASIC_LENGTH-this.car.border,
        this.y = player.y - BASIC_LENGTH-this.car.border,
        this.width = BASIC_LENGTH*2 + BASIC_LENGTH * 2 * this.car.border;
        this.height = BASIC_LENGTH*2 + BASIC_LENGTH * 2 * this.car.border;
        this.lineColor = "black";
        this.backColor = "gray";
        this.speed = 5; //전체 적용되면 myItem으로
        this.collision = new Collision();
    }

    createBorders(){
        let borderTop = {
            x: this.x,
            y: this.y,
            width : this.width,
            height : BASIC_LENGTH,
            lineColor : this.lineColor,
            backColor : this.backColor,
            speed : this.speed
        }
        let borderRight = {
            x: this.x + this.width - BASIC_LENGTH,
            y: this.y - BASIC_LENGTH,
            width : BASIC_LENGTH,
            height : this.height - BASIC_LENGTH,
            lineColor : this.lineColor,
            backColor : this.backColor,
            speed : this.speed
        }

        let borderLeft = {
            x: this.x,
            y: this.y - BASIC_LENGTH,
            width : BASIC_LENGTH,
            height : this.height - BASIC_LENGTH,
            lineColor : this.lineColor,
            backColor : this.backColor,
            speed : this.speed
        }

        let borderBottom = {
            x: this.x + BASIC_LENGTH,
            y: this.y + this.height - BASIC_LENGTH,
            width : this.width - BASIC_LENGTH*2,
            height : BASIC_LENGTH,
            lineColor : this.lineColor,
            backColor : this.backColor,
            speed : this.speed
        }
        this.borders.push(borderTop);
        this.borders.push(borderRight);
        this.borders.push(borderLeft);
        this.borders.push(borderBottom);
        
        borders.forEach(border => {
            let borderObject = new MyObject(border);
            this.borderObjects.push(borderObject);
        });
    }

    update(ctx, player){
        super.update(ctx);
        borderObjects.forEach(borderObject => {
            borderObject.draw(ctx);
            borderObject.move();
        });

        //플레이어랑 태두리 충돌
        this.collision.handleCollision(player, this.borderObjects);
    }
}