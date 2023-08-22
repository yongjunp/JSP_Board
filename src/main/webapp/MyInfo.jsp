<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">

		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
		<style type="text/css">
			.formWrap {
				margin-bottom: 0px;
				width: 400px;
				border: 3px solid black;
				padding: 10px;
				border-radius: 10px;
				background-color: white;
				margin-left: auto;
				margin-right: auto;
			}

			.formInput {
				margin-bottom: 0px;
				border: 1px solid #dfdfdf;
				border-radius: 7px;
				padding: 7px;
				align-items: center;
				flex-wrap: wrap;
			}

			.formInput>input[type='text'],
			.formInput>input[type='date'] {
				box-sizing: border-box;
				width: 100%;
				border: none;
				outline: none;
				padding: 5px;
				font-size: 20px;
			}

			.formInput>input[type='button'] {
				width: 100%;
				border-radius: 10px;
				padding: 3px;
				background-color: bisque;
				cursor: pointer;
				margin-bottom: 3px;
			}

			.formSubmit {
				border: none;
				border-radius: 7px;
				margin-top: 5px;
			}

			.formSubmit>input {
				background-color: bisque;
				width: 100%;
				padding: 10px;
				border-radius: 15px;
				font-weight: bold;
				font-size: 20px;
				cursor: pointer;
			}

			input[type='date'] {
				font-family: auto;
			}

			.formInputOn {
				border: 2px solid green;
			}

			.checkMsg {
				color: blue;
				margin-top: 2px;
				margin-left: 10px;
				margin-bottom: 2px;
				font-size: 15px;
			}
			.formInputOn{
				border: 2px solid green;
			}
			.formInputErr{
				border: 2px solid red !important;
			}
		</style>
	</head>

	<body>
		<div id="Wrap">
			<div id="header">
				MyInfo.jsp
			</div>
			<%@ include file="Menu.jsp" %>
				<div id="contents">
					<%-- 아이디, 비밀번호, 이름, 생년월일, 주소 --%>
						<div class="formWrap">
							<p style="font-size: 5px;">아이디</p>
								<div class="formInput">
									<input type="text" name="joinId" value="${mInfo.mid}" readonly>
								</div>
								<p class="checkMsg" id="idMsg"></p>
								<p style="font-size: 5px;">비밀번호</p>
								<div class="formInput">
									<input type="text" name="joinPw" value="${mInfo.mpw}" readonly>
								</div>
								<p style="font-size: 5px;">이름</p>
								<div class="formInput">
									<input type="text" name="joinName" value="${mInfo.mname}" readonly>
								</div>
								<p style="font-size: 5px;">생년월일</p>
								<div class="formInput">
									<input type="date" name="joinBirth" value="${mInfo.mbirth}" readonly>
								</div>
								<p style="font-size: 5px;">주소</p>
								<div class="formInput">
									<input type="text" value="${mInfo.maddr}" readonly>
								</div>

								
						</div>
				</div>
		</div>
	</body>
	</html>