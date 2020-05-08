<%@ page contentType="text/html;charset=UTF-8" errorPage="500.jsp" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
  <title>登录</title>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <link rel="icon" type="image/x-icon" href="static/img/BlogLogo.jpg" />
<!--Semantic UI-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
	<link rel="stylesheet" href="plugins/dist/css/adminlte.min.css">

	<script>
		function checkForm() {
			if (document.getElementById("userName").value.length>11 ||document.getElementById("userName").value.length<6){
				alert("账号格式有误：应为6-11个字符");
				return false;
			}
			if (document.getElementById("userPassword").value.length<8 || document.getElementById("userPassword").value.length>16){
				alert("密码格式有误：应为8-16个字符");
				return false;
			}
			return true;
		}
	</script>
</head>
<body style="background-color: #6d7a86">
	<div class="ui middle aligned center aligned grid " style="margin-top: 100px;">
		<div class="ui placeholder segment">
			<div class="ui two column stackable center aligned grid">
				<div class="ui vertical divider"></div>
				<div class="middle aligned row">
					<div class="column">
						<form class="ui form loginForm" action="${pageContext.request.contextPath}/user/login" method="post" onsubmit="return checkForm();">
							<div class="field ">
								<label style="text-align: left">Username</label>
								<div class="ui left icon input">
									<input type="text" placeholder="Username" name="userName" required="required" autofocus id="userName"/>
									<i class="user icon"></i>
								</div>
							</div>
							<div class="field">
								<label style="text-align: left">Password</label>
								<div class="ui left icon input">
									<input type="password" placeholder="Password" name="userPassword" required="required" autofocus id="userPassword"/>
									<i class="lock icon"></i>
								</div>
							</div>
							<div class=" two fields">
								<div class="ui toggle checkbox field">
									<input type="radio" name="identity" value="user" checked="checked" >
									<label style="text-align: left;">User</label>
								</div>
								<div class="ui toggle checkbox field">
									<input type="radio" name="identity" value="admin">
									<label style="text-align: left;margin-right: 60px">Admin</label>
								</div>
							</div>
							<div class="field">
								<input class="ui blue submit button fluid" type="submit" value="Login"/>
							</div>
							<div class="field">
								<%  //用于接收表单检验信息及反馈
									if(request.getAttribute("userLoginError") != null){  %>
										<div class="ui red basic button fluid "><%=request.getAttribute("userLoginError")%></div> <%
									}
								%>
							</div>
						</form>
					</div>
					<div class="column">
						<div class="field">
							<div class="ui icon header">
								<i class="user plus icon"></i>Add New Account
							</div>
						</div>
						<div class="ui big button blue">
							<i class="signup icon"></i>
							<a href="${pageContext.request.contextPath}/register.jsp"><font color="white">Sign Up</font></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
