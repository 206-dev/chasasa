import { Player } from "./player.js"; 
import { Collision } from "./collision.js";
import { BASIC_LENGTH, MAX_CANVAS_HEIGHT, MAX_CANVAS_WIDTH } from "./constant.js"
import { MenuBar } from "./menubar.js"
import { Items } from "./items.js";
import { BASIC_SPEED } from "./constant.js";
import { UseSelectBar } from "./useSelectBar.js"
import { UserDataManager } from "./userDataManager.js";
import { Chat } from "./chat.js"
import { Game } from "./game.js"
import { OneCube } from "./oneCube.js";
export class MyUser{
    playerData = {
        name: "player",
        x: canvas.width/2,
        y: canvas.height - (BASIC_LENGTH*2),
    }

    constructor(obstacles){
        this.userDataManager = new UserDataManager;
        this.player =  null;   
        this.chat = null;
        this.game = null;

        // userInfo 호출후 세팅
        this.userDataManager.fetchUserInfo().then(data => {
            this.userId = data.userId;
            this.nickname = data.nickname;
            let gender = data.gender;
            console.log("gender : ", gender);
            this.player = new Player(this.playerData, this.userId, this.nickname, gender);
            this.chat = new Chat(this.nickname);
            this.game = new Game(this.userId, this.nickname, gender);
        });
    
        this.collision = new Collision();
        this.obstacles = obstacles;
        this.setItems = new Array();
        this.menubar = new MenuBar();
        
        //console.log(this.useSelectBar);

        // 메뉴 상태와 컨트롤 상태 초기화
        this.isOpenMenu = false;
        

        //아이템
        this.isUseItem = false;

        this.isDrive = false;
        this.isCarry = false;

        this.isCarTouch = false;
        this.isTentTouch = false;
        this.touchItemName = null;

        this.usedItemName = "";

        // 다른플레이어들 정보
        this.otherPlayers = {};
        // this.otherPlayersObstacles = new Array();

        // 키 이벤트 핸들러 등록
        this.handleKeyDown = this.handleKeyDown.bind(this);
        this.handleKeyUp = this.handleKeyUp.bind(this);
        
        window.addEventListener("keydown", this.handleKeyDown);
        window.addEventListener("keyup", this.handleKeyUp);

        setInterval(()=>{
            if(this.game !== null && this.player !== null){
                if(this.game.socket.readyState === WebSocket.OPEN){
                    let playerData = this.player.getPlayData();
                    // console.log("myUser, update, playerData : ", playerData);
                    this.game.sendData(playerData, 'player');
                }        
            }
            if(this.game !== null && this.setItems !== null){
                if(this.game.socket.readyState === WebSocket.OPEN){
                    for(let i=0; i<this.setItems.length; i++){
                        let item = this.setItems[i];
                        // console.log("myUser, setInterval, this.item : ", this.item);
                        //console.log("this.setItems : ", this.setItems);
                        //console.log("item : ", item);
                        let sendItemData = item.getItemData();
                        // console.log("아이템 데이터 전송전 itemData : ", sneditemData);
                        this.game.sendData(sendItemData, 'item');
                    }
                }
            }
            if(this.game !== null && this.game.otherPlayers !== null){
                let receivedOtherPlayersData = this.game.getOtherPlayersData();
                // console.log("myUser, 다른 플레이어 데이터 : ", receivedOtherPlayersData);
                for(let playerId in receivedOtherPlayersData){
                    if(this.otherPlayers[playerId]){
                        this.otherPlayers[playerId].x = receivedOtherPlayersData[playerId].x;
                        this.otherPlayers[playerId].y = receivedOtherPlayersData[playerId].y;
                        this.otherPlayers[playerId].isTouchable = receivedOtherPlayersData[playerId].isTouchable;
                        // console.log("myUser, other players : ", this.otherPlayers[playerId]);
                    }else{
                        let otherPlayerCube = new OneCube(receivedOtherPlayersData[playerId].x, receivedOtherPlayersData[playerId].y) ;
                        otherPlayerCube.isTouchable = true;
                        this.otherPlayers[playerId] = otherPlayerCube;
                        this.obstacles.push(this.otherPlayers[playerId]);
                    }
                }
              
            }
        }, 90); 
    }

