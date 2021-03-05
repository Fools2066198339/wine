package com.hqyj.wine.entity;


import java.util.Arrays;
import java.util.Date;

//对象的定义
public class User {
    //user对象的成员变量
    private int id;  //对应user表里面的id字段，唯一识别一个user
    private String name; //user的昵称
    private String username; //user的登录账号
    private String password; //user的登录密码
    private String address; //地址
    private String phone; //电话
    private String email; //邮箱
    private int isValid; // 是否可用 1：可用，0：不可用
    //alt+enter快捷的导包
    private Date createTime; //user的创建时间
    private String[] ids;//id的集合
    //无参构造器
    //构造一个对象不传参数的话，成员变量都是默认值，int：0，对象型就是null
    public User() {

    }

    //构造器， 有参构造器
    //user对象创建的时候，可以直接将其成员变量赋值


    public User(int id, String name, String username, String password, String address, String phone, String email, int isValid, Date createTime, String[] ids) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.password = password;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.isValid = isValid;
        this.createTime = createTime;
        this.ids = ids;
    }

    public String[] getIds() {
        return ids;
    }

    public void setIds(String[] ids) {
        this.ids = ids;
    }

    //成员方法
    //getter方法：返回当前user对象的成员变量id的值

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getIsValid() {
        return isValid;
    }

    public void setIsValid(int isValid) {
        this.isValid = isValid;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    //把user对象转成一个字符串
    //用于控制台打印


    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", isValid=" + isValid +
                ", createTime=" + createTime +
                ", ids=" + Arrays.toString(ids) +
                '}';
    }
}
