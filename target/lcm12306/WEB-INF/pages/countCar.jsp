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
	<script
	  src="https://code.jquery.com/jquery-3.1.1.min.js"
	  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	  crossorigin="anonymous"></script>
	<script src="semantic/dist/semantic.min.js"></script>
	
	<link rel="stylesheet" href="../../plugins/dist/css/adminlte.min.css">

	
	<script type="text/javascript">
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
	
<body>
	<%
		if(request.getAttribute("haveCars").equals("true")){
			request.removeAttribute("haveCars");//获取完立马删除域对象 %>
			<div class="ui middle aligned center aligned mt-1 mr-3 ml-3">
				<div class="ui placeholder segment">
					<table class="ui compact celled definition table">
						<thead class="full-width">
						<tr>
							<th colspan="9"><font size="5">统计车辆信息&nbsp;(共${carCount.size()}条记录)</font></th>
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
						<c:forEach items="${carCount}" var="car">
							<tr onmouseover="this.bgColor='#DEDEDE'" onmouseout="this.bgColor=''">
								<td>${car.carType}&nbsp;${car.carNumber}</td>
								<td>${car.carHostName}</td>
								<td>${car.startStation}</td>
								<td>${car.endStation}</td>
								<td>${car.startDate}&nbsp;${car.startTime}</td>
								<td>${car.endDate}&nbsp;${car.endTime}</td>
								<td>${car.ticketValue}&nbsp;张</td>
								<td>￥&nbsp;${car.ticketPrice}&nbsp;元</td>
								<td class="ui right aligned center aligned">
									<a class="circular ui icon inverted button green " href="${pageContext.request.contextPath}/car/CarDetail/showCarDetail?carId=${car.carId}"><i class="icon eye"></i>&nbsp;&nbsp;详情&nbsp;</a>
									<a class="circular ui icon inverted button blue " href="${pageContext.request.contextPath}/car/CarDetail/showUpdateCar?carId=${car.carId}"><i class="icon edit"></i>&nbsp;&nbsp;修改&nbsp;</a>
									<a class="circular ui icon inverted button red " href="${pageContext.request.contextPath}/car/deleteCar/${car.carId}?position=countCar" onclick="return toComfirm();"><i class="icon trash alternate"></i>&nbsp;&nbsp;删除&nbsp;</a>
								</td>
							</tr>
						</c:forEach>
						</tbody>
						<tfoot class="full-width">
						<tr>
							<th colspan="9">
								<a class="ui right floated small primary labeled icon button" href="${pageContext.request.contextPath}/page/addCar">
									<i class="car icon"></i> Add Car
								</a>
							</th>
						</tr>
						</tfoot>
					</table>
				</div>
			</div><%
		}else { %>
			<div class="ui middle aligned center aligned mt-2 mr-3 ml-3">
				<div class="ui placeholder segment" >
					<table class="ui compact celled definition table " >
						<thead class="full-width">
							<tr style="height: 550px;">
								<th colspan="10" class="ui center aligned center aligned">
									<div class="field">
										<div class="ui icon header">
											<i class="dont icon"></i>
											No cars have been added（暂无车辆信息）
										</div>
									</div>
									<div class="field">
										<div class="field">
											<a class="ui primary button" href="${pageContext.request.contentType}/page/addCar">Add Car</a>
										</div>
									</div>
								</th>
							</tr>
						</thead>
					</table>
				</div>
			</div> <%
		}
	%>

</body>
</html>