    handleKeyDown(e){
        //console.log("키 입력전 this.player x, y : ", this.player.x, ", ", this.player.y);
        this.player.moveObject(e);
        if(this.chat.isActive && this.chat){
            //채팅
            this.chat.handleInput(e);
        }else{
            //채팅 아닐때
            switch(e.key){
                //엔터 누르면 채팅 on
                case "Enter" :
                    e.preventDefault();
                    this.player.control=false;
                    this.chat.toggleChat();
                    return;
            }
            //그외 키
            if(this.isOpenMenu){
                //메뉴창 오픈
                this.menubar.moveSelectSlot(e);
                switch(e.key){
                    case " " :
                        if(this.menubar.selectedIndex !== 2){
                            // 아이템 선택
                            console.log("아이템 선택 스페이스");
                            this.selectItem();
                        }
                        //메뉴 관리
                        this.player.control = true;
                        this.closeMenu();
                        break;
                }
            }else if(this.useSelectBar){
                //아이템 상호작용창 오픈
                this.useSelectBar.moveSelectSlot(e);
                switch(e.key){
                    case " " :
                        // 상호작용 결과
                        let selectResult = this.useSelectBar.selectUse();
                        
                        let tent;
                        switch(selectResult){
                            case "sleep" :
                                //자기
                                //텐트 상태 변경
                                tent = this.setItems.find(setItem => setItem.name === this.touchItemName);
                                tent.isSleep = true;

                                //플레이어 상태 변경
                                this.player.isSleep = true;
                                this.player.control = false;

                                //유저 상태 변경
                                this.isSleep = true;
                                this.player.isTouchable = false;
                                this.closeUseBar();
                                break;
                            case "carry" :
                                //옮기기
                                //텐트 상태 변경
                                tent = this.setItems.find(setItem => setItem.name === this.touchItemName);
                                tent.isSetup = false;
                                tent.isTouchable = false;

                                //플레이어 상태 변경
                                this.player.control = true;

                                //유저 상태 변경
                                this.isCarry = true;

                                this.closeUseBar();
                                break;
                            case "cancle" :
                                this.closeUseBar();
                                break;
                        }
                        // console.log(selectResult);
                        break;
                }
            }else if(this.player.isSleep){
                //플레이어 상태 자고있을때
                switch(e.key){
                    case " " :
                        //잠에서 깨기
                        //텐트 상태 변경
                        let tent = this.setItems.find(setItem => setItem.name === this.touchItemName);
                        tent.isSleep = false;

                        //플레이어 상태 변경
                        this.player.control = true;
                        this.player.isSleep = false;
                        
                        //유저 상태 변경
                        this.isSleep = false;
                        this.player.isTouchable = true;
                        break;
                }
            }else if(this.isCarry){
                //탠트 내리기
                switch(e.key){
                    case " " :
                        console.log("isCarry true일때 스페이스");
                        let tent = this.setItems.find(setItem => setItem.name === this.usedItemName);
                        console.log("tent : ", tent);
                        tent.isSetup = true;
                        tent.isTouchable = true;
                        // this.player.isCarry = false;
                        this.isCarry = false;
                        let obstacle = this.obstacles.find(obs => obs.name === this.usedItemName);
                        obstacle.isTouchable = true;
                        break;
                }
            }else if(this.isDrive){
                //운전 중단
                switch(e.key){
                    case " " :
                        console.log("드라이브 중일때 스페이스누름");
                        this.dontUseItem();
                        break;
                }
            }else if(this.isTentTouch||this.isCarTouch){
                //상호 작용 시도, 충돌중
                switch(e.key){
                    case " " :
                        //아이템 터치중일때, 상호작용
                        if(this.isTentTouch){
                            //아이템 사용 선택창 오픈
                            console.log("아이템 사용창 오픈");
                            this.openUseBar()
                        }else if(this.isCarTouch){
                            //차 타기
                            this.useItem()
                        }
                    break;
                }
            }else{
                // 아무상태 아닐때
                switch(e.key){
                    case " " :
                        //메뉴창오픈
                        this.openMenu(); 
                        break;
                    default :
                        this.player.control = true;
                        break;
                }
            }
        }// 키입력 end
        //console.log("키 입력후 this.player x, y : ", this.player.x, ", ", this.player.y);
    
    }
    handleKeyUp(e){
        if(this.isOpenMenu){
            this.menubar.stopSelectSlot(e);
        }else if(this.useSelectBar){
            this.useSelectBar.stopSelectSlot(e);
        }else if(this.player){
            this.player.stopObject(e);
        }
    }

