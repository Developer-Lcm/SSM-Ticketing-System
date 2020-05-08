package cn.lcm.service.impl;

import cn.lcm.dao.IUserDao;
import cn.lcm.domain.Admin;
import cn.lcm.domain.User;
import cn.lcm.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 业务层：操作用户信息
 */
@Service("userService")
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserDao userDao;

    /**
     * 用户登录  OK
     * @param userName
     * @param userPassword
     * @param identity  身份：用户user、管理员admin
     * @return
     */
    @Override
    public String login(String userName, String userPassword, String identity) {
        if("user".equals(identity)){
            //登陆者为普通用户
            User loginUser = userDao.userLogin(userName, userPassword);
            if( loginUser != null){
                if(loginUser.getUserStatus()!=0){  //账号状态正常且未登录
                    return userName;//返回用户名，运行登录
                }else {
                    return "userStatusError";  //返回账号已封禁的提示
                }
            }else {
                return "accountError";//返回登录失败的提示（账号或密码错误）
            }
        }else if("admin".equals(identity)){
            //登录者为管理员
            Admin loginAdmin = userDao.adminLogin(userName,userPassword);
            if(loginAdmin != null){
                return userName;
            }else{
                return "accountError";//账号或密码错误
            }
        }
        return null;
    }

    /**
     * 用户注册
     * @param userName
     * @param userPassword1
     * @param userPassword2
     * @return
     */
    @Override
    public String register(String userName, String userPassword1, String userPassword2,String uName) {
        int result = userDao.findById(userName).size();
        int result2 = userDao.findAdminById(userName).size();//判断新用户名是否跟管理员账号一致
        if(result==0 && result2==0){
            //账号是新注册的
            if (userPassword1.equals(userPassword2)){
                //两次输入的密码都相同
                userDao.add(userName,userPassword1,uName);
                return userName;//返回账号
            }else {
                return "passwordNotSameError";//返回密码不同的结果
            }
        }else{
            //账号已存在
            return "sameAccountError";
        }
    }

    /**
     * 统计用户信息
     * @return
     */
    @Override
    public List<User> countUser() {
        List<User> users = userDao.findAll();
        if(users.size()>0){
            return users;
        }else {
            return null;
        }
    }

    /**
     * 根据用户账号获取用户信息
     * @param userName
     * @return
     */
    @Override
    public List<User> findById(String userName) {
        return userDao.findById(userName);
    }

    /**
     * 展示用户信息
     * @param userName
     * @return
     */
    @Override
    public User showUser(String userName) {
        return userDao.findById(userName).get(0);
    }

    /**
     * 修改用户信息
     * @param user
     * @return
     */
    @Override
    public String updateUser(User user) {
        User user1 = new User();
        user1.setUserName(user.getUserName());
        user1.setUserStatus(userDao.findById(user.getUserName()).get(0).getUserStatus()); //原先的账号状态
        //修改姓名
        user1.setuName(user.getuName().length()>0?user.getuName():null);

        //修改电话号码
        user1.setUserPhone(user.getUserPhone().length()>0?user.getUserPhone():null);

        //修改身份证号码
        user1.setIdNumber(user.getIdNumber().length()>0?user.getIdNumber():null);

        //修改了地址
        user1.setUserAddress(user.getUserAddress().length()>0?user.getUserAddress():null);

        user1.setUserSex(user.getUserSex());//性别修改
        user1.setLateSetTime(new SimpleDateFormat("YYYY-MM-dd HH:mm:ss").format(new Date()));//修改时间
        userDao.updateByCondition(user1);
        return user.getUserName();//返回用户名
    }

    /**
     * 修改用户头像的图片路径（名称）
     * @param userName
     * @param userImage
     */
    @Override
    public void updateUserImage(String userName, String userImage) {
        userDao.imgUpload(userName,userImage);
    }

    /**
     * 删除指定用户
     * @param userName
     */
    @Override
    public void deleteUser(String userName) {
        userDao.delete(userName);
    }

    /**
     * 封禁用户、解禁用户
     * @param userStatus
     * @param userName
     * @return
     */
    @Override
    public String banUser(int userStatus,String userName) {
        userDao.updateStatus(userStatus,userName);
        return null;
    }

    /**
     * 多条件模糊查询
     * @param user
     * @return
     */
    @Override
    public List<User> findByLikeCondition(User user) {
        User search = new User();
        //已输入用户姓名
        search.setuName(user.getuName().length()>0?"%"+user.getuName()+"%":null);

        //已输入用户账号
        search.setUserName(user.getUserName().length()>0?"%"+user.getUserName()+"%":null);

        //已输入注册日期
        search.setRegisterTime(user.getRegisterTime().length()>0?"%"+user.getRegisterTime()+"%":null);

        //已输入用户电话
        search.setUserPhone(user.getUserPhone().length()>0?"%"+user.getUserPhone()+"%":null);

        //已输入用户地址
        search.setUserAddress(user.getUserAddress().length()>0?"%"+user.getUserAddress()+"%":null);

        search.setUserStatus(user.getUserStatus());
        return userDao.findByLikeCondition(search);
    }

    /**
     * 根据用户名查询头像
     * @param userName
     * @return
     */
    @Override
    public String findUserImage(String userName) {
        String userImage = userDao.findUserImage(userName);
        if (!"null".equals(userImage)){
            return userImage;
        }
        return null;
    }

}
