<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>화장품 첫 페이지</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .nav {
            background-color: white;
            padding: 10px;
            display: flex;
            justify-content: center;
            border-bottom: 2px solid #ddd;
        }
        .nav a {
            text-decoration: none;
            color: black;
            margin: 0 15px;
            font-weight: bold;
        }
        /* 메뉴가 top.jsp에 가려지지 않도록 여백 추가 */
        .menu-container {
            margin-top: 80px; /* 필요하면 조정 가능 */
        }
        .product-container {
            padding: 50px 0;
            text-align: center;
        }
        .footer {
            background-color: #206b68;
            color: white;
            padding: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>

    <!-- 기존 top.jsp 포함 (메뉴 캡션 유지) -->
    <jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>

    <!-- 추가된 메뉴가 가려지지 않도록 감싼 div -->
    <div class="menu-container">
        <div class="nav">
            <a href="#">카테고리</a>
            <a href="#">랭킹</a>
            <a href="#">커뮤니티</a>
        </div>
        <div class="nav">
            <a href="#">건성</a>
            <a href="#">지성</a>
            <a href="#">복합성</a>
            <a href="#">수부지</a>
            <a href="#">민감성</a>
            <a href="#">여드름</a>
        </div>

        <div class="product-container">
            <h2>화해 화장품 데이터 가져올 것들</h2>
            <p>여기에 다양한 화장품 데이터를 출력할 수 있습니다.</p>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 피부로그. All rights reserved.</p>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
