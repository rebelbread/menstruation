package tk.mybatis.springboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author zhiwj
 * @date 2019/1/31
 */
@Controller
public class IndexController {

    @RequestMapping
    public String getUrl() {
        return "index";
    }

}
