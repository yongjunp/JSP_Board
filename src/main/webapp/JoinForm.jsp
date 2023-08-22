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
				JoinForm.jsp
			</div>
			<%@ include file="Menu.jsp" %>
				<div id="contents">
					<%-- 아이디, 비밀번호, 이름, 생년월일, 주소 --%>
						<div class="formWrap">
							<form action="${pageContext.request.contextPath}/memJoin" method="formInput" onsubmit="return joinCheckForm(this)">
								<div class="formInput">
									<input type="text" name="joinId" onblur="idChechk(this)" placeholder="아이디입력">
								</div>
								<p class="checkMsg" id="idMsg"></p>

								<div class="formInput">
									<input type="text" name="joinPw" placeholder="비밀번호입력">
								</div>

								<div class="formInput">
									<input type="text" name="joinName" placeholder="이름">
								</div>

								<div class="formInput">
									<input type="date" name="joinBirth">
								</div>

								<div class="formInput">
									<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
									<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호">
									<input type="text" name="address" id="sample6_address" placeholder="주소"><br>
									<input type="text" name="detailAddress" id="sample6_detailAddress"
										placeholder="상세주소">
									<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목">
								</div>

								<div class="formSubmit">
									<input type="submit" value="회원가입">
								</div>
							</form>
						</div>
				</div>
		</div>
	</body>
	<script src="${pageContext.request.contextPath}/JS/Main.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<!-- 아이디 중복 확인 시작 -->
	<script text="text/javascript">
		function idChechk(idTag) {
			console.log('입력한 아이디 : ' + idTag.value);
			let idMsg = $("#idMsg")
			/*ajax - 아이디 중복 확인 요청*/
			$.ajax({
				type: "get", /*get , post*/
				url: "memIdCheck", /*요청 url*/
				data: { "inputId": idTag.value }, /*전송할 데이터*/
				success: function (result) {
					if (result == "Y") {
						console.log("사용가능한 아이디");
						idMsg.css("color","green").text("사용가능한 아이디입니다.");
						$(idTag).parent().removeClass('formInputErr');
					} else {
						console.log("중복된 아이디");
						$(idMsg).css("color","red").text("중복된 아이디입니다.");
						$(idTag).parent().addClass('formInputErr');
					}

				} /*전송에 성공하면 실행*/

				//error : function(){} /*전송에 실패하면 실행*/
				//dataType : "json", /*응답받은 데이터 타입*/
			});
		}
	</script>

	<!-- 회원가입 양식 시작부분 -->
	<script type="text/javascript">
		let inputEls = document.querySelectorAll(".formInput>input");
		for (let obj of inputEls) {
			obj.addEventListener('focus', function () {
				obj.parentElement.classList.add("formInputOn");
			});
			obj.addEventListener('blur', function () {
				obj.parentElement.classList.remove("formInputOn");
			});
		}
		function joinCheckForm(formObj) {
			//아이디 ~ 주소 모두 입력되어있으면 submit 실행
			//하나라도 미입력 되어있으면 submit중지
			//미입력된 항목으로 포커스
			let idEl = formObj.joinId;
			let pwEl = formObj.joinPw;
			let NameEl = formObj.joinName;
			let birthEl = formObj.joinbirth;
			let postcodeEl = formObj.joinpostcode;
			let addressEl = formObj.joinaddress;
			let detailAddressEl = formObj.joindetailAddress;
			let extraAddressEl = formObj.joinextraAddress;
			if (idEl.value == "") {
				alert("모든 칸을 입력해주시오.d");
				idEl.focus();
				return false;
			}
			if (pwEl.value == "") {
				alert("모든 칸을 입력해주시오.d");
				pwEl.focus();
				return false;
			}
			if (NameEl.value == "") {
				alert("모든 칸을 입력해주시오.d");
				NameEl.focus();
				return false;
			}
			if (birthEl.value == "") {
				alert("모든 칸을 입력해주시오.d");
				birthEl.focus();
				return false;
			}
			if (postcodeEl.value == "") {
				alert("모든 칸을 입력해주시오.d");
				postcodeEl.focus();
				return false;
			}
			if (addressEl.value == "") {
				alert("모든 칸을 입력해주시오.d");
				addressEl.focus();
				return false;
			}
			if (detailAddressEl.value == "") {
				alert("모든 칸을 입력해주시오.d");
				detailAddressEl.focus();
				return false;
			}
			if (extraAddressEl.value == "") {
				alert("모든 칸을 입력해주시오.d");
				extraAddressEl.focus();
				return false;
			}
			return true;

		}
	

	</script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>

		function sample6_execDaumPostcode() {
			new daum.Postcode({
				oncomplete: function (data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수

					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if (data.userSelectedType === 'R') {
						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraAddr !== '') {
							extraAddr = ' (' + extraAddr + ')';
						}
						// 조합된 참고항목을 해당 필드에 넣는다.
						document.getElementById("sample6_extraAddress").value = extraAddr;

					} else {
						document.getElementById("sample6_extraAddress").value = '';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('sample6_postcode').value = data.zonecode;
					document.getElementById("sample6_address").value = addr;
					// 커서를 상세주소 필드로 이동한다.
					document.getElementById("sample6_detailAddress").focus();
				}
			}).open();
		}
	</script>

	</html>