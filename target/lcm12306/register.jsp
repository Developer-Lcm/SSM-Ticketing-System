<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户注册</title>
	<link rel="icon" type="image/x-icon" href="static/img/BlogLogo.jpg" />
    <!--Semantic UI-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
	<link rel="stylesheet" href="plugins/dist/css/adminlte.min.css">
	<script>
		//弹窗确认操作
		function toComfirm(){
			var flag =confirm("确认信息无误？");
			if(flag){
				return true;
			}else{
				return false;
			}
		};

		function checkForm() {
			if(/^[\u4E00-\u9FA5]{2,9}$/.test(document.getElementById("uName").value)==false){
				alert("姓名格式：中文名称（2-9字）");
				return false;
			}
			if (document.getElementById("userName").value.length>11 ||document.getElementById("userName").value.length<6){
				alert("账号格式有误：应为6-11个字符");
				return false;
			}
			if (document.getElementById("password").value.length<8 || document.getElementById("password").value.length>16){
				alert("密码格式有误：应为8-16个字符");
				return false;
			}
			if (document.getElementById("confirmPassword").value.length<8 || document.getElementById("confirmPassword").value.length>16){
				alert("密码格式有误：应为8-16个字符");
				return false;
			}
			if(document.getElementById("password").value != document.getElementById("confirmPassword").value){
				alert("两次输入的密码不一致！");
				return false;
			}
			return toComfirm();
		}

		//接收注册成功的提示，并作出反馈
		(function registerSuccess() {
			if(<%=request.getAttribute("registerSuccess")%>){
				alert("注册成功！稍后将跳转到登录页面");
				window.location.href="${pageContext.request.contextPath}/login.jsp";
			}
		})();

	</script>
</head>
<body style="background-color: #6d7a86">
	<div class="ui middle aligned center aligned grid " style="margin-top: 50px">
		<div class="ui placeholder segment">
			<div class="ui attached message">
			  <div class="header">
			    Welcome to our site!
			  </div>
			  <p>Fill out the form below to sign-up for a new account</p>
				</div>
				<form class="ui form attached fluid segment" action="${pageContext.request.contextPath}/user/register" onsubmit="return checkForm();" method="post" >
				  <div class="field">
				    <div class="field">
				      <label>Name</label>
				      <input placeholder="姓名：中文2-9字" type="text" name="uName" id="uName" required="required">
				    </div>
				  </div>
				  <div class="field">
				    <label>Username</label>
				    <input placeholder="账号长度：6-11个字符" type="text" name="userName" id="userName" required="required">
				  </div>
				  <div class="field">
				    <label>Password</label>
				    <input type="password" name="userPassword1" placeholder="密码长度：8-16个字符" id="password" required="required">
				  </div>
				  <div class="field">
				    <label>Confirm password</label>
				    <input type="password" name="userPassword2" placeholder="再次确认密码" id="confirmPassword" required="required">
				  </div>
				  <div class="field">
					<input class="ui blue submit button fluid" type="submit" value="Sign Up" id="submit_btn" required="required">
				  </div>
				  <div class="field">
					<%  //使用分段的java程序片来引入表单检验结果
						if (request.getAttribute("userRegisterError")!=null){  %>  <!--用于表单检验-->
							<div class="ui red basic button fluid"><%=request.getAttribute("userRegisterError")%></div><%
						}
					%>
				  </div>
				</form>
				<div class="ui bottom attached warning message">
				  <i class="icon help"></i>
				  Already signed up? <a href="${pageContext.request.contextPath}/login.jsp">Login here</a> instead.
				</div>
			</div>
		</div>
	</div>
</body>
</html>