package com.zhuxiaoxue.controller;


import com.google.common.collect.Maps;
import com.zhuxiaoxue.pojo.Book;
import com.zhuxiaoxue.service.BookService;
import com.zhuxiaoxue.util.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/dataTable")
public class DataTableController {

    @Inject
    private BookService bookService;


    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model){
//        model.addAttribute("bookList",bookService.findAllBooks());
        return "/tables/list";
    }

    @RequestMapping(value = "/data.json",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> load(HttpServletRequest request){

        String drow = request.getParameter("drow");

        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("search[value]");
        String columnsIndex = request.getParameter("order[0][column]");
        String sortType = request.getParameter("order[0][dir]");
        String sortColumnsName = request.getParameter("columns["+ columnsIndex +"][name]");

        Map<String,Object> params = Maps.newHashMap();
        params.put("start",start);
        params.put("length",length);
        params.put("keyword",keyword);
        params.put("sortType",sortType);
        params.put("sortColumnsName",sortColumnsName);

        keyword = Strings.toUTF8(keyword);
        List<Book> bookList = bookService.findByDataTables(params);

        Map<String,Object> result = Maps.newHashMap();
        result.put("data",bookList);
        result.put("drow",drow);
        result.put("recordsTotal",bookService.count());
        result.put("recordsFiltered",bookService.countByKeyword(keyword));
        return result;
    }

}
