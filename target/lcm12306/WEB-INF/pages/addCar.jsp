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
			var flag =confirm("确认信息无误，并提交？");
			if(flag){
				return true;
			}else{
				return false;
			}
		};

		function checkForm3() {
			if(document.getElementById("carType").value=="N"){
				alert("请选择车辆类型");
				return false;
			}
			if(/^[0-9]{4}$/.test(document.getElementById("carNumber").value)==false){
				alert("车辆编号格式：4位数字");
				return false;
			}
			if(/^[\u4E00-\u9FA5]{2,9}['站']$/.test(document.getElementById("startStation").value)==false){
				alert("站点名称格式：以站字结尾的中文名称（3-9字）");
				return false;
			}
			if(/^[\u4E00-\u9FA5]{2,9}['站']$/.test(document.getElementById("endStation").value)==false){
				alert("站点名称格式：以站字结尾的中文名称（3-10字）");
				return false;
			}
			if(/^(?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]$/.test(document.getElementById("startTime").value)==false){
				alert("出发时间格式有误！（格式：00:00）");
				return false;
			}
			if(/^(?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]$/.test(document.getElementById("endTime").value)==false){
				alert("到达时间格式有误！（格式：00:00）");
				return false;
			}
			if(/^[\u4E00-\u9FA5]{2,9}$/.test(document.getElementById("carHostName").value)==false){
				alert("列车长名称格式：全中文名称（2-10字）");
				return false;
			}
			if(/^1\d{10}$/.test(document.getElementById("carHostPhone").value)==false){
				alert("手机号格式：由1开头的11数字组成");
				return false;
			}
			if(/^[1-9][0-9]{0,5}$/.test(document.getElementById("ticketCount").value)==false){
				alert("票数应是一个合法合理的整数(纯整数，首位不为0)");
				return false;
			}
			if (/^[1-9][0-9]{1,5}$/.test(document.getElementById("ticketPrice").value)==false && /^[1-9][0-9]{1,5}['.'][0-9]{2}/.test(document.getElementById("ticketPrice").value)==false){
				alert("票价应是一个合法的整数或者浮点数(保留两位小数)");
				return false;
			}
			//校验出到站时间
			if(checkDateTime(document.getElementById("startDate").value,document.getElementById("startTime").value,document.getElementById("endDate").value,document.getElementById("endTime").value)=="timeError"){
				alert("到站时间不得早于出站时间");
				return false;
			}
			if(checkDateTime(document.getElementById("startDate").value,document.getElementById("startTime").value,document.getElementById("endDate").value,document.getElementById("endTime").value)=="dateError"){
				alert("出站日期不得晚于到站日期");
				return false;
			}
			return toComfirm();
		}
		function checkDateTime(startDate,startTime,endDate,endTime) {
			var start1 = startDate.substr(0,4)+startDate.substr(5,2);
			var start2 = startDate.substr(8,2)+startTime.substr(0,2)+startTime.substr(3,2);
			var end1 = endDate.substr(0,4)+endDate.substr(5,2);
			var end2 = endDate.substr(8,2)+endTime.substr(0,2)+endTime.substr(3,2);
			if(startDate == endDate & parseInt(start2.substr(2,4))>parseInt(end2.substr(2,4))){
				return "timeError";
			}
			if(parseInt(start1+startDate.substr(8,2))>parseInt(end1+endDate.substr(8,2))){
				return "dateError";
			}
			return "true";
		}
	</script>
</head>
<body>
	<div class="ui middle aligned center aligned mt-1 mr-3 ml-3">
		<div class="ui placeholder segment">
			<form class="ui form" onsubmit="return checkForm3()" action="${pageContext.request.contextPath}/car/addCar" method="post">
			  <h4 class="ui dividing header">车辆信息【Car Imformation】</h4>
			  <div class="two fields">
		      	<div class="field">
		      		<label>车辆类型</label>
		        	<select class="ui fluid dropdown" name="carType" required="required" id="carType" autofocus>
							<option value="N">请选择车辆类型</option>
				        	<option value="G">高铁</option>
						    <option value="D">动车</option>
						    <option value="C">城轨</option>
						    <option value="K">火车快车</option>
						    <option value="Z">火车直达</option>
			      	</select>
		      	</div>
		      	<div class="field">
		        	<label>车辆编号</label>
		        	<input type="text" name="carNumber" placeholder="car number"required="required" id="carNumber"/>
		      	</div>
			  </div>
			  <div class="two fields">
		      	<div class="field">
		      		<label>起点站</label>
		        	<input type="text" name="startStation" placeholder="start station" required="required" id="startStation"/>
		      	</div>
		      	<div class="field">
		        	<label>终点站</label>
		        	<input type="text" name="endStation" placeholder="ending station" required="required" id="endStation"/>
		      	</div>
			  </div>
			  <div class="four fields">
			  	<div class="field">
		      		<label>出发日期时间</label>
		        	<input type="date" name="startDate" required="required" id="startDate" id="startDate"/>
		      	</div>
		      	<div class="field">
		      		<label>&nbsp;</label>
		        	<input type="text" name="startTime" placeholder="type：00:00" required="required" id="startTime"/>
		      	</div>
		      	<div class="field">
		      		<label>到站日期时间</label>
		        	<input type="date" name="endDate" required="required" id="endDate"/>
		      	</div>
		      	<div class="field">
		      		<label>&nbsp;</label>
		        	<input type="text" name="endTime" placeholder="type：00:00" required="required" id="endTime"/>
		      	</div>
			  </div>
			  <div class="field">
			      <label>列车长姓名</label>
			      <input type="text" name="carHostName" placeholder="the name of Train Conductor" required="required" id="carHostName"/>
			  </div>
			  <div class="field">
			      <label>列车长联系方式</label>
			      <input type="text" name="carHostPhone" placeholder="the phone number of Train Conductor" required="required" id="carHostPhone"/>
			  </div>
			  
			  <h4 class="ui dividing header">车票信息 【Ticket Imformation】</h4>  
			  <div class="two fields">
			  	<div class="field">
			    	<label>车票数量</label>
			      	<input type="text" name="ticketCount" placeholder="the amount of ticket" required="required" id="ticketCount"/>
			    </div>
			    <div class="field">
			     	<label>票价</label>
			      	<input type="text" name="ticketPrice" placeholder="the price of a ticket" required="required" id="ticketPrice"/>
			    </div>
			  </div>
			  <div class="field">
				  <input type="submit" value="立即提交" class="ui button green"/>
				  <input type="reset" value="表单重置" class="ui button blue aligned" />
			  </div>
			</form>
		</div>
	</div>
</body>	
</html>
