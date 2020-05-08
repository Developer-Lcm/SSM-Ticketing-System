package cn.lcm.service;

import cn.lcm.domain.OrderDetail;
import cn.lcm.domain.Orders;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.aspectj.weaver.ast.Or;

import java.util.List;

/**
 * 业务层接口：操作订单信息
 */
public interface IOrderService {
    /**
     * 新增：新增订单：提供用户账号、车辆Id即可
     * @param userName
     * @param carId
     */
    public boolean add(String userName,int carId);

    /**
     * 删除：根据订单编号删除订单
     * @param orderId
     */
    public void delete(String orderId);

    /**
     * 修改：取消订单
     * @param orderId
     */
    public void cancel(String orderId);

    /**
     * 查询：查询所有订单信息
     * @return
     */
    public List<Orders> findAll();

    /**
     * 查询：根据订单编号查询订单信息
     * @param orderId
     * @return
     */
    public List<Orders> findByOrderId(String orderId);

    /**
     * 根据用户名查询订单信息
     * @param userName
     * @return
     */
    public List<OrderDetail> findUserOrder(String userName);

    /**
     * 统计订单信息
     * @return
     */
    public List<OrderDetail> countOrder();

}
