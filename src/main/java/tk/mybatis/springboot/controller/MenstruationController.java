package tk.mybatis.springboot.controller;

import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.springboot.mapper.MenstruationMapper;
import tk.mybatis.springboot.model.Menstruation;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * @author zhiwj
 * @date 2019/1/31
 */
@RestController
@RequestMapping("/Menstruation")
public class MenstruationController {

    @Autowired
    private MenstruationMapper menstruationMapper;

    @RequestMapping("/list")
    public List<Menstruation> menstruationList() {
        Example example = new Example(Menstruation.class);
        return menstruationMapper.selectByExample(example);
    }

    @RequestMapping("/save")
    public Integer saveMenstruation() {

        Menstruation curr = new Menstruation();
        curr.setCreateTime(LocalDateTime.now());
        LocalDate now = LocalDate.now();
        curr.setDate(now);
        curr.setDateStr(now.toString());

        // 查询上一次 获取时间
        Example example = new Example(Menstruation.class);
        example.orderBy("date").desc();
        PageHelper.startPage(0, 1);
        Menstruation last = menstruationMapper.selectOneByExample(example);
        // 封装参数
        if (last != null) {
            // 计算日期
            Period between = Period.between(last.getDate(), curr.getDate());
            int days = between.getDays();
            curr.setDiff(days);
        }
        menstruationMapper.insertSelective(curr);
        return 0;
    }

}
