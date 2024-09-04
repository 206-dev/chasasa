<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/lee/include/header.jsp" %>
     	   <h3>신고 게시판</h3>
        <div class="table-Container">
            <table class="table" border="1">
                <tr>
                    <th class="table-head">번호</th>
                    <th class="table-head">제목</th>
                    <th class="table-head">글쓴이</th>
                    <th class="table-head">등록일</th>
                    <th class="table-head">추천</th>
                    <th class="table-head">조회</th>
                </tr>
                <tr>
                    <td>2</td>
                    <td class="table-Text-Left"><a href="#">글제목 - 2</a></td>
                    <td>글쓴이 - 2</td>
                    <td>04/07/22</td>
                    <td>1</td>
                    <td>97</td>
                </tr>
            </table>
            <div class="page-Container">
                <nav >
                    <ul class="page-ul">
                        <li class="page-item"><a href="#" class="page-link">이전</a></li>
                        <li class="page-item"><a href="#" class="page-link">1</a></li>
                        <li class="page-item"><a href="#" class="page-link">2</a></li>
                        <li class="page-item"><a href="#" class="page-link">3</a></li>
                        <li class="page-item"><a href="#" class="page-link">4</a></li>
                        <li class="page-item"><a href="#" class="page-link">5</a></li>
                        <li class="page-item"><a href="#" class="page-link">6</a></li>
                        <li class="page-item"><a href="#" class="page-link">7</a></li>
                        <li class="page-item"><a href="#" class="page-link">8</a></li>
                        <li class="page-item"><a href="#" class="page-link">9</a></li>
                        <li class="page-item"><a href="#" class="page-link">10</a></li>
                        <li class="page-item"><a href="#" class="page-link">다음</a></li>
                    </ul>
                </nav>
            </div>

            <div class="search-Container">
                <select name="" id="">
                    <option value="">제목</option>
                    <option value="">아이디</option>
                    <option value="">내용</option>
                    <option value="">제목+내용</option>
                </select>
                <input type="text">
                <button class="btn">검색</button>
            </div>
        </div>
        
<%@ include file="/WEB-INF/views/lee/include/footer.jsp"%>