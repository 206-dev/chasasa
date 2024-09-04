/**
 * 
 */
// svg namespace 생성
const svgns = "http://www.w3.org/2000/svg"; 



const initialY = 150; // 첫 번째 막대의 y 위치 (y축의 아래쪽)
const labelY = initialY + 10; // x축 라벨의 y 위치
const axisColor = "black";
const fontSize = "10px";
const fontFamily = "Arial";
const width = 250;
const height = 200;

// card에 요소 추가하기
function addElementsToCard(card, options, svg) {
    const { addBarChart, addPieChart, addLegend, summaryJsObjects, width, height, count, labelName, transform, textContent} = options;
    
 	// color 배열 초기화
	let colors = [];
    for (let i = 0; i < summaryJsObjects.length; i++) {
        colors.push(getRandomColor());
    }
    
 	// 막대 그래프 그리기
    if (addBarChart) {
        let groupBarChart = drawBarChart(summaryJsObjects, 20, 30, width - 100, height - 60, colors, count, labelName);
        card.appendChild(groupBarChart);
    }
    
 	// 도넛 그래프 그리기
    if (addPieChart) {
        let groupPieChart = drawPieChart(summaryJsObjects, width, height, colors);
        card.appendChild(groupPieChart);
    }
    
 	// 범례 그리기
    if (addLegend) {
        let groupLegend = drawLegend(summaryJsObjects, width, height, colors, labelName);
        card.appendChild(groupLegend);
    }
 	
 	card.setAttribute("transform",transform);
 	
 	// makeText 함수를 사용하여 제목 생성
    let title = makeText(width / 2, 0, textContent, "16px", "Arial");

    // 텍스트 중앙 정렬
    title.setAttribute("text-anchor", "middle");

    // 검정색
    title.setAttribute("fill", "black");
    
    // 카드 그룹에 제목 추가
    card.appendChild(title);
 	
	svg.appendChild(card);
}
	
	
// 카드 만들기
function drawCard(width, height, color, summaryJsObjects, count, labelName) {
    // 그룹(g) 생성
    let group = document.createElementNS(svgns, "g");
    
	// 각 그룹에 클래스 부여
	group.setAttribute("class", "card-chart");
    
    // 카드(rect) 생성
    let rect = makeRect(10, 10, width, height);
    rect.setAttribute("fill", color);
    rect.setAttribute("class", "chart-background");
    rect.setAttribute("rx", 20);
	
    // SVG에 그룹 추가
    group.appendChild(rect);

    return group;
}

	
// 범례 그리기 함수
function drawLegend(summaryJsObjects, cardWidth, cardHeight, colors, labelName) {
	let group = document.createElementNS(svgns, "g");
	group.setAttribute("class", "legend");
	
	// 범례의 높이 계산
	let legendHeight = summaryJsObjects.length * 15; // 각 항목의 간격 15px * 항목 개수
    let legendX = cardWidth - 60;
	let legendY = (cardHeight - legendHeight) / 2 + 10; // 카드 중앙에 위치하도록 계산
    let rectSize = 10; // 색상 사각형 크기
    let spacing = 15; // 각 항목 사이의 간격
    let textOffset = 15; // 텍스트와 사각형 사이의 간격

    for (let i = 0; i < summaryJsObjects.length; i++) {
		color = colors[i];
        // 색상 사각형 생성
        let rect = makeRect(legendX, legendY - rectSize + 5, rectSize, rectSize);
        rect.setAttribute("fill", color);
        group.appendChild(rect);

        // 텍스트 생성
		let labelText;
		
		// labelName이 'Date'로 끝나는지 확인하여 처리
		if (labelName.endsWith('Date') && typeof summaryJsObjects[i][labelName] === 'number') {
		    // long 타입 타임스탬프를 Date 객체로 변환
		    let timestamp = summaryJsObjects[i][labelName];
		    let date = new Date(timestamp);
		
		    // 원하는 날짜 형식으로 변환
		    let options = { year: 'numeric', month: '2-digit', day: '2-digit' }; // 예시 포맷: MM/DD/YYYY
		    labelText = date.toLocaleDateString("en-US", options); // 또는 date.toLocaleString()으로 시간 포함
		} else {
		    // 그 외의 경우에는 문자열 그대로 사용
		    labelText = summaryJsObjects[i][labelName];
		}

        console.log("범례","labelText:",labelText);
        let text = makeText(legendX + textOffset, legendY, labelText, "10px", "Arial");
        text.setAttribute("fill", color);
        group.appendChild(text);

        // 다음 항목을 위한 y 위치 조정
        legendY += spacing;
    }
    return group;
}

