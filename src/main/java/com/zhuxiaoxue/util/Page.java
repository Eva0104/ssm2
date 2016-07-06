package com.zhuxiaoxue.util;

import java.util.List;

public class Page<T> {
    /**
     * 总数据
     */
    private Integer totalSize;
    /**
     * 总页数
     */
    private Integer totalPageSize;
    /**
     * 当前页码
     */
    private Integer pageNum;
    /**
     * 每页显示多少条数据
     */
    private Integer size;
    /**
     * 当前页的起始行数
     */
    private Integer start;
    /**
     * 当前页的数据
     */
    private List<T> items;

    public Page(Integer totalSize, Integer pageNum, Integer size) {
        this.totalSize = totalSize;
        this.pageNum = pageNum;
        this.size = size;

        totalPageSize = totalSize / size;


        if (totalSize % size != 0) {
            totalPageSize++;
        }

        if (pageNum > totalPageSize) {
            this.pageNum = totalPageSize;
        }

        if(this.pageNum <=0 ){
            this.pageNum = 1;
        }

        start = (this.pageNum - 1) * size;

    }

    public void setItems(List<T> items) {
        this.items = items;
    }

    public List<T> getItems() {
        return items;
    }

    public Integer getTotalPageSize() {
        return totalPageSize;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public Integer getStart() {
        return start;
    }

    public Integer getTotalSize() {
        return totalSize;
    }
}
