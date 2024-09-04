import { MAX_CANVAS_WIDTH , MAX_CANVAS_HEIGHT, BASIC_LENGTH, CUBE_HEIGHT, CUBE_WIDTH, REARCAR_IMG, SMALLCAR_IMG, NEWSPAPER_IMG, SMALLTENT_IMG} from "./constant.js";
// import { MyItem } from "./myItem.js";
import { MyObject } from "./myObject.js";
import { UserDataManager } from "./userDataManager.js";
// import { OneCube } from "./oneCube.js";
import { MySlot } from "./mySlot.js";


const ITEM_COUNT = 3;
export class MenuBar{
    
    constructor(){
   		this.userDataManager = new UserDataManager();
        // 슬롯 3개 일때  
        // console.log();
        this.name = "menubar";
        this.x = (MAX_CANVAS_WIDTH - (CUBE_WIDTH*3) - (BASIC_LENGTH*2)),
        this.y = (MAX_CANVAS_HEIGHT - (CUBE_HEIGHT) - (BASIC_LENGTH*2)),
        this.width = CUBE_WIDTH*3 + BASIC_LENGTH*2;
        this.height = CUBE_HEIGHT + BASIC_LENGTH*2;
        this.lineColor = "rgb(114, 112, 112)"
        this.backColor = "rgb(207, 203, 203)";

        //오픈상태
        this.isOpen = false;
        //아이템 인덱스
        this.selectedIndex = 0;
        //차 인덱스
        this.carIndex = 0;
        this.tentIndex = 0;

        // 보드 생성
        this.backBoard = new MyObject(this.x, this.y)
        this.backBoard.width = this.width;
        this.backBoard.height = this.height;
        this.backBoard.image = new Image();
        this.backBoard.image.src = "/resources/lee/image/chabak/image/slotback.png";

        //슬롯 배열
        this.slotList = new Array();
        this.carItems = new Array();
        this.tentItems = new Array();
        // 내 아이템 
        this.setMyItems();
    }

    setMyItems(){
        //아이템 DB에서 Data 가져오기
        this.userDataManager.fetchItems().then(data => {
            this.myItemList = data;
            
            //아이템 정렬
	        this.sortItems();
	        this.createSlots();
        });
       
    }

    //아이템 정렬
    sortItems(){
        // 타입별 가격순으로 정렬
        if(!Array.isArray(this.myItemList)){
        	console.log("myItemList is not an array or is undefined", this.myItemList);
        	return;
        }
        this.carItems = this.myItemList.filter(item => item.type === "car").sort((a,b) => a.price - b.price );
        this.tentItems = this.myItemList.filter(item => item.type === "tent").sort((a,b) => a.price - b.price );
    }

    //슬롯 생성
    createSlots(){
        this.createCarSlot();
        this.createTentSlot();
        this.createCancleSlot();
        this.createSelectSlot();
    }
    // select 슬롯
    createSelectSlot(){
        let selectSlotData = {
            x : MAX_CANVAS_WIDTH - BASIC_LENGTH - CUBE_WIDTH*3,
            y : this.y + BASIC_LENGTH,
            backColor : "rgba(255, 217, 0, 0.1)",
            lineColor : "rgb(255, 235, 59)"
        }
        this.selectSlot = new MySlot(selectSlotData)
        this.selectSlot.control = true;
        // console.log(this.selectSlot);
        this.slotList.push(this.selectSlot);
    }

    // car 슬롯
    createCarSlot(){
        let carSlotData = {
            x : MAX_CANVAS_WIDTH - BASIC_LENGTH - CUBE_WIDTH*3,
            y : this.y + BASIC_LENGTH,
            backColor : "gray",
            lineColor : "black",
            image : REARCAR_IMG
        }
        this.carSlot = new MySlot(carSlotData)
        // console.log(this.carSlot);
        this.slotList.push(this.carSlot);
    }

    // tent 슬롯
    createTentSlot(){
        let tentSlotData = {
            x : MAX_CANVAS_WIDTH - BASIC_LENGTH - CUBE_WIDTH*2,
            y : this.y + BASIC_LENGTH,
            backColor : "gray",
            lineColor : "black",
            image : NEWSPAPER_IMG
        }
        this.tentSlot = new MySlot(tentSlotData)
        // console.log(this.tentSlot);
        this.slotList.push(this.tentSlot);
    }

