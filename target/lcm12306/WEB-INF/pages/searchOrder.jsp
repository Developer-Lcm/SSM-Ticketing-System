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
			<form class="ui form placeholder segment" action="${pageContext.request.contentType}/order/searchOrder" method="post">
				<div class="four fields">
			      	<div class="field">
			      		<label>根据订单编号查询</label>
			        	<input type="text" name="orderId" placeholder="order number">
			      	</div>
			      	<div class="field">
			        	<label>根据用户姓名查询</label>
			        	<input type="text" name="uName" placeholder="user name ">
			      	</div>
			      	<div class="field">
			        	<label>根据下单日期查询</label>
			        	<input type="text" name="orderTime" placeholder="buyed datetime" onfocus="(this.type='date') " onblur="(this.type='text')">
			      	</div>
			      	<div class="field">
			        	<label>根据车辆类型查询</label>
			        	<select class="ui fluid dropdown" name="carType">
							<option value="N">请选择车辆类型</option>
					        <option value="G">高铁</option>
							<option value="D">动车</option>
							<option value="C">城轨</option>
							<option value="K">火车快车</option>
							<option value="Z">火车直达</option>
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
					  		<th colspan="9"><font size="5">查询结果&nbsp;(共 ${searchOrderResult.size()} 条记录)</font></th>
					  	</tr>
					    <tr>
					      <th>订单编号</th>
					      <th>车辆编号</th>
					      <th>下单时间</th>
					      <th>所属用户</th>
					      <th>联系方式</th>
					      <th>金额(元)</th>
					      <th>座位号</th>
					      <th>状态</th>
					      <th class="ui right aligned center aligned"><span>执行操作&nbsp;&nbsp;</span></th>
					    </tr>
					  </thead>
					  <tbody>
						  <c:forEach items="${searchOrderResult}" var="orderdetail">
							  <tr>
								  <td>${orderdetail.orderId}</td>
								  <td>${orderdetail.carId2}</td>
								  <td>${orderdetail.orderTime}</td>
								  <td>${orderdetail.uName}</td>
								  <td>${orderdetail.userPhone}</td>
								  <td>￥ ${orderdetail.ticketPrice}</td>
								  <td>${orderdetail.seatNumber}</td>
								  <td>${orderdetail.orderStatus}</td>
								  <td class="ui right aligned center aligned">
									  <a class="circular ui icon inverted button red " href="${pageContext.request.contextPath}/order/deleteOrder/searchOrder?orderId=${orderdetail.orderId}" onclick="return toComfirm();"><i class="icon trash alternate"></i>&nbsp;&nbsp;删除&nbsp;</a>
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
