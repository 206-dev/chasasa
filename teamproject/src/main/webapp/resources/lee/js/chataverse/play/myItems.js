// // 아이템을 DB에서 가져와서 user로 넘겨야됨
// export class MyItems{
//     async fetchItems(userid){
//         let url = "/item/myitems/" + userid;
//         try{
//             const response = await fetch(url, {
//                 method : 'get',
//                 headers: {
//                     'Content-type' : 'application/json'
//                 } 
//             });

//             if(!response.ok){
//                 throw new Error('Network response was not ok');
//             }

//             const data = await response.json();
//             // console.log('User Items : ' , data);
            

//         }catch(error){
//             console.error('Error fetching items:', error);
//         }
//     }

//     testFetchItems(){
//         let testdata = [{itemname: 'smallcar', type: 'car', price: 100, capacity: 2},
//             {itemname: 'rearcar', type: 'car', price: 0, capacity: 1},
//             {itemname: 'smalltent', type: 'tent', price: 100, capacity: 2},
//             {itemname: 'newspaper', type: 'tent', price: 0, capacity: 1}];
//         return testdata;
//     }
// }