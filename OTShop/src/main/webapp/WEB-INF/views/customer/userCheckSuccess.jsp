<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/otshop.css">
<script type="text/javascript">

function userCheckClose(result, qseq){
	
    if (result == 1) {
        opener.location.href = "qnaList";
    } else if (result == 2) {
        opener.location.href = "qnaList";
    } else if (result == 3) {
        opener.location.href = "qnaView?qseq=" + "${qseq}";
    }
    self.close();
    
}


</script>

</head>
<body>
<div class="userCheck">
<span>${message}</span><br>
<input type="button" value="확인" onclick="userCheckClose('${result}' , '${qseq}')">
</div>
</body>
</html>