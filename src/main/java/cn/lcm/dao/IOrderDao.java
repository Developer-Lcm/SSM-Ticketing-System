package cn.lcm.dao;

import cn.lcm.domain.Orders;
import org.apache.ibatis.annotations.*;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 持久层接口：用于在数据库层面操作订单信息
 */
@Repository("orderDao")
public interface IOrderDao {
    /**
     * 新增：新增订单：提供用户账号、车辆Id即可
     * @param userName
     * @param carId
     */
    @Insert("insert into orders(userName,carId) values(#{userName},#{carId})")
    public void add(@Param("userName") String userName, @Param("carId") int carId);

    /**
     * 删除：根据订单编号删除订单(不是真的删除)
     * @param orderId
     */
    @Update("update orders set deleteStatus=0 where orderId= #{orderId}")
    public void delete(@Param("orderId") String orderId);

    /**
     * 修改：取消订单
     * @param orderId
     */
    @Update("update orders set orderStatus=#{orderStatus} where orderId=#{orderId}")
    public void cancel(@Param("orderStatus") int orderStatus,@Param("orderId") String orderId);

    /**
     * 查询：查询所有订单信息(不统计已删除的)
     * @return
     */
    @Select("select * from orders where deleteStatus = 1 and orderStatus != 2")
    public List<Orders> findAll();

    /**
     * 查询：根据订单编号查询订单信息
     * @param orderId
     * @return
     */
    @Select("select * from orders where orderId=#{orderId}")
    public List<Orders> findByOrderId(@Param("orderId") String orderId);

    /**
     * 根据用户名获取(只获取正常的，已退票的，已删除的就不返回了)
     * @param userName
     * @return
     */
    @Select("select * from orders where userName=#{userName} and orderStatus=1 and deleteStatus=1 ")
    public  List<Orders> findByUserName(@Param("userName") String userName);

    /**
     * 查询：根据用户名、车辆ID来查询用户订单，防止用户多次购买相同的车票！
     * @param userName
     * @param carId
     * @return
     */
    @Select("select * from orders where carId=#{carId} and userName=#{userName} and orderStatus=1 and deleteStatus=1")
    public Orders findSameOrder(@Param("userName") String userName,@Param("carId") int carId);

}
