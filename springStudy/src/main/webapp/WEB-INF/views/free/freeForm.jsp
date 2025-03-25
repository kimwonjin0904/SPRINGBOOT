<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp" ></jsp:include>
	<section class="page-section" id="contact">
		<div class="container" style="margin-top: 100px;">
		  <form action="<c:url value='/free/freeBoardWriteDo' />" method="post" onsubmit="return fn_check()">
                <table class="table table-striped table-bordered">
                    <tr>
                        <th>제목</th>
                        <td><input class="form-control input-sm" type="text" name="boTitle" required="required"></td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td><input class="form-control input-sm" type="text" name="boWriter" required="required"></td>
                    </tr>
                    <tr>
                        <th>비밀번호</th>
                        <td><input class="form-control input-sm" type="password" name="boPass" required="required"></td>
                    </tr>
                    <tr>
                    	<th>분류</th>
                    	<td>
                    		<select name="boCategory" class="form-control input-sm">
                    			<option value="">---선택---</option>
                    		</select>
                    	</td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td><textarea  class="form-control input-sm" name="boContent" id="bo_content"></textarea></td>
                    </tr>
                    <tr>
                     	<td colspan="2">
                     		<button type="submit" class="btn btn-primary">전송</button>
                     	</td>
                    </tr>
                    
                </table>
            </form>
		</div>
	</section>
	<jsp:include page="/WEB-INF/inc/footer.jsp" ></jsp:include>
</body>
<script type="text/javascript">
</script>
</html>






