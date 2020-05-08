package cn.lcm.dao;

import cn.lcm.domain.Car;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 持久层接口：在数据库层面操作车辆信息表
 */
@Repository("carDao")
public interface ICarDao {
    /**
     * 新增：新增车辆
     * @param car
     */
    @Insert("insert into car(carType, carNumber, startStation, endStation, startDate, startTime, endDate, endTime, carHostName, carHostPhone, ticketCount, ticketValue,ticketPrice) VALUES (#{carType}, #{carNumber}, #{startStation}, #{endStation}, #{startDate}, #{startTime}, #{endDate}, #{endTime}, #{carHostName}, #{carHostPhone}, #{ticketCount}, #{ticketValue},#{ticketPrice})")
    public void add(Car car);

    /**
     * 删除：删除指定ID的车辆
     * @param carId
     */
    @Delete("delete from car where carId = #{carId}")
    public void delete(int carId);


    /**
     * 修改；按需修改车辆信息
     * @param car
     */
    @Update(value = {" <script>" +
            " UPDATE car SET lastSetTime=#{lastSetTime}" +
            " <if test=\"startDate != null\"> ,startDate=#{startDate}</if> " +
            " <if test=\"startTime != null\"> ,startTime=#{startTime}</if> " +
            " <if test=\"endDate != null\"> ,endDate=#{endDate}</if> " +
            " <if test=\"endTime != null\"> ,endTime=#{endTime}</if> " +
            " <if test=\"carHostName != null\"> ,carHostName=#{carHostName}</if> " +
            " <if test=\"carHostPhone != null\"> ,carHostPhone=#{carHostPhone}</if> " +
            " where carId=#{carId}" +
            " </script>"})
    public void updateByCondition(Car car);

    /**
     * 查询：查询所有车辆信息
     * @return
     */
    @Select("select * from car order by carId")
    public List<Car> findAll();

    /**
     * 查询：根据id查询车辆
     * @param carId
     * @return
     */
    @Select("select * from car where carId=#{carId}")
    public List<Car> findById(int carId);

    /**
     * 查询：多条件查询(校验添加车辆是否重复)
     * @param car
     * @return
     */
    @Select(" select * from car where carType=#{carType} " +
            " AND carNumber = #{carNumber} " +
            " AND startStation = #{startStation} " +
            " AND endStation = #{endStation} " +
            " AND startDate = #{startDate} " +
            " AND startTime = #{startTime} " +
            " AND endDate = #{endDate} " +
            " AND endTime = #{endTime} ")
    public List<Car> findByCondition(Car car);

    /**
     * 查询：多字段模糊查询
     * @param car
     * @return
     */
    @Select(value = {" <script>" +
            " select * from car where 1=1 "+
            " <if test=\"carType != null\"> AND carType LIKE #{carType}</if> " +
            " <if test=\"startStation != null\"> AND startStation LIKE #{startStation}</if> " +
            " <if test=\"endStation != null\"> AND endStation  LIKE #{endStation}</if> " +
            " <if test=\"startDate != null\"> AND startDate LIKE #{startDate}</if> " +
            " <if test=\"carHostName != null\"> AND carHostName LIKE #{carHostName}</if> " +
            " </script>"})
    public List<Car> findByLikeCondition(Car car);

    /**
     * 统计车辆信息总数
     * @return
     */
    @Select("select count(*) from car")
    public int count();

}
