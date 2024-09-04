<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/lee/chataverse/header.jsp" %>
<div class="genderContainer">
<script type="text/javascript" src="/resources/lee/js/chataverse/choicegender.js" defer></script>
	
	<h2>성별을 선택하세요!</h2>

	<div class="genderBox">
		<button type="button" class="btn-gender" id="btnMan">
			<img alt="man" src="/resources/lee/image/chabak/image/man.png">
		</button>
		<button type="button" class="btn-gender" id="btnWoman">
			<img alt="man" src="/resources/lee/image/chabak/image/woman.png">
		</button>	
	</div>
</div>
<%@ include file="/WEB-INF/views/lee/chataverse/footer.jsp" %>