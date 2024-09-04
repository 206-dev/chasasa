import { MAX_CANVAS_HEIGHT } from "./constant.js";
const CHAT_WIDTH = 500;
const CHAT_HEIGHT = 200;
export class Chat{
    constructor(nickname){
        //
       
        // 배경정보와 동일
        // this.nickname;
        // console.log("채팅 닉네임 : ", this.nickname);
        this.x = 0;
        this.y = MAX_CANVAS_HEIGHT - CHAT_HEIGHT;
        this.width = CHAT_WIDTH;
        this.height = CHAT_HEIGHT;
        this.backGroundColor = "rgba(0, 0, 0, 0.5)";
        this.lineColor = "gray";

        this.nickname = nickname;

        this.messages = [];
        this.inputMessage = "";
        this.isActive = false;

      

        //숨겨진 input 요소생성
        this.hiddenInput = document.createElement("input");
        this.hiddenInput.style.position = "absolute";
        this.hiddenInput.style.opacity = 0;
        this.hiddenInput.style.zIndex = -1;
        document.body.appendChild(this.hiddenInput);

        this.hiddenInput.addEventListener('input', (e) => {
            this.inputMessage = e.target.value;
        });

        this.url = "ws://192.168.1.103/chat";
        this.socket = new WebSocket(this.url);
        this.initialize();
    }

    initialize(){
        this.socket.onopen = () => {
            console.log("chat open.");
            this.sendMessage("***  '" + this.nickname +"'님이 접속하셨습니다.  ***");
        };

        this.socket.onmessage = (e) => {
            console.log("message receive : ", e.data);
            this.addMessage(e.data);
        }

        this.socket.onclose = () => {
            console.log("WebSocket close.")
            this.sendMessage("***  '" + this.nickname +"'님이 접속을 해제했습니다.  ***");
        }
    }

    // send message
    sendMessage(message){
        if(this.socket.readyState === WebSocket.OPEN){
            this.socket.send(message);
        }else{
            console.log("WebSocket isn`t opened");
        }
    }

    addMessage(message){
        this.messages.push(message);
		if (this.messages.length > 8) { // 최대 메시지 개수 제한
            this.messages.shift(); // 오래된 메시지 제거
        }
    }

	toggleChat(){
		this.isActive = !this.isActive;
        // console.log("채팅 상태 체크 : ", this.isActive);
        if(this.isActive){
            this.hiddenInput.value = "";
            this.inputMessage = "";
            this.hiddenInput.focus();
        }else{
            this.hiddenInput.blur();
            this.hiddenInput.value = "";
            this.inputMessage = "";
        }
        return this.isActive;
	}
	
	handleInput(e){
        // console.log("hiddeninput vlaue : ", this.hiddenInput.value);
        if(this.isActive){
            if(e.key === "Enter"){
                this.inputMessage = this.nickname + " : " +this.inputMessage
                if(this.inputMessage.trim() !== "" && this.hiddenInput.value.trim() !== ""){
	                // this.addMessage(this.inputMessage);
                    this.sendMessage(this.inputMessage);
	                this.inputMessage = "";
                    this.hiddenInput.value = "";
                }
                this.toggleChat();             
            }else if(e.key === "Tab"){
                // e.preventDefault();
                
                return;
            }else if(e.key === "Backspace"){
                e.preventDefault();
                this.inputMessage = this.inputMessage.slice(0, -1);
                this.hiddenInput.value = this. inputMessage;
                return;
            }else{
                this.inputMessage = this.hiddenInput.value;
            }
        }
	}	

    drawBackground(ctx){
        // console.log("채팅 그리기");
       //배경그리기
       ctx.fillStyle = this.backGroundColor;
       ctx.fillRect(this.x, this.y, this.width, this.height);
          //선그리기
       ctx.strokeStyle = this.lineColor;
       ctx.lineWidth = 2;
       ctx.strokeRect(this.x, this.y, this.width, this.height);
    }

    drawChat(ctx){
        // console.log("채팅 활성화 상태 : ", this.isActive);
        ctx.fillStyle = "white";
        ctx.font = "16px Arial";
        for(let i=0; i<this.messages.length; i++){
            ctx.textAlign = "start"
            ctx.fillText(this.messages[i], this.x + 10, this.y +20 + (i*20));
        }
    }

    drawChating(ctx){
        if(this.isActive){
            ctx.textAlign = "start"
            ctx.fillText(this.nickname + " > " + this.inputMessage, this.x + 10, this.y + this.height-15);
        }
    }


    update(ctx){
        if(this.isActive){
            this.lineColor = "rgb(255, 200, 100)";
        }else{
            this.lineColor = "gray";
        }
        // if(this.isActive){
            this.drawBackground(ctx);
            this.drawChat(ctx);
            this.drawChating(ctx);
        // }
        
    }
}