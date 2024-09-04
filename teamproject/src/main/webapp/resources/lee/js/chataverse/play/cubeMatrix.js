import { OneCube } from "./oneCube.js";
import { CUBE_HEIGHT, CUBE_WIDTH } from "./constant.js"
export class CubeMatrix{
    constructor(data){
        // console.log("CubeMatrix 호출");
        // console.log("data : ", data);
        this.name = data.name,
        this.x = data.x,
        this.y = data.y,
        this.width = CUBE_WIDTH*data.cols;
        this.height = CUBE_HEIGHT*data.rows;
        this.cols = data.cols,
        this.rows = data.rows,
        this.backColor = data.backColor,
        this.lineColor = data.lineColor
        this.cubes = this.getCubes(data);
    }

    getCubes(data){
        // console.log("getCubes");
        // console.log(this);
        // console.log("name : ", data.name + ", x : ", data.x, ", y : ", data.y)
        let cubes = [];
        for(let row=0; row<data.rows; row++){
            for(let col=0; col<data.cols; col++){
                // console.log("for..");
                if(this.name.indexOf("tree") != -1){
                    // console.log(this.name);
                    let spriteImage;
                    let x = data.x + (col * CUBE_WIDTH);
                    let y = data.y + (row * CUBE_HEIGHT)
                    if(this.getRandom()){
                        spriteImage="/resources/lee/image/chabak/sprite/tree1.png";
                    }else{
                        spriteImage= "/resources/lee/image/chabak/sprite/tree2.png";
                    }
                    let cubeData = {
                        x : x ,
                        y: y, 
                        backColor : data.backColor, 
                        lineColor : data.lineColor,
                        spriteImage : spriteImage
                    }
                    let cube = new OneCube(cubeData);
                        cubes.push(cube);
                }else{
                    let cubeData = {
                        x : x,
                        y : y,
                        backColor : data.backColor,
                        lineColor : data.lineColor
                    }
                    let cube = new OneCube(cubeData);
                    cubes.push(cube);
                }

                
            };
        };
        return cubes;
    }

    
    
    getRandom(){
        return Math.random() < 0.5;
    }

    draw(ctx){
        this.cubes.forEach(cube => {
            // console.log(cube.name);
            if(this.name.indexOf("tree") != -1){
                cube.update(ctx);         
            }else{
                cube.draw(ctx);
            }
            // cube.draw(ctx);
        });
    }

}