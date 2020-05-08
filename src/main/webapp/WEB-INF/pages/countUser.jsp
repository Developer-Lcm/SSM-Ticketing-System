<%@ page import="cn.lcm.domain.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" errorPage="500.jsp" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
  <!-- Standard Meta -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <!-- Site Properties -->
<!--Semantic UI-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
	<link rel="stylesheet" href="../../plugins/dist/css/adminlte.min.css">
	<script type="text/javascript">
		//弹窗确认操作
		function toComfirm(){
			var flag =confirm("一旦执行无法撤销，确认要执行此操作？");
			if(flag){
				return true;
			}else{
				return false;
			}
		};

	</script>
	
<body>
	<%
		if("true".equals(request.getAttribute("haveUsers"))){
			request.removeAttribute("haveUsers"); //获取完立马删除域对象%>
			<div class="ui middle aligned center aligned mt-1 mr-3 ml-3">
				<div class="ui placeholder segment">
					<table class="ui compact celled definition table">
						<thead class="full-width">
						<tr>
							<th colspan="6"><font size="5">统计用户信息&nbsp;(共 ${userCount.size()} 条记录)</font></th>
						</tr>
						<tr>
							<th>用户名</th>
							<th>账号</th>
							<th>联系方式</th>
							<th>注册日期</th>
							<th>账号状态</th>
							<th class="ui right aligned center aligned"><span>执行操作&nbsp;&nbsp;</span></th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${userCount}" var="user">
							<tr onmouseover="this.bgColor='#DEDEDE'" onmouseout="this.bgColor=''">
								<td>${user.uName}</td>
								<td>${user.userName}</td>
								<td>${user.userPhone}</td>
								<td>${user.registerTime}</td>
								<td id="userStatus">${user.userStatus}</td>
								<td class="ui right aligned center aligned">
									<a class="circular ui icon inverted button green " href="${pageContext.request.contextPath}/user/userDetail?userName=${user.userName}"><i class="icon eye"></i>&nbsp;&nbsp;详情&nbsp;</a>
									<a class="circular ui icon inverted button blue " href="${pageContext.request.contextPath}/user/showUpdateUser?userName=${user.userName}"><i class="icon edit"></i>&nbsp;&nbsp;修改&nbsp;</a>
									<a class="circular ui icon inverted button red " href="${pageContext.request.contextPath}/user/deleteUser/countUser?userName=${user.userName}" onclick="return toComfirm();"><i class="icon trash alternate"></i>&nbsp;&nbsp;删除&nbsp;</a>
									<a class="circular ui icon inverted button yellow " href="${pageContext.request.contextPath}/user/banUser/countUser?userName=${user.userName}" onclick="return toComfirm();"><i class="icon user times"></i>&nbsp;&nbsp;解封/禁用&nbsp;</a>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div><%
		}else { %>
			<div class="ui middle aligned center aligned mt-1 mr-3 ml-3">
				<div class="ui placeholder segment">
					<table class="ui compact celled definition table">
						<thead class="full-width">
						<tr style="height: 550px;">
							<th colspan="10" class="ui center aligned center aligned">
								<div class="field">
									<div class="ui icon header">
										<i class="dont icon"></i>
										No users have signed up（暂无用户）
									</div>
								</div>
							</th>
						</tr>
						</thead>
					</table>
				</div>
			</div><%
		}
	%>


</body>
</html>
