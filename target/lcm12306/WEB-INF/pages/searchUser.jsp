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
			<form class="ui form placeholder segment" action="${pageContext.request.contextPath}/user/searchUser" method="post">
				<div class="four fields">
			      	<div class="field">
			      		<label>根据用户姓名查询</label>
			        	<input type="text" name="uName" placeholder="search by user name">
			      	</div>
			      	<div class="field">
			        	<label>根据账号查询</label>
			        	<input type="text" name="userName" placeholder="search by user account ">
			      	</div>
			      	<div class="field">
			        	<label>根据注册时间查询</label>
			        	<input type="text" name="registerTime" placeholder="search by register datetime" onfocus="(this.type='date') " onblur="(this.type='text')">
			      	</div>
			      	<div class="field">
			        	<label>根据联系方式查询</label>
			        	<input type="text" name="userPhone" placeholder=" search by user phone">
			      	</div>
					<div class="field">
						<label>根据常住地址查询</label>
						<input type="text" name="userAddress" placeholder=" search by user Address">
					</div>
					<div class="field">
						<label>根据账号状态查询</label>
						<select class="ui fluid dropdown" name="userStatus">
							<option value="2">请选择账号状态</option>
							<option value="1">正常</option>
							<option value="0">已封禁</option>
						</select>
					</div>
			  </div>
			  <input class="field ui button fluid green" type="submit" value="立即查询"/>
			</form>
			<!--查询结果-->
			<div class="results">
				<div class="ui placeholder segment">
					<table class="ui compact celled definition table">
					  <thead class="full-width">
					  	<tr>
					  		<th colspan="6"><font size="5">查询结果（共${searchUserResult.size()}条记录）</font></th>
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
						  <c:forEach items="${searchUserResult}" var="user">
							  <tr onmouseover="this.bgColor='#DEDEDE'" onmouseout="this.bgColor=''">
								  <td>${user.uName}</td>
								  <td>${user.userName}</td>
								  <td>${user.userPhone}</td>
								  <td>${user.registerTime}</td>
								  <td>${user.userStatus}</td>
								  <td class="ui right aligned center aligned">
									  <a class="circular ui icon inverted button green " href="${pageContext.request.contextPath}/user/userDetail?userName=${user.userName}"><i class="icon eye"></i>&nbsp;&nbsp;详情&nbsp;</a>
									  <a class="circular ui icon inverted button blue " href="${pageContext.request.contextPath}/user/showUpdateUser?userName=${user.userName}"><i class="icon edit"></i>&nbsp;&nbsp;修改&nbsp;</a>
									  <a class="circular ui icon inverted button red " href="${pageContext.request.contextPath}/user/deleteUser/searchUser?userName=${user.userName}" onclick="return toComfirm();"><i class="icon trash alternate"></i>&nbsp;&nbsp;删除&nbsp;</a>
									  <a class="circular ui icon inverted button yellow " href="${pageContext.request.contextPath}/user/banUser/searchUser?userName=${user.userName}" onclick="return toComfirm();"><i class="icon user times"></i>&nbsp;&nbsp;封禁/解封&nbsp;</a>
								  </td>
							  </tr>
						  </c:forEach>
					  </tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
