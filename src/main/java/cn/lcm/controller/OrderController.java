package cn.lcm.controller;

import cn.lcm.domain.OrderDetail;
import cn.lcm.domain.User;
import cn.lcm.service.IOrderService;
import cn.lcm.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 表现层：操作订单
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private IOrderService orderService;

    @Autowired
    private IUserService userService;
    /**
     * 订票（下单）
     * @param userName
     * @param carId
     * @param model
     * @return
     */
    @RequestMapping("/buy")
    public String buyTicket(@RequestParam("userName") String userName,@RequestParam("carId") String carId,Model model){
        User user= userService.findById(userName).get(0);
        if(user.getuName()!=null & user.getUserPhone()!=null & user.getIdNumber()!=null & user.getUserAddress()!=null){ //用户已完善了个人信息
            if(orderService.add(userName, Integer.parseInt(carId))){
                model.addAttribute("success","购票成功！！");
                return "success";
            }
            model.addAttribute("success","你已订购过该程车票，请勿重复订购！");
            return "success";
        }else {
            model.addAttribute("success","你要先完善个人信息，才能购票哦！");
            return "success";
        }
    }

    /**
     * 用户订单信息统计
     * @param userName
     * @param model
     * @return
     */
    @RequestMapping("/userOrder")
    public String userOrder(@RequestParam("userName") String userName, Model model, HttpServletRequest request){
        List<OrderDetail> userOrders = orderService.findUserOrder(userName);
        if (userOrders!=null){
            request.setAttribute("userHasOrder","true");
            model.addAttribute("userOrders",userOrders);
        }else{
            request.setAttribute("userHasOrder","false");  //该用户无订单
        }
        return "userOrder";
    }

    /**
     * 取消订单 OK
     * @param orderId
     * @param request
     * @return
     */
    @RequestMapping("/cancelOrder")
    public String cancelOrder(@RequestParam("orderId") String orderId, @RequestParam("userName") String userName, HttpServletRequest request, Model model){
        orderService.cancel(orderId);
        List<OrderDetail> userOrders = orderService.findUserOrder(userName);
        if (userOrders!=null){
            request.setAttribute("userHasOrder","true");
            model.addAttribute("userOrders",userOrders);
        }else{
            request.setAttribute("userHasOrder","false");  //该用户无订单
        }
        return "userOrder";

    }

    /**
     * 统计订单信息
     * @param model
     * @return
     */
    @RequestMapping("/countOrder")
    public String countOrder(Model model,HttpServletRequest request){
        List<OrderDetail> countOrders = orderService.countOrder();
        if(countOrders!=null){//有订单
            model.addAttribute("countOrders",countOrders);
            request.setAttribute("haveOrders","true");
        }else {
            request.setAttribute("haveOrders","false");  //无订单信息
        }
        return "countOrder";
    }

    /**
     * 删除订单
     * @param orderId
     * @param model
     * @return
     */
    @RequestMapping("/deleteOrder")
    public String deleteOrder(@RequestParam("orderId") String orderId,Model model,HttpServletRequest request){
        orderService.delete(orderId);
        List<OrderDetail> countOrders = orderService.countOrder();
        if(countOrders!=null){//有订单
            model.addAttribute("countOrders",countOrders);
            request.setAttribute("haveOrders","true");
        }else {
            request.setAttribute("haveOrders","false");  //无订单信息
        }
        return "countOrder";
    }
}
