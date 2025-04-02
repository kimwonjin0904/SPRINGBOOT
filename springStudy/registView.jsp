<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 400px;
            background: white;
            padding: 20px;
            margin: 0 auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        h2 {
            text-align: center;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .error {
            color: red;
            font-size: 0.9em;
        }
        .btn-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .signup-btn {
            background-color: #206b68;
            color: white;
            border: none;
            font-weight: bold;
            cursor: pointer;
            padding: 10px;
            border-radius: 5px;
        }
        .cancel-btn {
            background-color: #ccc;
            border: none;
            padding: 10px;
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>

    <div class="container">
        <h2>회원가입</h2>

        <form:form id="signupForm" modelAttribute="member" action="${pageContext.request.contextPath}/registDo" method="post">
            <!-- 아이디 입력 -->
            <label for="memId">아이디:</label>
            <form:input class="form-control" path="memId" name="memId" type="text" placeholder="아이디 입력" />
            <form:errors path="memId" cssClass="error" />

            <!-- 비밀번호 입력 -->
            <label for="memPw">비밀번호:</label>
            <form:input class="form-control" path="memPw" name="memPw" type="password" placeholder="비밀번호 입력" />
            <form:errors path="memPw" cssClass="error" />

            <!-- 비밀번호 확인 -->
            <label for="confirmMemPw">비밀번호 확인:</label>
            <input class="form-control" id="confirmMemPw" name="confirmMemPw" type="password" placeholder="비밀번호 재입력" />
            <p id="passwordMessage" class="error"></p>

            <!-- 이름 입력 -->
            <label for="memNm">이름:</label>
            <form:input class="form-control" path="memNm" name="memNm" type="text" placeholder="이름 입력" />
            <form:errors path="memNm" cssClass="error" />

            <div class="btn-container">
                <button class="signup-btn" type="submit" onclick="return validateForm()">회원가입</button>
                <button class="cancel-btn" type="button" onclick="history.back()">취소</button>
            </div>
        </form:form>
    </div>

    <jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>

    <!-- Modal -->
    <div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">${msgVO.title}</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="title">${msgVO.message}</label>
                    </div>
                    <a href="<c:url value='${msgVO.url}' />">${msgVO.urlTitle}로 가기</a>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            var password = document.getElementsByName("memPw")[0].value.trim();
            var confirmPassword = document.getElementById("confirmMemPw").value.trim();
            var message = document.getElementById("passwordMessage");

            if (!password || !confirmPassword) {
                message.textContent = "비밀번호를 입력해주세요.";
                return false;
            }

            if (password !== confirmPassword) {
                message.textContent = "비밀번호가 일치하지 않습니다.";
                return false;
            }

            return true;
        }

        $(document).ready(function(){
            var message = "${msgVO.message}";
            if(message !== ''){
                $("#messageModal").modal('show');
            }
        });
    </script>

</body>
</html>
