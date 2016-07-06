package com.zhuxiaoxue.util;

import java.io.UnsupportedEncodingException;

public class Strings {

    public static String toUTF8(String str){
        if(str != null){
            try {
                return new String(str.getBytes("ISO8859-1"),"UTF-8");
            } catch (UnsupportedEncodingException e) {
                throw new RuntimeException("字符串转码异常");
            }
        }
        return "";
    }
}
