<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">

		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
		<style>
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
				border: 1px solid #dfdfdf;
				padding: 5px;
				align-items: center;
				flex-wrap: flex;
				padding: 7px;
				border-radius: 10px;
			}

			.formInput>input[type='text'] {
				box-sizing: border-box;
				padding: 3px;
				width: 100%;
				height: 20px;
				border-radius: 20px;
				border: none;
				outline: none;
				margin-left: auto;
				margin-right: auto;
				margin-bottom: 10px;
				font-size: 20px;
				display: flex;
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

			.focusOn {
				border-color: green;
			}

			.checkMsg {
				color: blue;
				margin-top: 2px;
				margin-left: 10px;
				margin-bottom: 2px;
				font-size: 15px;
			}

			.d-none {
				display: none;
			}
		</style>

	</head>

	<body>
		<div id="wrap">
			<div id="header">LoginForm.jsp</div>

			<%@ include file="Menu.jsp" %>

				<div id="contents">
					<div class="formWrap">
						<form action="${pageContext.request.contextPath}/memLogin" method="LoginInput"
							onsubmit="return loginFormCheck(this)">
							<div class="formInput">
								<input type="text" name="LoginId" placeholder="아이디 입력">
							</div>
							<p class="checkMsg d-none" id="idMsg">아이디를 입력해주세요</p>
							<div class="formInput">
								<input type="text" name="LoginPw" placeholder="비밀번호 입력">
							</div>
							<p class="checkMsg d-none" id="pwMsg">비밀번호를 입력해주세요</p>
							<div class="formSubmit">
								<input type="submit" value="로그인">
							</div>
						</form>
					</div>
				</div>
		</div>
	</body>
	<script src="${pageContext.request.contextPath}/JS/Main.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script type="text/javascript">
		let loginEl = document.querySelectorAll(".formInput>input");
		for (let obj of loginEl) {
			obj.addEventListener('focus', function () {
				obj.parentElement.classList.add("focusOn");
			});
			obj.addEventListener('blur', function () {
				obj.parentElement.classList.remove("focusOn");
			})
		}
	</script>

	<script type="text/javascript">
		function loginFormCheck(formObj) {

			let idEl = formObj.LoginId;
			let pwEl = formObj.LoginPw;
			let checkForm = true;
			if (idEl.value == "") {
				document.getElementById("idMsg").classList.remove("d-none");
				checkForm = false;
			} else {
				document.getElementById("idMsg").classList.add("d-none");
			}
			if (pwEl.value == "") {
				document.getElementById("pwMsg").classList.remove("d-none");
				checkForm = false;
			} else {
				document.getElementById("pwMsg").classList.add("d-none");
			}
			return checkForm;
		}	
	</script>

	</html>