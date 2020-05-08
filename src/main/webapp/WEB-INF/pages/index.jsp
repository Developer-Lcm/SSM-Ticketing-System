<%@ page contentType="text/html;charset=UTF-8" errorPage="500.jsp" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Lcm购票网</title>
  <link rel="icon" type="image/x-icon" href="../../static/img/BlogLogo.jpg" />
    <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <!--Semantic UI-->
	<link rel="stylesheet" type="text/css" href="semantic/dist/semantic.min.css">
	<script
	  src="https://code.jquery.com/jquery-3.1.1.min.js"
	  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	  crossorigin="anonymous"></script>
	<script src="semantic/dist/semantic.min.js"></script>
  
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">

  <!-- Theme style   主题风格-->
  <link rel="stylesheet" href="../../plugins/dist/css/adminlte.min.css">
  <!-- overlayScrollbars  滚动条-->
  <link rel="stylesheet" href="../../plugins/overlayScrollbars/css/OverlayScrollbars.min.css">

  	
  	<!--bootstrap-->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	
	<script language="JavaScript">
		//弹窗确认操作
		function toComfirm(){
			var flag =confirm("确认要退出登录？");
			if(flag){
				return true;
			}else{
				return false;
			}
		};
		//弹窗提示是否注销，以及要求用户输入密码进行确认操作！
		function toCancel(userName) {
            var flag = confirm("此操作将清空你所有的账户信息，确认要永久注销账户？");
            if(flag){
                while (true){
                    var password = prompt("请输入账户密码以确认执行注销操作：");
                    if(password.length<8 || password.length>16){ //判断密码长度是否规范
                        alert("密码长度不符,应是8-16位字符!");
                        continue;
                    }else {
                        document.getElementById("cancelUser").href="${pageContext.request.contextPath}/user/cancellation/"+userName+"?userPassword="+password; //跳转到Controller进行删除操作
                        return true;
                        break;
                    }
                }
            }else {
                return false;
            }
        }
        //处理注销操作的结果和响应
        (function cancelResult() {
              if(<%=request.getAttribute("cancelSuccess")%>){
                  alert("账号注销成功！稍后将返回登录页面");
                  window.location.href="${pageContext.request.contextPath}/user/logout/user";
              }
              if(<%=request.getAttribute("cancelFail")%>){
                  alert("密码错误，账号注销失败！");
              }
        })();
	</script>
	
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">
      <!-- Navbar -->
      <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a>
          </li>
        </ul>

        <!-- Right navbar links -->
        <ul class="navbar-nav ml-auto">
          <li class="nav-item user-panel mr-3 font-weight-bold ">
            <div class="info">
              <a href="#" class="d-block">${uName}</a>
            </div>
          </li>
          <li class="nav-item">
              <img src="<%=session.getAttribute("userLogo")==null? "../../static/img/BlogLogo.jpg" : "http://localhost:9090/uploads/"+session.getAttribute("userLogo")%>" class="img-circle elevation-2" alt="User Image" height="45px" width="45px">
          </li>
        </ul>
      </nav>
      <!-- /.navbar -->

    <!--左侧边栏-->
      <!-- Main Sidebar Container -->
      <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <!--左侧网站logo-->
             <!-- Brand Logo -->
        <div class="brand-link">
          <img src="../../static/img/BlogLogo.jpg" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
               style="opacity: .8">
          <span class="brand-text font-weight-light">Lcm购票网</span>
        </div>

        <!-- Sidebar -->
        <div class="sidebar">

            <!--左侧菜单栏-->
          <!-- Sidebar Menu -->
          <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
              <!-- Add icons to the links using the .nav-icon class
                   with font-awesome or any other icon font library -->
              <!--Dashboard ：class: menu-open-->
      <!--车辆管理-->
              <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/page/searchCar" target="iframe_link">
                  <i class="nav-icon fas fa-car"></i>
                  <p>车票查询</p>
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/order/userOrder?userName=<%=session.getAttribute("loginUserName")%>" target="iframe_link">
                  <i class="nav-icon far fa-calendar-alt"></i>
                  <p>我的订单</p>
                </a>
              </li>
      <!--个人中心-->
              <li class="nav-header"><h5>个人中心——————</h5></li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/user/userDetail?userName=<%=session.getAttribute("loginUserName")%>" class="nav-link" target="iframe_link">
                  <i class="fas fa-user nav-icon"></i>
                  <p>我的资料</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/user/logout/user" class="nav-link" onclick="return toComfirm()">
                    <i class="nav-icon far fa-user"></i>
                    <p>退出登录</p>
                </a>
              </li>
              <li class="nav-item">
                 <a class="nav-link" onclick="return toCancel(<%=session.getAttribute("loginUserName")%>)" id="cancelUser">
                    <i class="nav-icon far fa-user"></i>
                    <p>注销账户</p>
                 </a>
              </li>
      <!--联系方式-->
              <li class="nav-header">&nbsp;&nbsp;&nbsp;<h5>问题反馈——————</h5></li>
              <li class="nav-item">
                <div class="nav-link">
                  <p>
                        <img src="../../static/img/lcm12306QR.jpg" width="150px" height="150px" class="img-rounded elevation-2"/>
                  </p>
                </div>
              </li>
                </ul>
          </nav>
          <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
      </aside>

    <!--中间部分内容-->

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper main-header">
        <div class="container-fluid">
            <!-- Small boxes (Stat box) -->
            <div class="row">
            <!--内联框架-->
                      <iframe src="http://localhost:8080/page/welcome" width="100%" height="600px" name="iframe_link">

                      </iframe>
                </div>
        </div>
      </div>
      <!-- /.content-wrapper -->


      <!--底部-->
      <footer class="main-footer">
        <strong>Copyright &copy; 1999-2020 <a href="http://adminlte.io">LcmBlog</a>.</strong>
          版权所有，侵权必究
        <div class="float-right d-none d-sm-inline-block">
          <div id="datetime">
                <script>
                    setInterval("document.getElementById('datetime').innerHTML=new Date().toLocaleString();", 1000);
                </script>
                </div>
        </div>
      </footer>
    </div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>

<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- overlayScrollbars 滚动条-->
<script src="../../plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="../../plugins/dist/js/adminlte.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="../../plugins/dist/js/pages/dashboard.js"></script>

</body>
</html>
