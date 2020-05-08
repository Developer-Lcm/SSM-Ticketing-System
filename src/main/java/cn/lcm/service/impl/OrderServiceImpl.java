package cn.lcm.service.impl;

import cn.lcm.dao.ICarDao;
import cn.lcm.dao.IOrderDao;
import cn.lcm.dao.IUserDao;
import cn.lcm.domain.Car;
import cn.lcm.domain.OrderDetail;
import cn.lcm.domain.Orders;
import cn.lcm.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * 业务层：操作订单
 */
@Service("orderService")
public class OrderServiceImpl implements IOrderService {

    @Autowired
    private IOrderDao orderDao;

    @Autowired
    private IUserDao userDao;

    @Autowired
    private ICarDao carDao;

    /**
     * 购票、下单
     * @param userName
     * @param carId
     */
    @Override
    public boolean add(String userName, int carId) {
        if(orderDao.findSameOrder(userName,carId)==null){ //没订购过该程车票
            orderDao.add(userName,carId); //完成订购
            return true;
        }
        return false; //如果已经有相同的订单记录了，就不允许购买这张票！
    }

    /**
     * 根据订单号删除订单  （不是真的删除，只改状态值）
     * @param orderId
     */
    @Override
    public void delete(String orderId) {
        Orders order = orderDao.findByOrderId(orderId).get(0);
        if(order.getOrderStatus()==0){ //如果是用户已经退票的订单
            orderDao.cancel(2,orderId);//表示“删除”用户已退票的订单
        }else {
            orderDao.delete(orderId); //否则直接“删除”
        }
    }

    /**
     * 根据订单号取消对应订单  OK
     * @param orderId
     */
    @Override
    public void cancel(String orderId) {
        orderDao.cancel(0,orderId);
    }

    /**
     * 查询所有订单信息
     * @return
     */
    @Override
    public List<Orders> findAll() {
        return orderDao.findAll();
    }

    /**
     * 根据订单编号查询订单信息
     * @param orderId
     * @return
     */
    @Override
    public List<Orders> findByOrderId(String orderId) {
        return orderDao.findByOrderId(orderId);
    }

    /**
     * 查询指定用户账号名下的订单信息
     * @param userName
     * @return
     */
    @Override
    public List<OrderDetail> findUserOrder(String userName) {
        List<Orders> orders = orderDao.findByUserName(userName);
        if(orders.size()>0){
            //查询到有订单
            ArrayList<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
            String uName = userDao.findById(userName).get(0).getuName();
            for (Orders order: orders) {
                if(order.getOrderStatus()==1 & order.getDeleteStatus()==1){ //只返回用户未退票,未被删除的订单
                    //根据订单中的carId获取车辆信息
                    Car car = carDao.findById(order.getCarId()).get(0);//车辆ID不会重复
                    OrderDetail  orderDetail = new OrderDetail();
                    //封装成OrderDetail对象
                    orderDetail.setuName(uName);
                    orderDetail.setOrderId(order.getOrderId());
                    orderDetail.setCarId2(car.getCarType()+" "+car.getCarNumber());
                    orderDetail.setOrderTime(order.getOrderTime());
                    orderDetail.setOrderStatus(order.getOrderStatus());
                    orderDetail.setDeleteStatus(order.getDeleteStatus());
                    orderDetail.setSeatNumber(order.getSeatNumber());
                    orderDetail.setTravel(car.getStartStation()+"————"+car.getEndStation());
                    orderDetail.setTravelTime(car.getStartDate()+" "+car.getStartTime()+"————"+car.getEndDate()+" "+car.getEndTime());
                    orderDetail.setTicketPrice(car.getTicketPrice());
                    //存进集合
                    orderDetails.add(orderDetail);
                }else {
                    continue;
                }
            }
            return orderDetails;
        }else {
            return null;
        }
    }

    /**
     * 统计所有订单信息  OK
     * @return
     */
    @Override
    public List<OrderDetail> countOrder() {
        List<Orders> orders = orderDao.findAll();//所有的订单
        if(orders.size()>0){
            //查询到有订单
            ArrayList<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
            for (Orders order: orders) {
                OrderDetail  orderDetail = new OrderDetail();
                String uName = userDao.findById(order.getUserName()).get(0).getuName();
                String userPhone = userDao.findById(order.getUserName()).get(0).getUserPhone();
                //根据订单中的carId获取车辆信息
                Car car = carDao.findById(order.getCarId()).get(0);//车辆ID不会重复
                //封装成OrderDetail对象
                orderDetail.setuName(uName);
                orderDetail.setUserPhone(userPhone);
                orderDetail.setOrderId(order.getOrderId());
                orderDetail.setCarId2(car.getCarType()+" "+car.getCarNumber());
                orderDetail.setOrderTime(order.getOrderTime());
                orderDetail.setOrderStatus(order.getOrderStatus());
                orderDetail.setDeleteStatus(order.getDeleteStatus());
                orderDetail.setSeatNumber(order.getSeatNumber());
                orderDetail.setTravel(car.getStartStation()+"————"+car.getEndStation());
                orderDetail.setTravelTime(car.getStartDate()+" "+car.getStartTime()+"————"+car.getEndDate()+" "+car.getEndTime());
                orderDetail.setTicketPrice(car.getTicketPrice());
                //存进集合
                orderDetails.add(orderDetail);
            }
            return orderDetails;
        }else {
            return null;
        }
    }
}