    openMenu(){
        this.player.control = false;
        this.isOpenMenu = true;
        this.menubar.isOpen =true;
    }
    closeMenu(){
        this.isOpenMenu = false;
        this.menubar.isOpen = false;
        this.menubar.carIndex = 0;
        this.menubar.tentIndex = 0;
    }

    openUseBar(){
        this.useSelectBar = new UseSelectBar(this.player);
        this.useSelectBar.isOpen = true;

        this.player.control = false;
        this.useSelectBar.selectSlot.control = true;
    }

    closeUseBar(){
        this.useSelectBar = null;
    }
    
    selectItem(){
        console.log("아이템 셀렉트");
        console.log("this.player x, y : ", this.player.x, this.player.y);
        let selectItemData = this.menubar.selectItem(this.menubar.selectedIndex);
        let items = new Items(this.player);
        if(selectItemData && selectItemData.length !==0){
            let item = items.getItem(selectItemData.itemname);
            console.log("item : ", item);
            let itemType = item.type;
            switch(itemType){
                case "car" :
                    console.log("차선택");
                    this.isDrive = true;
                    this.player.speed = item.speed;
                    item.isParked = false;
                    item.isTouchable = false;
                    this.isCarTouch = true;
                    this.usedItemName = item.name;
                    break;
                case "tent" :
                    console.log("텐트선택");
                    this.isCarry = true;
                    item.isSetup = false;
                    item.isTouchable = false;
                    // this.touchItemName = selectItemData.itemname;
                    this.usedItemName = item.name;
                    break;
            }
            console.log("아이템 선택하자마자 아이템 이름 : ", this.usedItemName);
            console.log("push전 item : ", item);
            this.setItems.push(item);
            this.obstacles.push(item);
            this.isUseItem = true;
        }else{
            this.menubar.isOpen = false;
        } 
        console.log("this.setItems : ", this.setItems);
        console.log("this.obstacles : ", this.obstacles);
    }

    useItem(){
        if(!this.isDrive){
            console.log("운전중 아닐때 차 타기");
            let car = this.setItems.find(setItem => setItem.name === this.touchItemName);
           
            // console.log("car : ", car);
            this.player.speed = car.speed;
           
            car.isParked = false;
            console.log("touchItemName : ", this.touchItemName);
            this.game.driving(this.userId ,this.touchItemName);
            this.isDrive = true;
        }else if(!this.isCarry){
            
        }
        
    }

    dontUseItem(){  
        if(this.isDrive){
            console.log("운전중 일때 차내리기");
            console.log("this.usedItemName : ", this.usedItemName);
            console.log("this.touchItemName : ", this.touchItemName);
            let car = this.setItems.find(setItem => setItem.name === this.usedItemName);
            // let obstacleCar = this.obstacles.find(setItem => setItem.name === this.touchItemName);
            // console.log("car : ", car);
            this.player.speed = BASIC_SPEED;
            car.isRight = this.player.isRight;
            car.isParked = true;
            car.isTouchable = true;
            this.isDrive = false;
            console.log("myUser 파킹전 userId : ", this.userId, ", userdItemName : ", this.usedItemName);
            this.game.parking(this.userId ,this.usedItemName);
        }else if(this.isCarry){
            console.lolg("텐트 터치중")
        }
    }

    update(ctx){
    	if(this.player !== null){
            // this.player.update(ctx);
            this.player.move();
            if(this.game.myPlayer){
                this.game.myPlayer.setMyData(this.player.getPlayData());
            }

            let resultCollision = this.collision.handleCollision(this.player, this.obstacles);
            // console.log(resultCollision);
            if(resultCollision && resultCollision.type){
                if(resultCollision.type === "tent"){
                    this.isTentTouch = true;
                }else if(resultCollision.type === "car"){
                    this.isCarTouch = true;
                }
                this.touchItemName = resultCollision.name;
    
            }else{   
                this.isTentTouch = false;
                this.isCarTouch = false;
            }
            
            if(this.useSelectBar){
                this.useSelectBar.update(ctx, this.player);
            }
        }
        
       
        if(this.menubar !== null){
            this.menubar.update(ctx);
        }

        if(this.chat !== null){
            this.chat.update(ctx);
        }

        if(this.setItems!== null){
            for(let i=0; i<this.setItems.length; i++){
                let item = this.setItems[i];
                item.update2(this.player);
            }
        }

        if(this.game !== null){
            this.game.update(ctx);
        }  
    }//update
}