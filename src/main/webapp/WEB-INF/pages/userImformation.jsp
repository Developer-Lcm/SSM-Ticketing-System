<%@ page import="cn.lcm.domain.User" %>
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
	<script>
		//弹窗确认操作
		function toComfirm(){
			var flag =confirm("执行此操作？");
			if(flag){
				return true;
			}else{
				return false;
			}
		};
	</script>
</head>
<body>
	<div class="ui middle aligned center aligned mt-1 mr-3 ml-3">
		<div class="ui placeholder segment">
			<form class="ui form">
	  			<table class="ui compact celled definition table">
					  <thead class="full-width">
					  	<tr>
					  		<th colspan="7" class="ui middle aligned center aligned"><font size="5">用户个人信息【user imformation】</font></th>
					  	</tr>
					    <tr>
					      <th>用户名</th>
					      <td style="line-height: 250%;"><font size="3">${userDetail.uName}</font></td>
					      <th>账号</th>
					      <td style="line-height: 250%;"><font size="3">${userDetail.userName}</font></td>
					      <th>性别</th>
					      <td style="line-height: 250%;"><font size="3" class="td_userSex"><%=session.getAttribute("userDetail_sex").equals(1) ? "男":"女"%></font></td>
					      <th style="margin-right: 0;height: 26px;width: 20px;" rowspan="3"><img src="http://localhost:9090/uploads/${userDetail.userImage}" alt="头像" width="120px" height="140px"/></th>
					    </tr>
					    <tr>
					    	<th>联系电话</th>
					      <td style="line-height: 250%;"><font size="3">${userDetail.userPhone}</font></td>
					      <th>证件号码</th>
					      <td style="line-height: 250%;"><font size="3">${userDetail.idNumber}</font></td>
					      <th>账号状态</th>
					      <td style="line-height: 250%;"><font size="3" class="td_userStatus"><%=session.getAttribute("userDetail_status").equals(1) ? "正常":"已封禁"%></font></td>
					    </tr>	
							<tr>
								<th>常住地址</th>
								<td colspan="5" style="line-height: 250%;"> <font size="3">${userDetail.userAddress}</font></td>
							</tr>
							<tr>
								<th>注册时间</th>
								<td colspan="5" style="line-height: 280%;"><font size="3">${userDetail.registerTime}</font></td>
								<th><font size="3" >&nbsp;&nbsp;用户头像</font></th>
							</tr>
					  </thead>
					  <tfoot class="full-width">
					    <tr>
					    	<th colspan="7" class="">
					     		<a class="field ui button fluid blue" href="${pageContext.request.contextPath}/user/showUpdateUser?userName=${userDetail.userName}">修改</a>
					      	</th>
					    </tr>
					  </tfoot>
					</table>
			</form>
		</div>
	</div>
</body>	
</html>
