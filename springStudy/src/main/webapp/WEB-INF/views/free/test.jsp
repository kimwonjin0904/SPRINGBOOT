<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
</head>
<script src="https://code.jquery.com/jquery-3.7.1.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script type="text/javascript">
	$(document).ready(function(){
		$("#mainSelect").change(function(){
			 var code = $(this).val();
			 $.ajax({
				   url :'<c:url value="/api/getSubCodes" />'
				  ,type :'GET'
				  ,data : {"commParent" : code}
				  ,dataType:'json'
				  ,success : function(res){
					  console.log(res);
					  $("#subSelect").empty().append('<option>-- 선택하세요 --</option>');
					  $.each(res, function(idx, item){
						 $("#subSelect").append('<option>' +item.commNm+ '</option>'); 
					  });
				  }
			 });
		});
	});
	
</script>
<body>
	<div class="col-sm-2">
		<select id="mainSelect" class="form-control input-sm">
			<option value="">-- 전체 --</option>
			<c:forEach items="${comMainList}" var="code">
				<option value="${code.commCd}">${code.commNm}</option>
			</c:forEach>
		</select>
		<select id="subSelect">
			<option></option>
		</select>
	</div>
</body>

</html>






