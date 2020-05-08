<%@ page contentType="text/html;charset=UTF-8" errorPage="500.jsp" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>success</title>

</head>
<body>
    <script>
        window.onload=function () {
            var flag = confirm("${success}");
            if(flag || !flag){
                history.back(-1);//返回上一页面
            }
        }
    </script>
</body>
</html>
