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
<%--本地文件：美化文件上传按钮--%>
	<link rel="stylesheet" href="../../static/css/fileUpload.css">
	<script>
		//弹窗确认操作
		function toComfirm(){
			var flag =confirm("确认要保存修改？");
			if(flag){
				return true;
			}else{
				return false;
			}
		};
		//表单校验
		function checkForm2() {
			if(document.getElementById("uName").value != "" & /^[\u4E00-\u9FA5]{2,9}$/.test(document.getElementById("uName").value)==false){
				alert("姓名格式：中文名称（2-9字）");
				return false;
			}
			if(document.getElementById("userPhone").value != "" & /^1\d{10}$/.test(document.getElementById("userPhone").value)==false){
				alert("手机号格式：由1开头的11数字组成");
				return false;
			}
			if (document.getElementById("idNumber").value != "" & /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/.test(document.getElementById("idNumber").value)==false){
				alert("身份证号格式不符(18位合法身份证号：包含生日信息)！");
				return false;
			}
			if (document.getElementById("userAddress").value != "" & document.getElementById("userAddress").value.length>100){
				alert("地址长度不能超过100位");
				return false;
			}
			if (!checkFileType(document.getElementById("upload").value) & document.getElementById("upload").value !=""){
				alert("只能上传图片格式的文件（.jpg/.png/.gif）");
				return false;
			}
			return toComfirm();
		}
		//判断上传文件是否为图片格式
		function checkFileType(fileName) {
			var flag = false;
			var arr = ["jpg","png","gif","JPG","PNG"];
			var ext = fileName.substr(fileName.lastIndexOf(".")+1);
			for (var i=0;i<arr.length;i++){
				if (ext == arr[i]){
					flag = true;
					break;
				}
			}
			return flag;
		}

	</script>
</head>
<body>
	<div class="ui middle aligned center aligned mt-1 mr-3 ml-3">
		<div class="ui placeholder segment">
			<form class="ui form" onsubmit="return checkForm2()" action="${pageContext.request.contextPath}/user/updateUser?userName=${showUpdateUser.userName}" method="post" enctype="multipart/form-data">
	  			<table class="ui compact celled definition table">
					  <thead class="full-width">
					  	<tr>
					  		<th colspan="7" class="ui middle aligned center aligned"><font size="5">修改用户个人信息</font></th>
					  	</tr>
					    <tr>
					      <th>用户名</th>
					      <td><font size="3"><input type="text" name="uName" placeholder="${showUpdateUser.uName}" id="uName"/></font></td>
					      <th>账号</th>
					      <td style="line-height: 250%;"><font size="3">${showUpdateUser.userName}</font></td>
					      <th>性别</th>
					      <td style="line-height: 250%;"><font size="3">
					      		<select name="userSex">
					      			<option value="${showUpdateUser.userSex}"><%=session.getAttribute("showUpdateUserSex").equals(1) ? "男":"女"%></option>
					      			<option value="1">男</option>
									<option value="0">女</option>
					      		</select>
					      </font></td>
					      <th style="margin-right: 0;height: 26px;width: 20px;" rowspan="3"><img src="http://localhost:9090/uploads/${showUpdateUser.userImage}" alt="头像" width="120px" height="140px"/></th>
					    </tr>
					    <tr>
					    	<th>联系电话</th>
					      <td><font size="3"><input type="text" name="userPhone"  placeholder="${showUpdateUser.userPhone}" id="userPhone"/></font></td>
					      <th>证件号码</th>
					      <td><font size="3"><input type="text" name="idNumber"  placeholder="${showUpdateUser.idNumber}" id="idNumber"/></font></td>
					      <th>账号状态</th>
					      <td style="line-height: 250%;"><font size="3"><%=session.getAttribute("showUpdateUserStatus").equals(1) ? "正常":"已封禁"%></font></td>
					    </tr>	
							<tr>
								<th>常住地址</th>
								<td colspan="5"><input type="text" placeholder="${showUpdateUser.userAddress}" name="userAddress" id="userAddress"/></td>
							</tr>
							<tr>
								<th>注册时间</th>
								<td colspan="5" style="line-height: 280%;"><font size="3">${showUpdateUser.registerTime}</font></td>
								<th class="fileUpload container-fluid">
									<button class="ui inverted primary button" >更改头像<input type="file" name="upload" id="upload"/></button>
								</th>
							</tr>
					  </thead>
					  <tfoot class="full-width">
					    <tr>
					    	<th colspan="7" class="">
					     		<input class="field ui button fluid green" type="submit" value="保存修改"/>
					      </th>
					    </tr>
					  </tfoot>
					</table>
			</form>
		</div>
	</div>
</body>	
</html>
