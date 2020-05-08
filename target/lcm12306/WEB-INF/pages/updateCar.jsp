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
			var flag =confirm("确认要执行修改？");
			if(flag){
				return true;
			}else{
				return false;
			}
		};

		function checkForm_updateCar() {
			if(document.getElementById("startTime").value != "" & /^(?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]$/.test(document.getElementById("startTime").value)==false){
				alert("出发时间格式有误！（格式：00:00）");
				return false;
			}
			if(document.getElementById("endTime").value != "" & /^(?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]$/.test(document.getElementById("endTime").value)==false){
				alert("到达时间格式有误！（格式：00:00）");
				return false;
			}
			if(document.getElementById("carHostName").value != "" & /^[\u4E00-\u9FA5]{2,9}$/.test(document.getElementById("carHostName").value)==false){
				alert("列车长名称格式：全中文名称（2-10字）");
				return false;
			}
			if(document.getElementById("carHostPhone").value != "" & /^1\d{10}$/.test(document.getElementById("carHostPhone").value)==false){
				alert("手机号格式：由1开头的11数字组成");
				return false;
			}
			return toComfirm();
		}
	</script>
</head>
<body>
	<div class="ui middle aligned center aligned mt-1 mr-3 ml-3">
		<div class="ui placeholder segment">
			<form class="ui form" onsubmit="return checkForm_updateCar()" action="${pageContext.request.contextPath}/car/updateCar?carId=${carDetail.carId}" method="post">
	  			<table class="ui compact celled definition table">
					  <thead class="full-width">
					  	<tr>
					  		<th colspan="6" class="ui middle aligned center aligned"><font size="5">修改车辆信息</font></th>
					  	</tr>
					    <tr>
					      <th>车辆类型</th>
					      <td style="line-height: 250%;"><font size="3">
							  <%
								  String carType = (String) request.getAttribute("theCarType");
								  request.removeAttribute("theCarType");//立马删除域对象
								  switch (carType){
									  case "G": out.print("高铁");break;
									  case "D": out.print("动车");break;
									  case "K": out.print("快车");break;
									  case "Z": out.print("直达火车");break;
									  case "C": out.print("城轨");break;
								  }
							  %>
						  </font></td>
					      <th>车辆编号</th>
					      <td style="line-height: 250%;"><font size="3">${carDetail.carType}&nbsp;${carDetail.carNumber}</font></td>
					      <th>列车长</th>
					      <td style="line-height: 250%;"><font size="3"><input type="text" placeholder="${carDetail.carHostName}" name="carHostName" id="carHostName"/></font></td>
					    </tr>
					    <tr>
					    	<th>出站日期</th>
					      <td><font size="3"><input type="text" name="startDate" placeholder="${carDetail.startDate}" onfocus="(this.type='date')" onblur="(this.type='text')" id="startDate"/></font></td>
					      <th>出站时间</th>
					      <td><font size="3"><input type="text" name="startTime" placeholder="${carDetail.startTime}" id="startTime"/></font></td>
					      <th>联系方式</th>
					      <td style="line-height: 250%;"><font size="3"><input type="text" placeholder="${carDetail.carHostPhone}" name="carHostPhone" id="carHostPhone"/></font></td>
					      
					    </tr>	
						<tr>
							<th>到站日期</th>
					      <td><font size="3"><input type="text" name="endDate" placeholder="${carDetail.endDate}" onfocus="(this.type='date')" onblur="(this.type='text')" id="endDate"/></font></td>
					      <th>到站时间</th>
					      <td><font size="3"><input type="text" name="endTime" placeholder="${carDetail.endTime}" id="endTime"/></font></td>
					      <th>车票价格</th>
					      <td style="line-height: 250%;"><font size="3">${carDetail.ticketPrice}&nbsp;元</font></td>
					   </tr>	
					   <tr>
					   		<th>起点站</th>
					      <td style="line-height: 250%;"><font size="3">${carDetail.startStation}</font></td>
					      <th>终点站</th>
					      <td style="line-height: 250%;"><font size="3">${carDetail.endStation}</font></td>
					      <th>车票余量</th>
					      <td style="line-height: 250%;"><font size="3">${carDetail.ticketValue}&nbsp;张</font></td>
					   </tr>
					  </thead>
					  <tfoot class="full-width">
					    <tr>
							<th colspan="3">
								<a class="field ui button fluid blue" type="button" href="${pageContext.request.contextPath}/car/CarDetail/showCarDetail?carId=${carDetail.carId}">返回车辆详情页</a>
							</th>
					    	<th colspan="3">
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
