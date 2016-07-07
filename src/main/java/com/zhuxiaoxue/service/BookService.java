package com.zhuxiaoxue.service;


import com.zhuxiaoxue.mapper.BookMapper;
import com.zhuxiaoxue.mapper.BookTypeMapper;
import com.zhuxiaoxue.mapper.PublisherMapper;
import com.zhuxiaoxue.pojo.Book;
import com.zhuxiaoxue.pojo.BookType;
import com.zhuxiaoxue.pojo.Publisher;
import com.zhuxiaoxue.util.Page;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

@Named
public class BookService {

    @Inject
    private BookMapper bookMapper;

    @Inject
    private BookTypeMapper bookTypeMapper;

    @Inject
    private PublisherMapper publisherMapper;

    public List<Publisher> findAllPub(){
        return publisherMapper.findAll();
    }

    public List<BookType> findAllType(){
        return bookTypeMapper.findAll();
    }

    public void save(Book book){
        bookMapper.save(book);
    }

    public List<Book> findAllBooks(){
        return bookMapper.findAll();
    }

    public void update(Book book){
        bookMapper.update(book);
    }

    public void del(Integer id){
        bookMapper.delete(id);
    }

    public Book findById(Integer id){
       return bookMapper.findById(id);
    }

    public Page<Book> findBookByPage(Integer p) {
        int totalSize = bookMapper.count().intValue();
        Page<Book> page = new Page<>(totalSize,p,6);

        List<Book> bookList =  bookMapper.findByPage(page.getStart(),6);
        page.setItems(bookList);
        return page;
    }

    public Page<Book> findBookByParams(Integer p, Map<String, Object> params) {
        int totalSize = bookMapper.countByParams(params).intValue();
        Page<Book> page = new Page<>(totalSize,p,6);

        params.put("start",page.getStart());
        params.put("size",6);

        List<Book> bookList =  bookMapper.findByParams(params);
        page.setItems(bookList);
        return page;

    }

    public List<Book> findByDataTables(Map<String,Object> params) {
        return bookMapper.findByDataTables(params);
    }

    public Long count() {
        return bookMapper.count();
    }

    public Long countByKeyword(String keyword) {
        return bookMapper.countByKeyword(keyword);
    }

    public List<Book> findBookByParam(Map<String, Object> params) {
        return bookMapper.findByParam(params);
    }

    public Long countByParam(Map<String, Object> params) {
        return bookMapper.countByParams(params);
    }
}
