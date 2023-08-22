<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/main.css">
<style type="text/css">
.boardWrap {
	padding: 10px;
	background-color: white;
	border-radius: 10px;
	margin-left: auto;
	margin-right: auto;
	width: 700px;
}

.boardWrap>table {
	width: 100%;
	text-align: center;
	border-collapse: collapse;
}

th, td {
	padding-top: 7px;
	padding-bottom: 7px;
}

table {
	border: 2px solid #dfdfdf;
}

td {
	border-bottom: 2px solid black;
	border-top: 2px solid black;
}

.btitle {
	text-align: left;
	padding-left: 15px;
}

.boardUtil {
	border: 0px;
	margin-top: 10px;
}
</style>
</head>

<body>
	<div id="wrap">
		<div id="header">BoardList.jsp</div>
		<%@ include file="Menu.jsp"%>
		<div id="contents">
			<h1>게시판 ${param.searchTitle }</h1>
			<div class="boardWrap">
				<table>
					<thead>
						<tr>
							<th style="width: 100px;">번호</th>
							<th class="btitle">제목</th>
							<th style="width: 115px;">작성자</th>
							<th style="width: 80px;">조회수</th>
							
						</tr>
					</thead>
					<tbody>
						<%-- bList 반복 시작 --%>
						<c:forEach items="${bList }" var="board">

							<tr>
								<td>${board.bno }</td>
								<td class="btitle">
                                    <a href="${pageContext.request.contextPath}/BoardView?viewBno=${board.bno}"> ${board.btitle }</a>
                                </td>
								<td>${board.bwriter}</td>
								<td>${board.bhits}</td>

							</tr>
						</c:forEach>
						<%-- bList 반복 끝 --%>
					</tbody>
				</table>

				<div class="boardUtil">
					<c:if test="${sessionScope.LoginMemberId != null }">
						<button
							onclick="location.href='${pageContext.request.contextPath}/BoardWriteForm'">글작성</button>
					</c:if>
					<form action="${pageContext.request.contextPath}/BoardSearch" method="get">
						<input type="text" name ="searchTitle" placeholder="제목검색...">
						<input type="submit" value="검색">
					</form>

				</div>
			</div>
			<!-- boardWrap끝 -->
		</div>
	</div>
</body>
<script src="${pageContext.request.contextPath}/JS/Main.js"></script>
</html>