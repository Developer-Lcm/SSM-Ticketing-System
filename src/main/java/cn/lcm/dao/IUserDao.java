package cn.lcm.dao;

import cn.lcm.domain.Admin;
import cn.lcm.domain.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 持久层接口：在数据库层面操作用户信息
 */
@Repository("userDao")
public interface IUserDao {
    /**
     * 新增：用户注册
     * @param userName
     * @param userPassword
     */
    @Insert("insert into user(userName,userPassword,uName) values(#{userName},#{userPassword},#{uName})")
    public void add(@Param("userName") String userName,@Param("userPassword") String userPassword,@Param("uName") String uName);

    /**
     * 删除：删除指定账户的用户信息
     * @param userName
     */
    @Delete("delete from user where userName =#{userName}")
    public void delete(String userName);

    /**
     * 修改：修改用户账户状态：（1：正常、0：封禁）
     * @param userStatus
     * @param userName
     */
    @Update("update user set userStatus=#{userStatus} where userName=#{userName}")
    public void updateStatus(@Param("userStatus") int userStatus,@Param("userName") String userName);

    /**
     * 修改用户的登录状态
     * @param userName
     * @param loginStatus
     */
    @Update("update user set loginStatus = #{loginStatus} where userName=#{userName}")
    public void updateLoginStatus(@Param("userName") String userName,@Param("loginStatus") int loginStatus);

    /**
     * 修改管理员的登录状态
     * @param adminName
     * @param loginStatus2
     */
    @Update("update admin set loginStatus2 = #{loginStatus2} where adminName=#{adminName}")
    public void updateAdminLoginStatus(@Param("adminName") String adminName,@Param("loginStatus2") int loginStatus2);

    /**
     * 修改；按需修改用户信息
     * @param user
     */
    @Update(value = {" <script>" +
            " UPDATE user SET lateSetTime=#{lateSetTime}" +
            " <if test=\"uName != null\"> ,uName=#{uName}</if> " +
            " <if test=\"userPassword != null\"> ,userPassword=#{userPassword}</if> " +
            " <if test=\"userSex != null\"> ,userSex=#{userSex}</if> " +
            " <if test=\"userPhone != null\"> ,userPhone =#{userPhone}</if> " +
            " <if test=\"idNumber != null\"> ,idNumber=#{idNumber}</if> " +
            " <if test=\"userImage != null\"> ,userImage=#{userImage}</if> " +
            " <if test=\"userAddress != null\"> ,userAddress=#{userAddress}</if> " +
            " <if test=\"userStatus != null\"> ,userStatus=#{userStatus}</if> " +
            " where userName=#{userName}" +
            " </script>"})
    public void updateByCondition(User user);

    /**
     * 修改：用户图片上传：名称的更改
     * @param userName
     * @param userImage
     */
    @Update("update user set userImage=#{userImage} where userName=#{userName}")
    public void imgUpload(@Param("userName") String userName,@Param("userImage") String userImage);

    /**
     * 查询：查询所有用户信息
     * @return
     */
    @Select("select * from user")
    public List<User> findAll();

    /**
     * 查询用户登录状态：1（已登录） 0（未登录）
     * @param userName
     * @return
     */
    @Select("select loginStatus from user where userName=#{userName}")
    public int loginStatus(String userName);

    @Select("select loginStatus2 from admin where adminName=#{adminName}")
    public int loginStatusAdmin(String adminName);

    /**
     * 查询：根据用户名查询用户
     * @param userName
     * @return
     */
    @Select("select * from user where userName=#{userName}")
    public List<User> findById(String userName);

    /**
     * 查询：根据账号查询管理员
     * @param adminName
     * @return
     */
    @Select("select * from admin where adminName=#{adminName}")
    public List<Admin> findAdminById(String adminName);

    /**
     * 查询：根据用户名查询用户头像信息（图片名称）
     * @param userName
     * @return
     */
    @Select("select userImage from user where userName = #{userName}")
    public String findUserImage(String userName);


    /**
     * 查询：按需多条件查询
     * @param user
     * @return
     */
    @Select(value = {" <script>" +
            " select * from user where 1=1 "+
            " <if test=\"uName != null\"> AND uName=#{uName}</if> " +
            " <if test=\"userName != null\"> AND userName=#{userName}</if> " +
            " <if test=\"userPassword != null\"> AND userPassword=#{userPassword}</if> " +
            " <if test=\"userSex == 1 || userSex == 0\"> AND userSex=#{userSex}</if> " +
            " <if test=\"userPhone != null\"> AND userPhone =#{userPhone}</if> " +
            " <if test=\"idNumber != null\">  AND idNumber=#{idNumber}</if> " +
            " <if test=\"userImage != null\"> AND userImage=#{userImage}</if> " +
            " <if test=\"registerTime != null\"> AND registerTime=#{registerTime}</if> " +
            " <if test=\"lateSetTime != null\"> AND lateSetTime=#{lateSetTime}</if> " +
            " <if test=\"userAddress != null\"> AND userAddress=#{userAddress}</if> " +
            " <if test=\"userStatus == 1 || userStatus == 0\">  AND userStatus=#{userStatus}</if> " +
            " </script>"})
    public List<User> findByCondition(User user);

    /**
     * 查询：多字段模糊查询
     * @param user
     * @return
     */
    @Select(value = {" <script>" +
            " select * from user where 1=1 "+
            " <if test=\"uName != null\"> AND uName LIKE #{uName}</if> " +
            " <if test=\"userName != null\"> AND userName LIKE #{userName}</if> " +
            " <if test=\"registerTime != null\"> AND registerTime LIKE #{registerTime}</if> " +
            " <if test=\"userPhone != null\"> AND userPhone LIKE #{userPhone}</if> " +
            " <if test=\"userAddress != null\"> AND userAddress LIKE #{userAddress}</if> " +
            " <if test=\"userStatus != 2\"> AND userStatus = #{userStatus}</if> " +
            " </script>"})
    public List<User> findByLikeCondition(User user);


    /**
     * 统计总用户数
     * @return
     */
    @Select("select count(*) from user")
    public int count();

    /**
     * 用户登录
     * @param userName
     * @param userPassword
     * @return
     */
    @Select("select * from user where userName=#{userName} and userPassword=#{userPassword}")
    public User userLogin(@Param("userName") String userName,@Param("userPassword") String userPassword);

//    管理员部分
//    管理员登录
    @Select("select * from admin where adminName=#{adminName} and adminPassword=#{adminPassword}")
    public Admin adminLogin(@Param("adminName") String adminName, @Param("adminPassword") String adminPassword);

}
