import { Player } from './player.js';
import { Items } from './items.js';
import { Collision } from './collision.js';
export class Game{
    constructor(userId, nickname, gender){
        this.collision = new Collision();
        // 내정보
        this.myPlayer = null;
        this.userId = userId;
        this.nickname = nickname;
        this.gender = gender;
        console.log("game, gender : ", this.gender);

        // 다른플레이어
        this.otherPlayers = {};

        this.items = {};

        this.messageQueue = [];

        this.isSending = false;

        this.url = "ws://192.168.1.103/game";
        this.socket = new WebSocket(this.url);
        this.initialize();

    }//constructor

    initialize(){

        this.socket.onopen = () => {
            console.log("Game WebSocket 연결 성공");
            this.processQueue();
        }

        this.socket.onmessage = (e) => {
            const data = JSON.parse(e.data);
            // console.log("onmessage, id : ", data.id);
            switch(data.type){
                case "player" :
                    if (this.userId === data.id) {
                        // 내 플레이어의 데이터 갱신은 클라이언트에서 직접 처리
                        if (this.myPlayer === null) {
                            // console.log("내플레이어 데이터 생성----------------------------------------------------------");
                            // console.log("내아이디 ", this.userId);
                            this.myPlayer = new Player(data.data, this.userId, this.nickname, this.gender);
                            this.myPlayer.setPlayData(data.data, this.userId);
                        }
                    } else {
                        // 다른 플레이어의 상태는 서버에서 받은 데이터를 그대로 갱신
                        // console.log("다른플레이어 데이터 전송-----------------------------------------------------------");
                        if (!this.otherPlayers[data.id]) {
                            // console.log("다른플레이어 생성.............................................");
                            // console.log("data.id : ", data.id);
                            // console.log("다른플레이어 데이터 생성-----------------------------------------------------");
                            // console.log("다른플레이어 아이디 : ", data.id);
                            let player = new Player(data.data, data.id, data.nickname, data.gender);
                            player.setPlayData(data.data, data.id);
                            this.otherPlayers[data.id] = player;
                        } else {
                            // console.log("다른플레이어 데이터 덮어쓰기-----------------------------------------------------");
                            // console.log("다른플레이어 아이디 : ", data.id);
                            // console.log(data.id);
                            // console.log("game, onmessage, 다른플레이어 데이터 덮어쓰기......................");
                            // console.log("data.id : ", data.id);
                            this.otherPlayers[data.id].setPlayData(data.data, data.id);
                        }
                    }
                    break;
                case "item" :
                    if(data.id === this.userId){
                        if(!this.items[this.userId]){
                            let items = new Items(this.myPlayer);
                            let item = items.getItem(data.data.name);
                            let myItems = new Array();
                            myItems.push(item);
                            this.items[this.userId] = myItems;
                            console.log("this.items : ", this.items);
                            console.log("myItems : ", myItems);
                            console.log("this.items[this.userId] : ", this.items[this.userId]);

                        }else{
                            let existingItems = this.items[this.userId];

                            // 아이템 중복 체크
                            let foundItem = existingItems.find(existingItem => existingItem.name == data.data.name);
    
                            if(foundItem){
                                // 중복 된 아이템 있을때, 엎어쓰기
                                foundItem.setItemData(data.data);
                            }else{
                                // 중복 되지 않을 때, 새로 생성
                                let items = new Items(this.myPlayer);
                                let newItem = items.getItem(data.data.name);
                                existingItems.push(newItem);
                            }
                        }
                    }else{
                        if(!this.items[data.id]){
                            let items = new Items(this.otherPlayers[data.id]);
                            let item = items.getItem(data.data.name);
                            let otherPlayerItems = new Array();
                            otherPlayerItems.push(item);
                            this.items[data.id] = otherPlayerItems;
                        }else{
                            let existingItems = this.items[data.id];

                            // 아이템 중복 체크
                            let foundItem = existingItems.find(existingItem => existingItem.name == data.data.name);
    
                            if(foundItem){
                                // 중복 된 아이템 있을때, 엎어쓰기
                                foundItem.setItemData(data.data);
                            }else{
                                // 중복 되지 않을 때, 새로 생성
                                let items = new Items(this.otherPlayers[data.id]);
                                let newItem = items.getItem(data.data.name);
                                existingItems.push(newItem);
                            }
                        }
                    }
                    break;
            }
        }

        this.socket.onerror = (error) => {
            console.log.error("WebSocket 에러 발생 : ", error);
        }

        this.socket.close = () => {
            console.log("Game WebSocket 연결 해제.. 재연결 시도 중...");
            setTimeout(()=>{
                this.socket = new WebSocket(this.url);
                this.initialize();
            }, 1000);
        }

    }

