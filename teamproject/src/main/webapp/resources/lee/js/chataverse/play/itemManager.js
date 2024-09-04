export class ItemManager{
    
    constructor(constructures){
        this.constructures = constructures;
        this.items = [];
    }
    async getItem(player, name){
        switch(name){
            case "car":
                console.log("ItemManager, getItem(), car......");
                const { Car } = await import("./car.js");
                let car = new Car(player);
                car.createBorders();
                car.setConstructues(this.constructures);
                
                console.log(car);
                console.log(this.constructures);
                
                this.items.push(car);
                return car;
        }
    }

    update(ctx, player){
        if(this.items !== null && this.items.length !== 0){
            this.items.forEach(item => {
                item.update(ctx, player);
            });
        }
    }
}