    //취소 슬롯
    createCancleSlot(){
        let cancleSlotData = {
            x : MAX_CANVAS_WIDTH - BASIC_LENGTH - CUBE_WIDTH,
            y : this.y + BASIC_LENGTH,
            backColor : "gray",
            lineColor : "black",
            image : "/resources/lee/image/chabak/image/cancle.png"
        }
        this.cancleSlot = new MySlot(cancleSlotData);
        // console.log(this.cancleSlot);
        this.slotList.push(this.cancleSlot);
    }

    selectSlotMove(e) {
        // this.moveSelectSlot(e);
        // 방향키로 메뉴 선택
        // console.log("메뉴 셀렉트 키 입력");
        // console.log(this.carItems.length, this.tentIndex.length)
        if(this.selectSlot.control){
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
                    if(this.selectedIndex === 0 && this.carItems || this.selectedIndex === 0 && this.tentItems){
                        //차인경우
                        this.carIndex = (this.carIndex + 1) % this.carItems.length;
                    }else{
                        //텐트인경우
                        this.tentIndex = (this.tentIndex + 1) % this.tentItems.length;
                    }
                    break;
                case 'ArrowUp' :
                case 'W' : 
                case 'w' :
                    this.selectSlot.dy = 0;
                    if(this.selectedIndex === 0 && this.carItems || this.selectedIndex === 0 && this.tentItems){
                        //차인경우
                        this.carIndex = (this.carIndex - 1 + this.carItems.length) % this.carItems.length;
                    }else{
                        //텐트인경우
                        this.tentIndex = (this.tentIndex - 1 + this.tentItems.length) % this.tentItems.length;
                    }
            }
            // console.log("selectedIndex : " , this.selectedIndex);
            this.selectSlot.x = (this.x + BASIC_LENGTH) + ((BASIC_LENGTH * 2)*this.selectedIndex);  
        }
        
        // console.log("carIndex : ", this.carIndex);
        // console.log("tentIndex : ", this.tentIndex);
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

    selectItem(selectedIndex){
        //아이템 선택 아이템 리턴하기
        if (selectedIndex === 0) {
            let selectItem = this.carItems[this.carIndex];
            this.carItems.splice(this.carIndex, 1);
            return selectItem;
        } else if (selectedIndex === 1) {
            let selectItem = this.tentItems[this.tentIndex];
            this.tentItems.splice(this.tentIndex, 1);
            return selectItem;
        }
    }

    setEmptySlot(){
        if(this.carItems && this.carItems.length !== 0){
            let carName = this.carItems[this.carIndex].itemname;
            
            switch(carName){
                case "rearcar" :
                    // console.log("리어카");
                    this.carSlot.image.src = REARCAR_IMG;
                    
                    break;
                case "smallcar" :
                    // console.log("스몰카")
                    this.carSlot.image.src = SMALLCAR_IMG;
                    break;
            }
           
        }else{
            this.carSlot.image.src = "/resources/lee/image/chabak/image/cancle.png";
        }
        // console.log("tentItems : ", this.tentItems);
        if(this.tentItems && this.tentItems.length !== 0){
            let tentName = this.tentItems[this.tentIndex].itemname;
            switch(tentName){
                case "newspaper" :
                    this.tentSlot.image.src = NEWSPAPER_IMG;
                    break;
                case "smalltent" :
                    this.tentSlot.image.src = SMALLTENT_IMG;
            }
        }else{
            this.tentSlot.image.src = "/resources/lee/image/chabak/image/cancle.png";
        }
    }

    update(ctx){
        if(this.isOpen){
            this.setEmptySlot();
           
            this.backBoard.drawImage(ctx);
            if(this.slotList !== null && this.slotList.length !== 0){
                for(let i=0; i<this.slotList.length; i++){
                    // console.log("슬롯 for");
                    let slot = this.slotList[i];
                    // console.log(slot);
                    slot.update(ctx)
                }
            }
            if(this.selectSlot.control && this.selectSlot){
                this.selectSlot.move();
            }
        }
        
    }
}