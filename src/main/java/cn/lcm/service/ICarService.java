package cn.lcm.service;

import cn.lcm.domain.Car;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 业务层接口：操作车辆信息
 */
public interface ICarService {
    /**
     * 新增：新增车辆
     * @param car
     */
    public String addCar(Car car);

    /**
     * 删除：删除指定ID的车辆
     * @param carId
     */
    public void deleteCar(int carId);

    /**
     * 修改；按需修改车辆信息
     * @param car
     */
    public void updateCar(Car car);

    /**
     * 查询：查询所有车辆信息
     * @return
     */
    public List<Car> countCar();

    /**
     * 查询：根据id查询车辆
     * @param carId
     * @return
     */
    public List<Car> findById(int carId);

    /**
     * 查询：多字段模糊查询
     * @param car
     * @return
     */
    public List<Car> findByLikeCondition(Car car,String identity);

    /**
     * 统计车辆信息总数
     * @return
     */
    public int count();
}
