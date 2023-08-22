<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="EUC-KR">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
		<style>
			.formWrap {
				height: 300px;
				width: 600px;
				margin-top: 50px;
				margin-left: auto;
				margin-right: auto;
				border-radius: 20px;
				background-color: white;
			}

			.inputForm {
				border: none;
			}

			.formWrap>.pp {
				border: 0px;
			}

			input[type='text'] {
				width: 100%;
				display: inline;

			}

			p {
				font-size: 8px;
			}

			#num {
				width: 10%;
			}

			#num,
			#title {
				height: 30px;
				border-radius: 10px;
			}

			textarea {
				width: 100%;
				height: 100px;
				border-radius: 10px;
				vertical-align: top
			}

			button {
				border-radius: 20px;
				width: 80px;
				height: 20px;
				border: 1px solid black;
			}

			#hits {
				width: 80px;
				border: none;
				outline: none;
			}
		</style>
	</head>

	<body>
		<div id="wrap">
			<div id="header">BoardView.jsp</div>

			<%@ include file="Menu.jsp" %>

				<div id="contents">
					<div class="formWrap">
						<form>
							<div style="border: none;">
								<p>글번호</p>
								<div class="inputForm" style="display:flex;">
									<input type="text" id="num" value="${Board.bno}" readonly>
									<input type="text" id="hits" value="조회수 : ${Board.bhits}" readonly>
								</div>
								<p>제목</p>
								<div class="inputForm">
									<p class="bcontents">${Board.btitle}</p>
								</div>
								<p>내용</p>
								<div class="inputForm">
									<textarea>${Board.bcontents}</textarea>
								</div>
								<div class="formSubmit" style="border:none;">
									<c:if test="${sessionScope.LoginMemberId == Board.bwriter}">
										<button type="button" class="bmodBtn">글수정</button>
										<%-- BSTATE = '1' >> '0' 으로 수정
											1. 요청url : /boardDelete
											2. 글삭제 처리 후
												'??번' 글을 삭제하였습니다.' 출력
												게시판(글목록페이지)로 이동
										 --%>
										<button type="button" class="bdelBtn" onclick="location.href='${pageContext.request.contextPath }/BoardDelete?delBno=${Board.bno}'">글삭제</button>
									</c:if>
									<button type="button" class="blistBtn" onclick="location.href='${pageContext.request.contextPath}/Board'">
										목록</button>
								</div>
							</div>
						</form>
					</div>
				</div>
		</div>
	</body>

	</html>