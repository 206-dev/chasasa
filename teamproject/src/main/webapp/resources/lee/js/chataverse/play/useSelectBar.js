
import { BASIC_LENGTH } from "./constant.js";
import { MySlot } from "./mySlot.js";
const USESELECTBAR_WDITH = (BASIC_LENGTH*2 * 3) + (10*3);
const USESELECTBAR_HEIGHT = (BASIC_LENGTH*2) + (10*2);
export class UseSelectBar{
    constructor(player){
        this.x = player.x + player.width/2 - (USESELECTBAR_WDITH/2);
        this.y = player.y - USESELECTBAR_HEIGHT - 10;

        this.width = USESELECTBAR_WDITH;
        this.height = USESELECTBAR_HEIGHT;
        this.backColor = "lightgray";
        this.lineColor = "black";

        this.isOpen = false;

        this.slotList = new Array
        this.selectedIndex = 0;
        this.selectResult = ["sleep", "carry", "cancle"]

        // console.log(this);
        this.createSelectBar();
    }

    createSelectBar(){
        // this.createBack()
        this.createSleepSlot();
        this.createCarrySlot();
        this.createCancleSlot()
        this.createSelectSlot()
        // this.createCancleSlot();
        // this.createSelectSlot();
    }
    
    /////////// 슬롯 ///////////
    // sleep 슬롯
    createSleepSlot(){
        let x = this.x + 10;
        let y = this.y + 10;
        let sleepSlotData = {
            x : x,
            y : y,
            backColor : "white",
            lineColor : "gray",
            text : "잠자기",
            name : "sleep"
        }
        this.sleepSlot = new MySlot(sleepSlotData);
        this.slotList.push(this.sleepSlot);
    }

    // carry 슬롯
    createCarrySlot(){
       let x = this.x + 10 + BASIC_LENGTH*2 + 5;
       let y = this.y + 10;
       let carrySlotData = {
           x : x,
           y : y,
           backColor : "white",
           lineColor : "gray",
           text : "옮기기",
           name : "carry"
       }
       this.carrySlot = new MySlot(carrySlotData);
       this.slotList.push(this.carrySlot);
    }

    // cancle 슬롯
    createCancleSlot(){
       let x = this.x + 10 + BASIC_LENGTH*4 + 5*2;
       let y = this.y + 10;
       let cancleSlotData = {
           x : x,
           y : y,
           backColor : "white",
           lineColor : "gray",
           text : "X",
           name : "cancel"
       }
       this.cancleSlot = new MySlot(cancleSlotData);
       this.slotList.push(this.cancleSlot);
    }

     // select 슬롯
    createSelectSlot(){
        let x = this.x + 10;
        let y = this.y + 10;
        let selectSlotData = {
            x : x,
            y : y,
            backColor : "rgba(255, 217, 0, 0.1)",
            lineColor : "rgb(255, 235, 59)",
            name : "select"
        }
        this.selectSlot = new MySlot(selectSlotData);
        this.selectSlot.control = true;
        this.slotList.push(this.selectSlot);
      
    }

    // select//////////////////////////////////////////
    selectSlotMove(e) {
        // this.moveSelectSlot(e);
        // 방향키로 메뉴 선택
        // console.log("메뉴 셀렉트 키 입력");
        // console.log(this.carItems.length, this.tentIndex.length)
        if(this.selectSlot.control){
            // console.log("셀렉트 슬롯 move");
            switch (e.key) {
                case 'ArrowRight' :
                case 'D' :
                case 'd' :
                    // console.log("셀렉트 오른쪽키");
                    this.selectedIndex = (this.selectedIndex + 1) % 3;
                    break;
                case 'ArrowLeft' :
                case 'A' :
                case 'a' :
                    // console.log("셀렉트 왼쪽키");
                    this.selectedIndex = (this.selectedIndex - 1 + 3) % 3;
                    break;
                case 'ArrowDown' :
                case 'S' :
                case 's' :
                    this.selectSlot.dy = 0;
                case 'ArrowUp' :
                case 'W' : 
                case 'w' :
                    this.selectSlot.dy = 0;
            }
            this.selectSlot.x = (this.x + 10) + ((BASIC_LENGTH*2+5)*this.selectedIndex);
        }
        
        this.selectSlot.control = false;
    }

    moveSelectSlot(e){
        this.selectSlot.moveObject(e);
        this.selectSlotMove(e);
    }
    stopSelectSlot(e){
        this.selectSlot.stopObject(e);
        this.selectSlot.control = true;
    }

    selectUse(){
        // console.log("selectedIndex : ", selectedIndex);
        return this.selectResult[this.selectedIndex];
    }

    drawSlot(ctx){
        // console.log("슬롯그리기, this.slotList : ", this.slotList, ctx) ;
        if(this.slotList){
            // console.log("슬롯그리기, this.slotList : ", this.slotList)   
            this.slotList.forEach(slot => 
                // slot.setPosition(),
                slot.draw(ctx));
        }
    }
  
    draw(ctx){
        // console.log("그리기")/
        //배경그리기
        // this.x = player.x + player.width/2 - (USESELECTBAR_WDITH/2);
        // this.y = player.y - USESELECTBAR_HEIGHT - 10;
        ctx.fillStyle = this.backColor;
        ctx.fillRect(this.x, this.y, this.width, this.height);
           //선그리기
        ctx.strokeStyle = this.lineColor;
        ctx.lineWidth = 2;
        ctx.strokeRect(this.x, this.y, this.width, this.height);
    }

    update(ctx){
        // this.setSlotPositions();
        if(this.isOpen){
            this.draw(ctx);
            this.drawSlot(ctx);
            if(this.selectSlot.control){
                // console.log("셀렉트바 슬롯 컨트롤 ok")
                this.selectSlot.move();
            }
        }
    }
}