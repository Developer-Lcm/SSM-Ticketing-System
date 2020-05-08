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
			var flag =confirm("确认要取消订单？");
			if(flag){
				return true;
			}else{
				return false;
			}
		}
	</script>
<body>
	<%  //判断用户是否具有订单，返回相应的页面
		if(request.getAttribute("userHasOrder").equals("true")){
			request.removeAttribute("userHasOrder"); %>
			<div class="ui middle aligned center aligned mt-1 mr-3 ml-3">
				<div class="ui placeholder segment">
					<table class="ui compact celled definition table">
						<thead class="full-width">
						<tr>
							<th colspan="10"><font size="5">我的订单&nbsp;(共 ${userOrders.size()} 条记录)</font></th>
						</tr>
						<tr>
							<th>订单编号</th>
							<th>车辆编号</th>
							<th>下单时间</th>
							<th>姓名</th>
							<th>行程</th>
							<th>行车时间</th>
							<th>金额(元)</th>
							<th>座位号</th>
							<th>状态</th>
							<th class="ui right aligned center aligned"><span>执行操作&nbsp;&nbsp;</span></th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${userOrders}" var="userOrder">
							<tr onmouseover="this.bgColor='#DEDEDE'" onmouseout="this.bgColor=''">
								<td>${userOrder.orderId}</td>
								<td>${userOrder.carId2}</td>
								<td>${userOrder.orderTime}</td>
								<td>${userOrder.uName}</td>
								<td>${userOrder.travel}</td>
								<th>${userOrder.travelTime}</th>
								<td>￥ ${userOrder.ticketPrice}</td>
								<td>${userOrder.seatNumber}</td>
								<td>${userOrder.orderStatus}</td>
								<td class="ui right aligned center aligned">
									<a class="circular ui icon inverted button red " href="${pageContext.request.contextPath}/order/cancelOrder?orderId=${userOrder.orderId}&userName=<%=session.getAttribute("loginUserName")%>" onclick="return toComfirm()"><i class=" x icon"></i>&nbsp;&nbsp;退票&nbsp;</a>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div> <%
		}else{ %>
			<div class="ui middle aligned center aligned mt-1 mr-3 ml-3">
				<div class="ui placeholder segment">
					<table class="ui compact celled definition table">
						<thead class="full-width">
						<tr style="height: 550px;">
							<th colspan="10" class="ui center aligned center aligned">
								<div class="field">
									<div class="ui icon header">
										<i class="dont icon"></i>
										No orders have been added yet
									</div>
								</div>
								<div class="field">
									<a class="ui primary button" href="${pageContext.request.contentType}/page/searchCar">Add Order</a>
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
