export class UserDataManager{
    async fetchUserInfo(){
        // console.log("fetchNickname ()..");
        let url = "/api/userInfo"
        try{
            const response = await fetch(url, {
                method : 'get',
                headers: {
                    'Content-type' : 'application/json'
                },
                credentials : 'include'
            });
            
            if(!response.ok){
                 throw new Error(`Network response was not ok, status : ${response.status}`);
            } 

            const data = await response.json();
            console.log("userDataManager, data : ", data);
            let userId = data.userId;
            let nickname = data.nickname;
            let gender = data.gender;
            //console.log("Response text : " + text);
			let userInfo =  {"userId" : userId, "nickname" : nickname, "gender" : gender};
			console.log("userInfo : ", userInfo);
			return userInfo;
        }catch(error){
            console.log("Error fetching nickname", error);
        }
    }

    // async fetchNickname(){
    //     // console.log("fetchNickname ()..");
    //     let url = "/api/nickname"
    //     try{
    //         const response = await fetch(url, {
    //             method : 'get',
    //             headers: {
    //                 'Content-type' : 'application/text; charset=utf-8'
    //             }
    //         });
            
    //         if(!response.ok){
    //              throw new Error("Network response was not ok");
    //         } 

    //         const text = await response.text();
    //         //console.log("Response text : " + text);
	
	// 		return text;
    //     }catch(error){
    //         console.log("Error fetching nickname", error);
    //     }
    // }

    // async fetchUserid(){
    //     // console.log("fetchNickname ()..");
    //     let url = "/api/userid"
    //     try{
    //         const response = await fetch(url, {
    //             method : 'get',
    //             headers: {
    //                 'Content-type' : 'application/text; charset=utf-8'
    //             }
    //         });
            
    //         if(!response.ok){
    //              throw new Error("Network response was not ok");
    //         } 

    //         const text = await response.text();
    //         //console.log("Response text : " + text);
	
	// 		return text;
    //     }catch(error){
    //         console.log("Error fetching nickname", error);
    //     }
    // }

    async fetchItems(){
        // console.log("fetchItems ()....");
        let url = "/api/items";
        try{
            const response = await fetch(url, {
                method : 'get',
                headers: {
                    'Content-type' : 'application/json'
                } 
            });

            if(!response.ok){
                throw new Error('Network response was not ok');
            }

            const data = await response.json();
            //console.log("User Items : ", data);
            return data;
        }catch(error){
            console.error('Error fetching items:', error);
        }
    }
}