package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.Book;
import com.zhuxiaoxue.util.Page;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.Map;

/**
 * Created by Eric on 2016/7/6.
 */
public interface BookMapper {

    void save(Book book);

    Book findById(Integer id);

    List<Book> findAll();

    void update(Book book);

    void delete(Integer id);

    List<Book> findByPage(@Param("start") Integer start, @Param("size") Integer size);

    Long count();

    Long countByParams(Map<String, Object> params);

    List<Book> findByParams(Map<String, Object> params);

    List<Book> findByDataTables( Map<String, Object> params);

    Long countByKeyword(@Param("keyword") String keyword);

    List<Book> findByParam(Map<String, Object> params);
}