// 원형차트 그리기
function drawPieChart(summaryJsObjects, cardWidth, cardHeight, colors) {
	// 원형 차트의 중심과 반지름을 카드 크기에 맞게 설정
	let cx = (cardWidth-100) / 2 + 10;  // 차트 영역의 중앙 위치
    let cy = cardHeight / 2 + 10;  // 카드의 중앙 위치
    let r = Math.min((cardWidth - 140), (cardHeight - 60)) / 2; // 반지름을 더 크게 설정
	
	let group = document.createElementNS(svgns, "g");
	group.setAttribute("class", "pie-chart");
	
    let countText = [];
    for (let i = 0; i < summaryJsObjects.length; i++) {
        countText.push(summaryJsObjects[i].count); // count 텍스트를 저장
        colors.push(getRandomColor()); // 각 조각에 사용할 색상을 미리 저장
    }
    let pies = createPieSegments(countText, summaryJsObjects, cx, cy, r, colors);
    for (let i = 0; i < pies.length; i++) {
        group.appendChild(pies[i]);
    }
    return group;
}

// 원형차트 조각 생성
function createPieSegments(countText, summaryJsObjects, cx, cy, r, colors) {
    let totalCount = 0;
    let paths = []; // 최종적으로 반환할 path 객체 배열
    
    // 총 count 계산
    for (let i = 0; i < countText.length; i++) {
        totalCount += countText[i];
    }
    
    let startAngle = 0;
    
    // 각도와 좌표, 경로 생성
    for (let i = 0; i < countText.length; i++) {
        let theta;
        
        if (countText.length === 1) {
	    // 데이터가 1개일 때, 전체 원을 차지하도록 설정
	    theta = 2 * Math.PI;
	
	    // 전체 원을 그리기 위한 특별한 좌표 설정
	    const d = [
	        "M", cx, cy, // 시작점: 원의 중심
	        "m", -r, 0, // 중심에서 왼쪽으로 r만큼 이동
	        "a", r, r, 0, 1, 0, r * 2, 0, // 반원을 그리기
	        "a", r, r, 0, 1, 0, -r * 2, 0, // 다시 반원을 그리기
	        "Z" // 경로 닫기
	    ].join(" ");
	
	    // path 요소 생성
	    const path = document.createElementNS(svgns, "path");
	    path.setAttribute("d", d);
	    path.setAttribute("fill", colors[i]); // 미리 저장한 색상 사용
	
	    // path 객체를 배열에 추가
	    paths.push(path);
	
	    // 텍스트의 중앙 위치 계산 (반지름을 줄여서 중앙에 텍스트 위치)
	    let textX = cx;
	    let textY = cy;
	
	    // makeText 함수를 사용하여 텍스트 요소 생성
	    const text = makeText(textX, textY, (summaryJsObjects[i].percentage * 100).toFixed(2) + "%", "10px", "Arial");
	    text.setAttribute("fill", "black");
	
	    // 텍스트 요소를 paths 배열에 추가
	    paths.push(text);
	} else {
            // 각도 계산
            theta = 2 * countText[i] * Math.PI / totalCount;
            let endAngle = startAngle + theta;
            let midAngle = startAngle + theta / 2;
    
            // 좌표 계산
            let startX = cx + r * Math.cos(startAngle);
            let startY = cy + r * Math.sin(startAngle);
            let endX = cx + r * Math.cos(endAngle);
            let endY = cy + r * Math.sin(endAngle);
    
            // 큰 호 플래그 계산 (부채꼴이 180도 이상인지 여부)
            let largeArcFlag = theta > Math.PI ? 1 : 0;
    
            // 경로 생성
            const d = [
                "M", cx, cy, // 시작점: 원의 중심
                "L", startX, startY, // 첫 번째 점으로 직선 그리기
                "A", r, r, 0, largeArcFlag, 1, endX, endY, // 원호 그리기
                "Z" // 경로 닫기
            ].join(" ");
    
            // path 요소 생성
            const path = document.createElementNS(svgns, "path");
            path.setAttribute("d", d);
            path.setAttribute("fill", colors[i]); // 미리 저장한 색상 사용
    
            // path 객체를 배열에 추가
            paths.push(path);
    
            // 텍스트의 중앙 위치 계산 (반지름을 줄여서 중앙에 텍스트 위치)
            let textX = cx + (r * 0.6) * Math.cos(midAngle);
            let textY = cy + (r * 0.6) * Math.sin(midAngle);
    
            // makeText 함수를 사용하여 텍스트 요소 생성
            const text = makeText(textX, textY, (summaryJsObjects[i].percentage * 100).toFixed(2) + "%", "10px", "Arial");
            text.setAttribute("fill", "black");
    
            // 텍스트 요소를 paths 배열에 추가
            paths.push(text);
    
            // 다음 조각을 위해 시작 각도를 갱신
            startAngle = endAngle;
        }
    }
    
    return paths; // path 객체 배열을 반환
}



	
// 막대 차트 그리기
function drawBarChart(summaryJsObjects, startX, startY, chartWidth, chartHeight, colors, count, labelName) {
	let group= document.createElementNS(svgns, "g");
	group.setAttribute("class", "bar-chart");
    	
	let barHeight = [];
	let bars = [];
	let text = [];
	let axisLabel = [];
	let countText = [];
	let countLabel = [];

	// 막대의 너비와 간격을 계산 (모든 막대가 카드에 들어가도록)
	let barCount = summaryJsObjects.length;
	let maxBarWidth = chartWidth / (barCount * 1.5);
	let barWidth = Math.min(maxBarWidth, 20); // 막대 너비를 20px로 제한
	let xIncrement = (barCount > 1) ? (chartWidth - barWidth * barCount) / (barCount - 1) + barWidth : 0;

	let initialX = startX;
	let initialY = startY + chartHeight;
	let labelY = initialY + 20;

	// 받은 데이터로부터 count와 boardType 값을 각각 barHeight와 text 배열에 담음
	for (let i = 0; i < summaryJsObjects.length; i++) {
		barHeight.push(summaryJsObjects[i][count] * (chartHeight / 100)); // 막대 높이 비율 조정
		text.push(summaryJsObjects[i][labelName]); // 라벨 텍스트를 저장
		countText.push(summaryJsObjects[i][count]); // count 텍스트를 저장
	}

    // barHeight와 text 배열로부터 막대와 라벨을 생성하여 배열에 담음
    for (let i = 0; i < barHeight.length; i++) {
		// 각 막대의 x 위치를 계산
		let x = initialX + i * xIncrement;
		// count y위치 계산
		let countY = initialY - barHeight[i] - 10;
		
		console.log("x",labelName,x);
		// 막대(rect)와 라벨(label), 카운트(number) 요소 생성
		let rect = makeRect(x, initialY - barHeight[i], barWidth, barHeight[i]);
		let label = makeText(x + barWidth / 2, labelY, text[i], fontSize, fontFamily);
		let number = makeText(x + barWidth / 2, countY, countText[i], fontSize, fontFamily);

		// 막대 색상과 라벨, count 색상 설정
		rect.setAttribute("fill", colors[i]);
		label.setAttribute("fill", axisColor);
		label.setAttribute("text-anchor", "middle"); // 라벨을 중앙 정렬
		number.setAttribute("fill", axisColor);
		number.setAttribute("text-anchor", "middle"); 
            
		// 생성된 막대와 라벨, count를 각각 배열에 추가
		bars.push(rect);
		axisLabel.push(label);
		countLabel.push(number);
	}

    // 생성된 막대와 라벨을 그룹(group) 요소에 추가
	for (let i = 0; i < bars.length; i++) {
		group.appendChild(bars[i]); // 막대 추가
		// group.appendChild(axisLabel[i]); // 라벨 추가
		group.appendChild(countLabel[i]); // count 추가
	}
	return group;
}
	