    sendData(data, type){
        const playerId = this.userId;
        const nickname = this.nickname;
        let message = JSON.stringify({
            id: playerId,
            nickname: nickname,
            gender: this.gender,
            data: data,
            type: type
        });
        // console.log("game, sendData, playerData : ", playerData);       
        // 객체를 json으로 변환후 큐에 추가
        this.messageQueue.push(message);
      	//console.log("game, sendData, messageQueue : ", this.messageQueue);
        this.processQueue();
    }

    getOtherPlayersData(){
        let otherPlayersData = new Array();
        for(let playerId in this.otherPlayers){
            let otherPlayer = this.otherPlayers[playerId];
            // console.log("game, getOtehrPlayersData, otherPlayer : ", otherPlayer);
            let otherPlayerData = {
                x : otherPlayer.x,
                y : otherPlayer.y,
                isTouchable : otherPlayer.isTouchable,
                playerId : playerId
            }
            // console.log("game, getOtehrPlayersData, otherPlayerData : ", otherPlayerData);
            otherPlayersData.push(otherPlayerData);
        }
        return  otherPlayersData;
    }
    

    async processQueue(){
        if(this.isSending || this.socket.readyState !== WebSocket.OPEN){
            return;
        }

        this.isSending = true;
   
        while(this.messageQueue.length > 0){
            let message = this.messageQueue.shift();
            try{
                this.socket.send(message);
            }catch(error){
                console.error("메세지 전송중 에러 : ", error);
                break;
            }
        }
        this.isSending = false;
    }

    //상호작용전달
    parking(userId, itemname){
        console.log("game, parking, userid : ", userId, ", itemname : ", itemname);
        let myItems = this.items[userId];
        let item = myItems.find(setItem => setItem.name === itemname);
        item.isParked = true;
        item.isRight = this.myPlayer.isRight;
        item.isTouchable = true;
        console.log("game, paking, item : ", item);
    }
    driving(userId, itemname){
        let myItems = this.items[userId];
        // console.log("myItems : ", myItems);
        let item = myItems.find(setItem => setItem.name === itemname);
        // console.log("myItems : ", item);
        item.isParked = false;
        item.isTouchable = true;
        // console.log("game, driving, item : ", item);
    }

    drawPlayers(ctx){
        // console.log("otehrplayers : ", this.otherPlayers);
        if(this.otherPlayers){
            for(let playerId in this.otherPlayers){
                // console.log("drawPlayers for")
                let player = this.otherPlayers[playerId];
                // console.log("다른플레이어 otherPlayersplayerId] : ", this.otherPlayers[playerId]);
                // console.log("다른플레이어 player : ", player);
                player.update2(ctx);
            }            
        }
    }

    drawMyplayer(ctx){
        if(this.myPlayer){
            this.myPlayer.update2(ctx);
        }
    }

    drawItems(ctx){
        if(this.items){
            for(let playerId in this.items){
                if(playerId === this.userId){
                    let myItems = this.items[this.userId];
                    for(let i=0; i<myItems.length; i++){
                        let myItem = myItems[i];
                        myItem.update(ctx, this.myPlayer);
                    }
                }else{
                    let otherPlayersItems = this.items[playerId];
                    for(let i=0; i<otherPlayersItems.length; i++){
                        let othersItem = otherPlayersItems[i];
                        othersItem.update(ctx, this.otherPlayers[playerId]);
                    }
                }
            }
        }
    }

    update(ctx){
        // console.log("game, update");
        this.drawMyplayer(ctx);
        this.drawPlayers(ctx);
        this.drawItems(ctx);
    }
}//Game