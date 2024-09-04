import {MAX_COLS, MAX_ROWS, MAX_CUBE_COLS, MAX_CUBE_ROWS, CUBE_WIDTH, CUBE_HEIGHT, SEA_COLS, SEA_ROWS, BASIC_LENGTH, MAX_CANVAS_WIDTH, MAX_CANVAS_HEIGHT} from "./constant.js"
import { BlockMatrix } from "./blockMatrix.js";
import { CubeMatrix } from "./cubeMatrix.js";

const TREE_BACK_COLOR = "rgb(70, 192, 70)";
const TREE_LINE_COLOR = "rgb(145, 240, 145)";
export class MatrixManager{
    blockMatrixDatas = new Array();
    blockMatrixs = new Array();

    cubeMatrixDatas = new Array();
    cubeMatrixs = new Array();

    obstacles = new Array();
    
    //배경
    backgroundData = {
        name : "background",
        x : 0,
        y : 0,
        cols : MAX_COLS,
        rows : MAX_ROWS,
        lineColor : "white",
        backColor : "rgb(236, 236, 236)",
        imageSrc : "/resources/lee/image/chabak/sprite/background.png"
    }
    //바다
    seaData = {
        name : "sea",
        x : 0,
        y : 0,
        rows : SEA_ROWS,
        cols : SEA_COLS,
        lineColor : "blue",
        backColor: "rgb(74, 74, 255)"
    }
    //나무
    treeLeftData = {
        name : "treeLeft",
        x : 0,
        y : CUBE_HEIGHT*3,
        cols : 1,
        rows : MAX_CUBE_ROWS-3,
        backColor : TREE_BACK_COLOR,
        lineColor : TREE_LINE_COLOR,
        isImage : true
    }
    treeRightData = {
        name : "treeRight",
        x : MAX_CANVAS_WIDTH - CUBE_WIDTH,
        y : CUBE_HEIGHT*3,
        cols : 1,
        rows : MAX_CUBE_ROWS-3,
        backColor : TREE_BACK_COLOR,
        lineColor : TREE_LINE_COLOR,
        isImage : true
    }

    treeBottomData1 = {
        name : "treeBottomLeft",
        x : CUBE_WIDTH,
        y : MAX_CANVAS_HEIGHT - CUBE_HEIGHT,
        cols : (MAX_CUBE_COLS/2) - 1*2,
        rows : 1,
        backColor : TREE_BACK_COLOR,
        lineColor : TREE_LINE_COLOR,
        isImage : true
    }

    treeBottomData2 = {
        name : "treeBottomLeft",
        x : MAX_CANVAS_WIDTH/2 + CUBE_WIDTH * 2,
        y : MAX_CANVAS_HEIGHT - CUBE_HEIGHT,
        cols : (MAX_CUBE_COLS/2) - 1,
        rows : 1,
        backColor : TREE_BACK_COLOR,
        lineColor : TREE_LINE_COLOR
    }
    treeCenter1 = {
        name : "treeCenter1",
        x : MAX_CANVAS_WIDTH/2 - CUBE_WIDTH * 2,
        y : MAX_CANVAS_HEIGHT/2 - CUBE_HEIGHT * 2,
        cols : 4,
        rows : 4,
        backColor : TREE_BACK_COLOR,
        lineColor : TREE_LINE_COLOR
    }
    treeCenter2 = {
        name : "treeCenter1",
        x : MAX_CANVAS_WIDTH/4 - CUBE_WIDTH,
        y : MAX_CANVAS_HEIGHT/3 - CUBE_HEIGHT,
        cols : 2,
        rows : 2,
        backColor : TREE_BACK_COLOR,
        lineColor : TREE_LINE_COLOR
    }
    treeCenter3 = {
        name : "treeCenter1",
        x : MAX_CANVAS_WIDTH/4*3 - CUBE_WIDTH,
        y : MAX_CANVAS_HEIGHT/3 - CUBE_HEIGHT,
        cols : 2,
        rows : 2,
        backColor : TREE_BACK_COLOR,
        lineColor : TREE_LINE_COLOR
    }
    treeCenter4 = {
        name : "treeCenter1",
        x : MAX_CANVAS_WIDTH/4 - CUBE_WIDTH,
        y : MAX_CANVAS_HEIGHT/3*2 - CUBE_HEIGHT,
        cols : 2,
        rows : 2,
        backColor : TREE_BACK_COLOR,
        lineColor : TREE_LINE_COLOR
    }
    treeCenter5 = {
        name : "treeCenter1",
        x : MAX_CANVAS_WIDTH/4*3 - CUBE_WIDTH,
        y : MAX_CANVAS_HEIGHT/3*2 - CUBE_HEIGHT,
        cols : 2,
        rows : 2,
        backColor : TREE_BACK_COLOR,
        lineColor : TREE_LINE_COLOR
    }

    

    constructor(){
        // console.log("메트릭스 매니저 호출");
        this.createBlockMatrixs();
        this.createCubeMatrixs();
    } 
   
    createBlockMatrixs(){
        // console.log("createBlockMatrixs()");
        this.blockMatrixDatas.push(this.backgroundData);
        this.blockMatrixDatas.push(this.seaData);
        //블록으로 생성할 메트리스
        for(let i=0; i<this.blockMatrixDatas.length; i++){
            // console.log(this.blockMatrixDatas[i]);
            let blockMatrix = new BlockMatrix(this.blockMatrixDatas[i]);
            this.blockMatrixs.push(blockMatrix);
        }
        
        const sea = this.blockMatrixs.find(blockMatrix => blockMatrix.name === 'sea');
        sea.isTouchable = true;
        this.obstacles.push(sea);
    }

    createCubeMatrixs(){
        // console.log("createCubeMatrixs()");
        this.cubeMatrixDatas.push(this.treeLeftData);
        this.cubeMatrixDatas.push(this.treeRightData);
        this.cubeMatrixDatas.push(this.treeBottomData1);
        this.cubeMatrixDatas.push(this.treeBottomData2);
        this.cubeMatrixDatas.push(this.treeCenter1);
        this.cubeMatrixDatas.push(this.treeCenter2);
        this.cubeMatrixDatas.push(this.treeCenter3);
        this.cubeMatrixDatas.push(this.treeCenter4);
        this.cubeMatrixDatas.push(this.treeCenter5);
        //큐브로 생성할 메트리스
        // console.log("cubeMatrixDatas : ", this.cubeMatrixDatas);

        for(let i=0; i<this.cubeMatrixDatas.length; i++){
            // console.log(this.cubeMatrixDatas[i]);
            let cubeMatrix = new CubeMatrix(this.cubeMatrixDatas[i]);
            cubeMatrix.isTouchable = true;
            if(cubeMatrix.name.indexOf("tree") != -1){
                // console.log(cubeMatrix);
                this.cubeMatrixs.push(cubeMatrix);
                this.obstacles.push(cubeMatrix);
            }
        }

        // console.log("생성후 큐브매트릭스 : ", this.cubeMatrixs);
    }

    getObstacles(){
        return this.obstacles;
    }

        
    getRandom(){
        return Math.random() < 0.5;
    }

    update(ctx){
        if(this.blockMatrixs !== null && this.blockMatrixs.length !== 0){
            for(let i=0; i<this.blockMatrixs.length; i++){
                let matrix= this.blockMatrixs[i];
                matrix.draw(ctx);
            }
        }
        if(this.cubeMatrixs !== null && this.cubeMatrixs.length !== 0){
            for(let i=0; i<this.cubeMatrixs.length; i++){
                let matrix= this.cubeMatrixs[i];
                matrix.draw(ctx);   
            }
        }
    
    }
}