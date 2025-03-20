<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글</title>
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	
    <!-- 로그인 -->
    <section class="page-section" id="contact" style="margin-top:150px">
        <div class="container">
            <!-- Contact Section Heading-->
            <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">게시글</h2>
            <!-- Icon Divider-->
            <div class="divider-custom">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                <div class="divider-custom-line"></div>
            </div>
            <!-- Contact Section Form-->
            <div class="row justify-content-center">
                <div class="col-lg-8 col-xl-7">
                       	<div class="mb-3">
                       		<label>제목</label>
                       		<h6>${board.boardTitle}</h6>
                       	</div>
                       	<div class="mb-3">
                       		<label>작성자</label>
                       		<h6>${board.memNm}</h6>
                       	</div>
                       	<div class="mb-3">
                       		<label>수정일</label>
                       		<h6>${board.updateDt}</h6>
                       	</div>
                       	<div class="mb-3">
                       		<label>내용</label>
                       		<textarea class="form-control" readonly>${board.boardContent }</textarea>
                       	</div>
                       	<c:if test="${sessionScope.login.memId == board.memId }">
                       		<form id="boardForm" action="<c:url value="/boardEditView" />" method="post">
                       			<input type="hidden" name="boardNo" value="${board.boardNo }">
                       			<input class="btn btn-warning btn-lx" type="submit" name="action" value="수정" >
                       			<input class="btn btn-danger btn-lx" type="submit"  name="action" value="삭제" >
                       		</form>
                       	</c:if>
                </div>
            </div>
        </div>
    </section>
    <script>
		 document.getElementById("boardForm").addEventListener("submit", function(e){
			  var clickBtn = e.submitter;
			  if(clickBtn.value=="삭제"){
				  if(!confirm("정말.. 삭제하시겠습니까?!")){
					  e.preventDefault();  // 취소 
					  return;
				  }
				  this.action = "<c:url value='/boardDeleteDo' />";
			  }
		 });
    
    
    </script>
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>        
</body>
</html>