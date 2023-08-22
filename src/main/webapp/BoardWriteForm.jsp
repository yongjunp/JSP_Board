<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
        </head>
        <style type="text/css">
            .boardWrap {
                border: 5px solid black;
                box-sizing: border-box;
                border-radius: 20px;
                height: 400px;
                width: 100%;
            }
            form{
                border: none;
            }
            .formInput,.formSubmit{
                border: none;
            }
            #aText{
                width: 100%;
                height: 20px;
            }
            #bText{
                width: 100%;
                height: 400px;
            }
            .formSubmit>input[type='submit']{
                width: 80%;
                height: 30px;
                border-radius: 30px;
            }
            .write{
                border: none;
                margin-left: auto;
                margin-right:auto ;
            }


        </style>

        <body>
            <div id="wrap">
                <div id="header">BoardWriteForm.jsp</div>
                <%@ include file="Menu.jsp" %>
                    <div id="contents">
                        <h1>BoardWriteForm.jsp</h1>
                        <div id="boardWrap" style="border: none;">
                            <form action="${pageContext.request.contextPath}/BoardWrite" method="post">
                                <div class="write">
                                    <div class="formInput">
                                        <input id="aText" name="btitle" type="text" placeholder="글제목">
                                    </div>
                                    <div class="formInput">
                                        <textarea id="bText" name="bcontents" placeholder="글내용"></textarea>
                                    </div>
                                    <div class="formSubmit">
                                        <input type="submit" value="글등록">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
            </div>
        </body>

        </html>