package cn.lcm.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * 实体类：订单详情信息
 */
public class OrderDetail implements Serializable {
    private String orderId;
    private String carId2;
    private String orderTime;
    private String uName;
    private String userPhone;
    private String travel;
    private String carType;
    private String travelTime;
    private float ticketPrice;
    private String seatNumber;
    private int orderStatus;
    private int deleteStatus;

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getCarId2() {
        return carId2;
    }

    public void setCarId2(String carId2) {
        this.carId2 = carId2;
    }

    public String getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(String  orderTime) {
        this.orderTime = orderTime;
    }

    public String getCarType() {
        return carType;
    }

    public void setCarType(String carType) {
        this.carType = carType;
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName;
    }

    public String getTravel() {
        return travel;
    }

    public void setTravel(String travel) {
        this.travel = travel;
    }

    public String getTravelTime() {
        return travelTime;
    }

    public void setTravelTime(String travelTime) {
        this.travelTime = travelTime;
    }

    public float getTicketPrice() {
        return ticketPrice;
    }

    public void setTicketPrice(float ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public int getDeleteStatus() {
        return deleteStatus;
    }

    public void setDeleteStatus(int deleteStatus) {
        this.deleteStatus = deleteStatus;
    }
}
