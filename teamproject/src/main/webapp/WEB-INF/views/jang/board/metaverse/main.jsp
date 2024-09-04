<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>	
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SVG Coordinates</title>
    <style>
        body {
            margin: 0;
            overflow: hidden;
        }
        svg {
            width: 100vw;
            height: 100vh;
            display: block;
        }
        text {
            font-size: 20px;
            fill: white;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>
"{ ,}"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 600" preserveAspectRatio="xMidYMid slice">
    <image height="100%" width="100%" href="/resources/jang/image/campground.jpeg" />
</svg> 
<script>
	$(function(){
		let background = `${background}`;
		let background = `${background.rows}`;
		console.log(background);
	});

    const svg = document.querySelector('svg');
    const coordsText = document.getElementById('coords');
    
	const area = [{x: 303, y: 104}, {x: 589, y: 292}, {x: 283, y: 503}, {x: 0, y: 314}];
	const coordinates = [];
	
	createCoordinates(6,6,area);
	
	function createCoordinates(rows, columns, polygon) {
	    let coordinates = [];
	    let point1 = polygon[0];
	    let point2 = polygon[1];
	    let point3 = polygon[2];  // 3번째 점은 index 2
	    let point4 = polygon[3];  // 4번째 점은 index 3

	    let portionRows = 1 / rows;
	    let portionColumns = 1 / columns;
	    
	    for (let i = 0; i <= rows; i++) {  // 0부터 rows까지 포함
	        let tempArray = [];
	        let calPoint1 = { 
	            x: point1.x + (point4.x - point1.x) * portionRows * i, 
	            y: point1.y + (point4.y - point1.y) * portionRows * i 
	        };
	        let calPoint2 = { 
	            x: point2.x + (point3.x - point2.x) * portionRows * i, 
	            y: point2.y + (point3.y - point2.y) * portionRows * i 
	        };
	        
	        for (let j = 0; j <= columns; j++) {  // 0부터 columns까지 포함
	            let point = { 
	                x: calPoint1.x + (calPoint2.x - calPoint1.x) * portionColumns * j, 
	                y: calPoint1.y + (calPoint2.y - calPoint1.y) * portionColumns * j 
	            };
	            tempArray.push(point);
	        }
	        
	        coordinates.push(tempArray);
	    }
	    
	    console.log(coordinates);
	    return coordinates;
	}

	
	
	// 점이 다각형 내부에 위치하고 있는지 판별(볼록 다각형 한정)
	// 1. 무게중심의 좌표를 구함(볼록 다각형의 경우 무게중심은 다각형 내부에 존재)
	// 2. 다각형의 연속한 두 점을 잇는 직선과, 무게중심 간의 위치를 판별 (무게중심의 x 또는 y 좌표 둘 중 하나만 이용)
	// 3. 다각형을 이루는 모든 직선과 무게 중심간의 위치가 true인 경우 다각형 내부에 존재함
	function isPointInPolygon(point, polygon){
		let isInside = false;
		// 무게중심객체
		let centroid = calculateCentroid(polygon);
		
		// 다각형과 무게중심 위치 관계 배열
		let centroidYRelations = calculateCriterias(centroid, polygon);
		
		// 다각형과 포인트 위치 관계 배열
		let pointYRelations = calculateCriterias(point, polygon);
		
		// 두 배열이 같으면 포인트가 내부에 위치
		console.log("centroidYRelations : " , centroidYRelations);
		console.log("pointYRelations : " , pointYRelations);
		
		// 두 배열의 크기가 같지 않으면 false
		if(centroidYRelations.length !== pointYRelations.length){
			return false;
		}
		
		// 두 배열의 값이 같지 않으면 false
		for (let i = 0; i < pointYRelations.length; i++) {
	        if (pointYRelations[i] !== centroidYRelations[i]) {
	            return false;
	        }
	    }
	    
		// 두 배열의 크기가 같고, 배열의 값이 같으면 true
	    return true;		
			
	}
	
	// 포인트와 다각형의 관계 정의 함수
	function calculateCriterias(point, polygon){
		// 판별 조건
		let criterias = [];
		
		// polygon [0, 1, 2, 3, ..., polygon.length]
		// index + 1을 비교
		// index + 1 이 polygon의 index를 벗어나는 경우 (length번째) 0번째를 비교
		
		// y = (y2-y1)/(x2-x1)*(x-x1) + y1
		
		for(let i = 0; i < polygon.length; i++){
			// i, i+1 번째 점을 이은 직선과 무게중심의 관계 구하기
			let x1 = polygon[i].x;
			let y1 = polygon[i].y;
			
			// 마지막번째에서 nextIndex는 0번째로 초기화
			let nextIndex = (i + 1) % polygon.length;
	        let x2 = polygon[nextIndex].x;
	        let y2 = polygon[nextIndex].y;
			
			let lineY = (y2-y1)/(x2-x1)*(point.x-x1) + y1
			
			if(point.y > lineY){
				criterias[i] = "+";
			} else{
				criterias[i] = "-";
			}
			
			console.log("lineY : ", lineY);
			console.log("point.y : ", point.y);
			
		} // for
		
		console.log(point + '의' +criterias);
		return criterias;
	} // isPointInPolygon
	
	
	// 다각형의 무게중심 구하기
	function calculateCentroid(vertices) {
    let n = vertices.length;
    let A = 0;
    let C_x = 0;
    let C_y = 0;

    for (let i = 0; i < n; i++) {
        let x0 = vertices[i].x;
        let y0 = vertices[i].y;
        let x1 = vertices[(i + 1) % n].x;
        let y1 = vertices[(i + 1) % n].y;

        let crossProduct = x0 * y1 - x1 * y0;
        A += crossProduct;
        C_x += (x0 + x1) * crossProduct;
        C_y += (y0 + y1) * crossProduct;
    }

    A = A / 2;
    C_x = C_x / (6 * A);
    C_y = C_y / (6 * A);

    return { x: C_x, y: C_y };
}
	

    svg.addEventListener('click', (event) => {
        const point = svg.createSVGPoint();
        point.x = event.clientX;
        point.y = event.clientY;
        const transformedPoint = point.matrixTransform(svg.getScreenCTM().inverse());
		let isInside = isPointInPolygon(point, area);
        
        if (transformedPoint.x != null && transformedPoint.y != null) {
            alert('Clicked at x: ' + Math.round(transformedPoint.x) + ', y: ' + Math.round(transformedPoint.y) + '내부에 있는가?:' + isInside);
        }
        
    });

</script>	

<span>Background : ${background}</span>
</body>
</html>
