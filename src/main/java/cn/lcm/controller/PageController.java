package cn.lcm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 *控制页面跳转
 */
@Controller
public class PageController {

    @RequestMapping("/page/{pageName}")
    public String loading(@PathVariable("pageName") String pageName){
        return pageName;
    }

}
