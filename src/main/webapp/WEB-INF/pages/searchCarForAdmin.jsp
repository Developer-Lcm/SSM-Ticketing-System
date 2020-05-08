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
			<form class="ui form placeholder segment" action="${pageContext.request.contextPath}/car/searchCar/admin" method="post">
				<div class="five fields">
			      	<div class="field">
			      		<label>车辆类型</label>
			        	<select class="ui fluid dropdown" name="carType">
							<option value="tips">请选择车辆类型</option>
					        <option value="G">高铁</option>
						    <option value="D">动车</option>
						    <option value="C">城轨</option>
						    <option value="K">火车快车</option>
						    <option value="Z">火车直达</option>
				      	</select>
			      	</div>
			      	<div class="field">
			        	<label>起点站</label>
			        	<input type="text" name="startStation" placeholder="start station">
			      	</div>
			      	<div class="field">
			        	<label>终点站</label>
			        	<input type="text" name="endStation" placeholder="ending station">
			      	</div>
			      	<div class="field">
			        	<label>出发时间</label>
			        	<input type="text" name="startDate" placeholder="start datetime" onfocus="(this.type='date') " onblur="(this.type='text')">
			      	</div>
			      	<div class="field">
			        	<label>列车长姓名</label>
			        	<input type="text" name="carHostName" placeholder="the name of Train Conductor"/>
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
					  		<th colspan="9"><font size="5">查询结果（共${adminSearchCarResult.size()}条记录）</font></th>
					  	</tr>
					    <tr>
					      <th>车辆编号</th>
					      <th>列车长</th>
					      <th>始发站</th>
					      <th>终点站</th>
					      <th>出站时间</th>
					      <th>到站时间</th>
					      <th>车票余量</th>
					      <th>票价</th>
					      <th class="ui right aligned center aligned"><span>执行操作&nbsp;&nbsp;</span></th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach items="${adminSearchCarResult}" var="car2">
							<tr onmouseover="this.bgColor='#DEDEDE'" onmouseout="this.bgColor=''">
								<td>${car2.carType}&nbsp;${car2.carNumber}</td>
								<td>${car2.carHostName}</td>
								<td>${car2.startStation}</td>
								<td>${car2.endStation}</td>
								<td>${car2.startDate}&nbsp;${car2.startTime}</td>
								<td>${car2.endDate}&nbsp;${car2.endTime}</td>
								<td>${car2.ticketValue}&nbsp;张</td>
								<td>￥ ${car2.ticketPrice}&nbsp;元</td>
								<td class="ui right aligned center aligned">
									<a class="circular ui icon inverted button green " href="${pageContext.request.contextPath}/car/CarDetail/showCarDetail?carId=${car2.carId}"><i class="icon eye"></i>&nbsp;&nbsp;详情&nbsp;</a>
									<a class="circular ui icon inverted button blue " href="${pageContext.request.contextPath}/car/CarDetail/showUpdateCar?carId=${car2.carId}"><i class="icon edit"></i>&nbsp;&nbsp;修改&nbsp;</a>
									<a class="circular ui icon inverted button red " href="${pageContext.request.contextPath}/car/deleteCar/${car2.carId}?position=searchCar" onclick="return toComfirm();"><i class="icon trash alternate"></i>&nbsp;&nbsp;删除&nbsp;</a>
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
