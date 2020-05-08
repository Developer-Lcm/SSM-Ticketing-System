<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" errorPage="500.jsp"%>
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
			<div class="ui form">
	  			<table class="ui compact celled definition table">
					  <thead class="full-width">
					  	<tr>
					  		<th colspan="6" class="ui middle aligned center aligned"><font size="5">车辆信息【Car Imformation】</font></th>
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
					      <td style="line-height: 250%;"><font size="3">${carDetail.carHostName}</font></td>
					    </tr>
					    <tr>
					    	<th>出站日期</th>
					      <td style="line-height: 250%;"><font size="3">${carDetail.startDate}</font></td>
					      <th>出站时间</th>
					      <td style="line-height: 250%;"><font size="3">${carDetail.startTime}</font></td>
					      <th>联系方式</th>
					      <td style="line-height: 250%;"><font size="3">${carDetail.carHostPhone}</font></td>
					    </tr>	
						<tr>
						  <th>到站日期</th>
					      <td style="line-height: 250%;"><font size="3">${carDetail.endDate}</font></td>
					      <th>到站时间</th>
					      <td style="line-height: 250%;"><font size="3">${carDetail.endTime}</font></td>
					      <th>车票价格</th>
					      <td style="line-height: 250%;"><font size="3">￥&nbsp;${carDetail.ticketPrice}&nbsp;元</font></td>
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
					    	<th colspan="6" class="">
								<a class="field ui button fluid blue" href="${pageContext.request.contextPath}/car/CarDetail/showUpdateCar?carId=${carDetail.carId}">修改车辆信息</a>
					      	</th>
					    </tr>
					  </tfoot>
					</table>
			</div>
		</div>
	</div>
</body>	
</html>
