package cn.lcm.service.impl;

import cn.lcm.dao.ICarDao;
import cn.lcm.domain.Car;
import cn.lcm.service.ICarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 业务层：操作车辆信息
 */
@Service("carService")
public class CarServiceImpl implements ICarService {

    @Autowired
    private ICarDao carDao;
    /**
     * 新增车辆信息
     * @param car
     */

    @Override
    public String addCar(Car car) {
        if(carDao.findByCondition(car).size()==0){  //无重复车辆
            carDao.add(car);
            return "success";
        }else {
            return "sameCarError";
        }
    }

    /**
     * 根据车辆编号删除对应车辆信息
     * @param carId
     */
    @Override
    public void deleteCar(int carId) {
        carDao.delete(carId);
    }

    /**
     * 按需修改车辆信息
     * @param car
     * @return
     */
    @Override
    public void updateCar(Car car) {
        Car carUpdate = new Car();
        //修改了列车长姓名
        carUpdate.setCarHostName(car.getCarHostName().length()>0?car.getCarHostName():null);

        //修改了列车长电话
        carUpdate.setCarHostPhone(car.getCarHostPhone().length()>0?car.getCarHostPhone():null);

        //修改了出发日期
        carUpdate.setStartDate(car.getStartDate().length()>0?car.getStartDate():null);

        //修改了出发时间
        carUpdate.setStartTime(car.getStartTime().length()>0?car.getStartTime():null);

        //修改了到达日期
        carUpdate.setEndDate(car.getEndDate().length()>0?car.getEndDate():null);

        //修改了到达时间
        carUpdate.setEndTime(car.getEndTime().length()>0?car.getEndTime():null);

        carUpdate.setCarId(car.getCarId());
        carUpdate.setLastSetTime(new SimpleDateFormat("YYYY-MM-dd HH:mm:ss").format(new Date()));
        carDao.updateByCondition(carUpdate);
    }

    /**
     * 查询所有车辆信息
     * @return
     */
    @Override
    public List<Car> countCar() {
        List<Car> cars = carDao.findAll();
        if(cars.size()>0){
            return cars;
        }else {
            return null;
        }
    }

    /**
     * 根据车辆编号查询车辆信息
     * @param carId
     * @return
     */
    @Override
    public List<Car> findById(int carId) {
        return carDao.findById(carId);
    }


    /**
     * 多条件模糊查询车辆信息
     * @param car
     * @return
     */
    @Override
    public List<Car> findByLikeCondition(Car car,String identity) {
        Car search = new Car();
        //已选择了车辆类型
        search.setCarType(!car.getCarType().equals("tips")?car.getCarType():null);
        //已输入起点站
        search.setStartStation(car.getStartStation().length()>0?"%"+car.getStartStation()+"%":null);//模糊查询
        //已输入终点站
        search.setEndStation(car.getEndStation().length()>0?"%"+car.getEndStation()+"%":null);
        //已输入出发时间
        search.setStartDate(car.getStartDate().length()>0?car.getStartDate():null);
        if(identity.equals("admin")){
            //已输入司机名称
            search.setCarHostName(car.getCarHostName().length()>0?"%"+car.getCarHostName()+"%":null);
        }
        return carDao.findByLikeCondition(search);
    }

    /**
     * 统计车辆数
     * @return
     */
    @Override
    public int count() {
        return carDao.count();
    }
}
