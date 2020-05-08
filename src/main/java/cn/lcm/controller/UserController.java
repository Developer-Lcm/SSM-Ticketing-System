package cn.lcm.controller;

import cn.lcm.domain.User;
import cn.lcm.service.IUserService;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;
import java.util.UUID;

/**
 * 表现层：用户操作
 */
@Controller
@SessionAttributes(value = {"uName"})
@Scope("prototype")
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IUserService userService;
    /**
     * 登录
     * @param request
     * @param response
     * @param model
     * @return
     * @throws IOException
     * @throws ServletException
     */
    @RequestMapping("/login")
    public String login(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException, ServletException {
        //设置统一编码
        request.setCharacterEncoding("utf-8");
        //获取表单数据
        String userName = request.getParameter("userName");
        String userPassword = request.getParameter("userPassword");
        String identity = request.getParameter("identity");
        if (userName.length() != 0 && userPassword.length() != 0) {//表单项不为空
            String loginResult = userService.login(userName, userPassword, identity);
            if (!loginResult.contains("Error") && loginResult != null) {
                if ("user".equals(identity)) {  //普通用户登录
                    if (request.getSession().getAttribute("loginUserName") == null) {
                        //将用户名称存到页面，并返回主页
                        model.addAttribute("uName", userService.findById(loginResult).get(0).getuName());
                        request.getSession().setAttribute("loginUserName", userName);
                        request.getSession().setAttribute("userLogo", userService.findUserImage(userName));
                        request.removeAttribute("registerSuccess"); //移出注册成功的提示对象
                        return "index";
                    } else if(request.getSession().getAttribute("loginUserName").equals(userName)) { //同一个用户可以登录（防止刷新页面导致登录多用户问题）
                        //将用户名称存到页面，并返回主页
                        model.addAttribute("uName", userService.findById(loginResult).get(0).getuName());
                        request.getSession().setAttribute("loginUserName", userName);
                        request.getSession().setAttribute("userLogo", userService.findUserImage(userName));
                        return "index";
                    }else {
                        model.addAttribute("success", "你已登录了一个账户，若要更换账号登录，请先退出其他账户！");
                        return "success";
                    }
                } else if ("admin".equals(identity)) {  //管理员登录
                    if(request.getSession().getAttribute("loginAdminName") == null){
                        request.getSession().setAttribute("loginAdminName", userName);
                        return "admin";//进入管理员页面
                    }else if(request.getSession().getAttribute("loginAdminName").equals(userName)){ //同一个管理员可以继续登录（防止刷新问题）
                        request.getSession().setAttribute("loginAdminName", userName);
                        return "admin";//进入管理员页面
                    } else {
                        model.addAttribute("success", "你已登录了一个账户，若要更换账号登录，请先退出其他账户！");
                        return "success";
                    }
                } else {
                    return "500";
                }
            } else if ("accountError".equals(loginResult)) {
                request.setAttribute("userLoginError", "用户名或密码错误！");
                //转发到登录页面
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else if ("userStatusError".equals(loginResult)) {
                request.setAttribute("userLoginError", "此账号已被封禁！");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else{
                return "500";
            }
        }else {  // if (userName.length() == 0 || userPassword.length() == 0)
            request.setAttribute("userLoginError", "用户名及账户不能为空！");
            //转发到登录页面
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        return "500";
    }

    /**
     * 登出：退出登录，删除登录用户域对象
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/logout/{identity}")
    public void logout(@PathVariable("identity") String identity ,HttpServletRequest request,HttpServletResponse response) throws IOException {
        if ("user".equals(identity)){  //用户登出
            request.getSession().removeAttribute("loginUserName"); //移出session域用户对象
            //移出（用户注销）的域干扰对象
            request.removeAttribute("cancelSuccess");
            request.removeAttribute("cancelFail");
        }
        if("admin".equals(identity)){
            request.getSession().removeAttribute("loginAdminName");//移出session域管理员对象
        }
        response.sendRedirect("/login.jsp"); //重定向回登录页面
    }

    /** 注册
     * @param request
     * @param response
     * @param model
     * @return
     * @throws IOException
     * @throws ServletException
     */
    @RequestMapping("/register")
    public String register(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException, ServletException {
        //设置统一编码
        request.setCharacterEncoding("utf-8");
        //获取表单数据
        String uName = request.getParameter("uName");
        String userName = request.getParameter("userName");
        String userPassword1 = request.getParameter("userPassword1");
        String userPassword2 = request.getParameter("userPassword2");
        //处理结果
        if (userName.length() != 0 && userPassword1.length() != 0 && userPassword2.length() != 0 && uName.length() != 0) {
            //表单项不为空
            String registerResult = userService.register(userName, userPassword1, userPassword2, uName);
            if (!registerResult.contains("Error")) { //注册成功！
                request.setAttribute("registerSuccess",true); //返回注册成功的提示
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            } else if ("passwordNotSameError".equals(registerResult)) {
                request.setAttribute("userRegisterError", "两次输入的密码不一致！");
                //转发到注册页面
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            } else if ("sameAccountError".equals(registerResult)) {
                request.setAttribute("userRegisterError", "此账号已存在，请勿重复注册！");
                //转发到注册页面
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        }else if (userName.length() == 0 || userPassword1.length() == 0 || userPassword2.length() == 0 || uName.length() == 0) {
            request.setAttribute("userRegisterError", "表单项不能留空！");
            //转发到注册页面
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
        return "500";
    }

    /**
     * 统计用户信息  OK
     * @param model
     * @return
     */
    @RequestMapping("/countUser")
    public String countUser(Model model,HttpServletRequest request){
        List<User> users = userService.countUser();
        if(users!=null){
            model.addAttribute("userCount",users);
            request.setAttribute("haveUsers","true");
        }else {
            request.setAttribute("haveUsers","false");
        }
        return "countUser";
    }

    /**
     * 根据账号获取用户资料详情  OK
     * @param userName
     * @param model
     * @return
     */
    @RequestMapping("/userDetail")
    public String userDetail(@RequestParam("userName") String userName,Model model,HttpServletRequest request){
        User user = userService.findById(userName).get(0);
        model.addAttribute("userDetail",user);
        request.getSession().setAttribute("userDetail_sex",user.getUserSex());
        request.getSession().setAttribute("userDetail_status",user.getUserStatus());
        request.getSession().setAttribute("userLogo",userService.findUserImage(userName)); //将用户头像存到session域中
        return "userImformation";
    }

    /**
     * 展示用户信息修改页面  OK
     * @param userName
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/showUpdateUser")
    public String showUpdateUserPage(@RequestParam("userName") String userName,HttpServletRequest request,Model model){
        User user = userService.findById(userName).get(0);
        model.addAttribute("showUpdateUser",user);
        request.getSession().setAttribute("showUpdateUserSex",user.getUserSex());
        request.getSession().setAttribute("showUpdateUserStatus",user.getUserStatus());
        return "updateUser";
    }

    /**
     * 修改用户:用户操作  OK
     * @param userName
     * @param model
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/updateUser")
    public String updateUser(@RequestParam("userName") String userName,Model model,HttpServletRequest request,User user,MultipartFile upload) throws Exception {
        user.setUserName(userName);
        if (!upload.isEmpty()){
            //如果已经选择了图片进行上传
            String userImage = imgUpload(upload,userName);//先完成头像的上传
            userService.updateUserImage(userName,userImage);//保存头像的修改
        }
        String updateUser = userService.updateUser(user);
        model.addAttribute("userDetail",userService.findById(updateUser).get(0));//更新域对象
        request.getSession().setAttribute("userDetail_sex",userService.findById(updateUser).get(0).getUserSex());
        request.getSession().setAttribute("userDetail_status",userService.findById(updateUser).get(0).getUserStatus());
        return "userImformation";
    }


    /**
     * 文件上传
     * @param upload
     * @return
     * @throws IOException
     */
    public String imgUpload(MultipartFile upload,String userName) throws Exception {
        //设置上传文件路径
        String path = "http://localhost:9090/uploads/";//跨服务器上传：上传到另一个服务器来存储

        //获取上传文件项名称,做文件名称随机处理避免上传相同文件名覆盖
        String uuid= UUID.randomUUID().toString().replace("-","");
        String fileName=uuid+"_"+userName + ".jpg";  //统一以 随机ID+用户名来命名图片文件
        // 创建客户端的对象
        Client client = Client.create();
        // 和图片服务器进行连接
        WebResource webResource = client.resource(path + fileName);
        // 上传文件
        webResource.put(upload.getBytes());
        return fileName;//返回文件的名称
    }

    /**
     * 删除用户 OK
     * @param userName
     * @param model
     * @return
     */
    @RequestMapping("/deleteUser/{position}")
    public String deleteUser(@PathVariable("position") String position,@RequestParam("userName") String userName, Model model,HttpServletRequest request){
        userService.deleteUser(userName);
        if ("countUser".equals(position)){
            //删除请求来自与用户统计页面
            List<User> users = userService.countUser();
            if(users!=null){
                model.addAttribute("userCount",users);
                request.setAttribute("haveUsers","true");
            }else {
                request.setAttribute("haveUsers","false");
            }
            return "countUser";
        }else if("searchUser".equals(position)){
            //删除请求来自于用户查询页面
            return "searchUser";
        }
        return "500";
    }

    /**
     * 用户封禁与解禁  OK
     * @param userName
     * @param model
     * @return
     */
    @RequestMapping("/banUser/{position}")
    public String banUser(@PathVariable("position") String position,@RequestParam("userName") String userName,Model model,HttpServletRequest request){
        if (userService.findById(userName).get(0).getUserStatus()==1){
            //原先是正常
            userService.banUser(0,userName);//封禁
        }else{
            userService.banUser(1,userName);//解封
        }
        if ("countUser".equals(position)){
            //封禁请求来自于用户统计页面
            List<User> users = userService.countUser();
            if(users!=null){
                model.addAttribute("userCount",users);//更新域对象
                request.setAttribute("haveUsers","true");
            }else {
                request.setAttribute("haveUsers","false");
            }
            return "countUser";
        }else if("searchUser".equals(position)){
            //封禁用户请求来自于用户查询页面
            return "searchUser";
        }
        return "500";
    }

    /**
     * 要用户账号注销
     * @param userName
     * @return
     */
    @RequestMapping("/cancellation/{userName}")
    public String Cancellation(@PathVariable("userName") String userName,HttpServletRequest request,@RequestParam("userPassword") String userPassword){
        if(userService.login(userName, userPassword, "user").equals(userName)){ //注销账户验证密码正确
            userService.deleteUser(userName); //删除用户
            request.setAttribute("cancelSuccess",true); //已注销！
        }else{
            request.setAttribute("cancelFail",true); //密码错误,注销失败
        }
        return "index";
    }
    /**
     * 用户查询
     * @param user
     * @param model
     * @return
     */
    @RequestMapping("/searchUser")
    public String searchUser(User user,Model model){
        List<User> users = userService.findByLikeCondition(user);
        model.addAttribute("searchUserResult",users);
        return "searchUser";
    }

}
