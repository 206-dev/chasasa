function submitAnswer(answer) {
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "/quiz/answer", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const response = JSON.parse(xhr.responseText);
            if (!response.hasNext) {  // 마지막 문제일 때
                document.getElementById("quiz-container").innerHTML = `
                    <p>${response.resultMessage}</p>
                    <p>점수: ${response.score} / ${response.totalQuestions}</p>
                    <a href="${response.resultLink}" class="link-button">${response.boardtype} 게시판으로 출발!</a>
                `;
            } else {  // 다음 문제로 진행할 때
                document.getElementById("question-text").innerText = response.question;
                document.getElementById("currentQuestionNumber").innerText = response.currentQuestionNumber;
                document.getElementById("score").innerText = response.score;
            }
        }
    };

    xhr.send("answer=" + answer);
}