// 랜덤 색상 생성기
	function getRandomColor() {
		const letters = '0123456789ABCDEF';
		let color = '#';
		for (let i = 0; i < 6; i++) {
		color += letters[Math.floor(Math.random() * 16)];
	}
	return color;
}
    
// 텍스트 만들기
function makeText(x, y, content, fontSize, fontFamily) {
    let text = document.createElementNS(svgns, "text");
    text.setAttribute("x", x);
    text.setAttribute("y", y);
    text.setAttribute("font-size", fontSize);
    text.setAttribute("font-family", fontFamily);
    text.textContent = content;
	return text;
}

// 네모난 칸 만들기
function makeRect(x, y, width, height){
	let rect = document.createElementNS(svgns, "rect");
	rect.setAttribute("x", x);
	rect.setAttribute("y", y);
	rect.setAttribute("width", width);
	rect.setAttribute("height", height);
	return rect;
}
    
// 모든 .card-chart 요소에 대해 hover 이벤트 리스너 추가
function setHoverListener(){
    $('.card-chart').hover(
        function() {
            // 마우스를 올렸을 때, 부모 g 요소에 클래스 추가
            $(this).addClass('hovered');
        },
        function() {
            // 마우스가 떠났을 때, 부모 g 요소에서 클래스 제거
            $(this).removeClass('hovered');
        }
    );
}
	
// 모든 .card-chart 요소에 대해 클릭 이벤트 리스너 추가
function setClickListener(index){
    const cardCharts = document.querySelectorAll('.card-chart');
    cardCharts.forEach(function(cardChart) {
        cardChart.addEventListener('click', function() {
            index++; // 클릭할 때마다 index 증가
            chartDisplay(cardChart, index); // index 값에 따라 차트를 표시/숨김 처리
        });
    });
}

function chartDisplay(cardChart, index) {
    const barChart = cardChart.querySelector('.bar-chart');
    const pieChart = cardChart.querySelector('.pie-chart');
    
    if (barChart) {
        barChart.style.display = (index % 2 === 0) ? 'block' : 'none';
    }
    
    if (pieChart) {
        pieChart.style.display = (index % 2 === 1) ? 'block' : 'none';
    }
}
