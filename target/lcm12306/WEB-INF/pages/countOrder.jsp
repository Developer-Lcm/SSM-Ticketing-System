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
		if(request.getAttribute("haveOrders").equals("true")){
			request.removeAttribute("haveOrders");//移除域对象%>
			<div class="ui middle aligned center aligned mt-1 mr-3 ml-3">
				<div class="ui placeholder segment">
					<table class="ui compact celled definition table">
						<thead class="full-width">
						<tr>
							<th colspan="9"><font size="5">统计订单信息&nbsp;(共 ${countOrders.size()} 条记录)</font></th>
						</tr>
						<tr>
							<th>订单编号</th>
							<th>车辆编号</th>
							<th>下单时间</th>
							<th>所属用户</th>
							<th>联系方式</th>
							<th>金额(元)</th>
							<th>座位号</th>
							<th>状态(1正常|0已退)</th>
							<th class="ui right aligned center aligned"><span>执行操作&nbsp;&nbsp;</span></th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${countOrders}" var="countOrder">
							<tr onmouseover="this.bgColor='#DEDEDE'" onmouseout="this.bgColor=''">
								<td>${countOrder.orderId}</td>
								<td>${countOrder.carId2}</td>
								<td>${countOrder.orderTime}</td>
								<td>${countOrder.uName}</td>
								<td>${countOrder.userPhone}</td>
								<td>￥&nbsp;${countOrder.ticketPrice}&nbsp;元</td>
								<td>${countOrder.seatNumber}</td>
								<td>${countOrder.orderStatus}</td>
								<td class="ui right aligned center aligned">
									<a class="circular ui icon inverted button red " href="${pageContext.request.contextPath}/order/deleteOrder?orderId=${countOrder.orderId}" onclick="return toComfirm();"><i class="icon trash alternate"></i>&nbsp;&nbsp;删除&nbsp;</a>
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
										No orders have been added yet（暂无订单）
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
