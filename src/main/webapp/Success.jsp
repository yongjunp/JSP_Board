<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
    alert('${param.msg}'); 
    location.href="${pageContext.request.contextPath}/${param.url}";
    
</script>
</head>
<body>

</body>
</html>