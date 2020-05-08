package cn.lcm.service;

import cn.lcm.domain.User;
import java.util.List;

/**
 * 业务层接口：用户操作
 */
public interface IUserService {

    /**
     * 用户登录接口
     * @param userName
     * @param userPassword
     * @param identity  身份：用户user、管理员admin
     * @return 登录成功返回用户账号，否则返回失败原因
     */
    public String login(String userName,String userPassword,String identity);

    /**
     * 用户注册
     * @param userName
     * @param userPassword1
     * @param userPassword2
     * @return 注册成功返回账号，否则返回失败原因
     */
    public String register(String userName,String userPassword1,String userPassword2,String uName);

    /**
     * 根据用户名删除指定用户
     * @param userName
     */
    public void deleteUser(String userName);

    /**
     * 修改用户
     * @param user
     * @return
     */
    public String updateUser(User user);

    /**
     * 根据用户名修改用户头像
     * @param userName
     * @param userImage
     */
    public void updateUserImage(String userName,String userImage);

    /**
     * 修改账户状态：封禁或者解除封禁
     * @param userStatus
     * @param userName
     * @return
     */

    public String banUser(int userStatus,String userName);

    /**
     * 统计查询所有的用户信息
     * @return 返回用户信息集合
     */
    public List<User> countUser();

    /**
     * 根据用户名查询用户，理论上只有1个或者0个结果
     * @param userName
     * @return
     */
    public List<User> findById(String userName);

    /**
     * 根据用户名查看用户资料详情
     * @param userName
     * @return
     */
    public User showUser(String userName);

    /**
     * 查询：多字段模糊查询
     * @param user
     * @return
     */
    public List<User> findByLikeCondition(User user);

    /**
     * 查询：根据用户名查询用户头像信息
     * @param userName
     * @return
     */
    public String findUserImage(String userName);

}
