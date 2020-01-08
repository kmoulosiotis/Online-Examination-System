package com.oes.dao;

public class Class {
    public int class_id;
    public String class_name;

    public Class(int class_id, String class_name) {
        this.class_id = class_id;
        this.class_name = class_name;
    }
    
    public Class(){
    
    }
    
    public int getClass_id() {
        return class_id;
    }

    public void setClass_id(int class_id) {
        this.class_id = class_id;
    }

    public String getClass_name() {
        return class_name;
    }

    public void setClass_name(String class_name) {
        this.class_name = class_name;
    }
    
    
}
