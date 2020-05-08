package cn.lcm.controller;

import cn.lcm.domain.Car;
import cn.lcm.service.ICarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 表现层：车辆信息
 */
@Controller
@SessionAttributes(value = {"carCount"})
@RequestMapping("/car")
public class CarController {

    @Autowired
    private ICarService carService;

    /**
     * 添加车辆
     * @param car
     * @param model
     * @return
     */
    @RequestMapping("/addCar")
    public String addCar(Car car,Model model){
        car.setTicketValue(car.getTicketCount());  //初始化车票余量
        String result = carService.addCar(car);
        if(result.equals("success")){
            model.addAttribute("success","车辆添加成功！");
            return "success";
        }else if(result.equals("sameCarError")){
            model.addAttribute("success","该车辆信息已存在，请勿重复添加！");
            return "success";
        }else {
            return "500";
        }
    }

    /**
     * 查找车辆
     * @param identity
     * @param model
     * @param car
     * @return
     */
    @RequestMapping("/searchCar/{identity}")
    public String searchCar(@PathVariable("identity") String identity, Model model, Car car){
        List<Car> cars = carService.findByLikeCondition(car,identity);
        if(identity.equals("user")){
            model.addAttribute("userSearchCarResult",cars);
            return "searchCar";
        }else if(identity.equals("admin")){
            model.addAttribute("adminSearchCarResult",cars);
            return "searchCarForAdmin";
        }else {
            return "500";
        }
    }

    /**
     * 统计车辆信息  OK
     * @param model
     * @return
     */
    @RequestMapping("/countCar")
    public String countCar(Model model,HttpServletRequest request){
        List<Car> cars = carService.countCar();
        if(cars!=null){
            model.addAttribute("carCount",cars);
            request.setAttribute("haveCars","true");
        }else {
            request.setAttribute("haveCars","false");
        }
        return "countCar";
    }

    /**
     * 获取车辆信息、展示修改页面
     * @param carId
     * @param model
     * @return
     */
    @RequestMapping("/CarDetail/{position}")
    public String carDetail(@PathVariable("position") String position,@RequestParam("carId") int carId, Model model,HttpServletRequest request){
        List<Car> cars = carService.findById(carId);
        if(cars.size()>0){
            model.addAttribute("carDetail",cars.get(0));
            request.setAttribute("theCarType",cars.get(0).getCarType());
            if("showCarDetail".equals(position)){ //请求展示车辆详情
                return "carImformation";
            }else if("showUpdateCar".equals(position)){ //请求修改车辆
                return "updateCar";
            }else {
                return "500";
            }
        }else {
            return "500";
        }
    }

    @RequestMapping("/updateCar")
    public String updateCar(Car car,@RequestParam("carId") int carId,Model model,HttpServletRequest request){
        car.setCarId(carId);
        carService.updateCar(car);
        Car car1 = carService.findById(carId).get(0);
        model.addAttribute("carDetail",car1);
        request.setAttribute("theCarType",car1.getCarType());
        return "carImformation";
    }

    /**
     * 删除车辆
     * @param carId
     * @param position
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/deleteCar/{carId}")
    public String deleteCar(@PathVariable("carId") int carId,@RequestParam("position") String  position,Model model,HttpServletRequest request){
        carService.deleteCar(carId);
        if("countCar".equals(position)){ //删除操作来自于车辆统计页面
            List<Car> cars = carService.countCar();
            if(cars!=null){
                model.addAttribute("carCount",cars);
                request.setAttribute("haveCars","true");
            }else {
                request.setAttribute("haveCars","false");
            }
            return "countCar";
        }else { //来自于车辆查询页面
            return "searchCar";
        }
    }
}
