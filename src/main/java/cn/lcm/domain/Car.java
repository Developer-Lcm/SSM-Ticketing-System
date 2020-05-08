package cn.lcm.domain;

import java.io.Serializable;

/**
 * 实体类：车辆信息
 */
public class Car implements Serializable {
    private int carId;
    private String carType;
    private String carNumber;
    private String startStation;
    private String endStation;
    private String startDate;
    private String startTime;
    private String endDate;
    private String endTime;
    private String carHostName;
    private String carHostPhone;
    private String lastSetTime;
    private int ticketCount;
    private int ticketValue;
    private float ticketPrice;

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public String getCarType() {
        return carType;
    }

    public void setCarType(String carType) {
        this.carType = carType;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getStartStation() {
        return startStation;
    }

    public void setStartStation(String startStation) {
        this.startStation = startStation;
    }

    public String getEndStation() {
        return endStation;
    }

    public void setEndStation(String endStation) {
        this.endStation = endStation;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getCarHostName() {
        return carHostName;
    }

    public void setCarHostName(String carHostName) {
        this.carHostName = carHostName;
    }

    public String getCarHostPhone() {
        return carHostPhone;
    }

    public void setCarHostPhone(String carHostPhone) {
        this.carHostPhone = carHostPhone;
    }

    public int getTicketCount() {
        return ticketCount;
    }

    public void setTicketCount(int ticketCount) {
        this.ticketCount = ticketCount;
    }

    public int getTicketValue() {
        return ticketValue;
    }

    public void setTicketValue(int ticketValue) {
        this.ticketValue = ticketValue;
    }

    public float getTicketPrice() {
        return ticketPrice;
    }

    public void setTicketPrice(float ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    public String getLastSetTime() {
        return lastSetTime;
    }

    public void setLastSetTime(String lastSetTime) {
        this.lastSetTime = lastSetTime;
    }
}
