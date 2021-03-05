package com.hqyj.wine.service;

import com.hqyj.wine.entity.User;
import com.hqyj.wine.entity.Wine;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

//利用单元测试框架junit测试UserService对象
//告诉junit测试框架当前测试需要运行再spring框架的环境下
@RunWith(SpringJUnit4ClassRunner.class)
//告诉spring框架，spring的配置文件所在地址
@ContextConfiguration(locations = "classpath:config/spring.xml")
public class UserServiceTest {

    @Autowired
    private UserService userService;
    @Autowired
    private WineService wineService;

    @Test
    public void loginTest() {
        User zhangsan = userService.login("zhangsan", "12345");
        System.out.println(zhangsan);
    }

    @Test
    public void getAllTest() {
        List<User> all = userService.getAll();
        //遍历List<User>集合
        for (User user : all) {
            //打印一个user
            System.out.println(user);
        }
    }

    @Test
    public void getSomeTest() {
        List<User> result = userService.getSome("888");
        System.out.println(result);
    }
    @Test
    public void getOneTest() {
        User result = userService.queryOneByName("liukui");
        System.out.println(result);
    }
    @Test
    public void removeOneTest() {
        boolean result = userService.removeOne(4);
        if (result) {
            System.out.println("删除成功");
        } else {
            System.out.println("删除失败");
        }
    }

    @Test
    public void addOneTest() {
        User user = new User(); //创建一个user对象
        user.setName("翠花");
        user.setUsername("cuihua1");
        user.setPassword("123456");
        user.setAddress("山东");
        user.setPhone("18911111111");
        user.setEmail("cuihua@qq.com");
        boolean added = userService.addOne(user);
        if (added) {
            System.out.println("添加用户成功");
        } else {
            System.out.println("添加用户失败");
        }
    }
    @Test
    public void addOneTest1() {
            Wine wine = new Wine(); //创建一个user对象
            wine.setWineName("翠花");
            wine.setPrice("5000");
            wine.setProduceAddress("四川");
            wine.setWineType("sf");
            wine.setBouquet("酱香型");
            wine.setWineSale("20000");
            boolean add = wineService.addOne(wine);
            if(add){
                System.out.println("添加用户成功");
            }else{
                System.out.println("添加用户失败");
            }
        }


    @Test
    public void modifyOneTest(){
        User user = userService.getOne(9);
        user.setPhone("11111111111");
        user.setEmail("111@111.com");
        boolean modified = userService.modifyOne(user);
        if(modified){
            System.out.println("编辑用户成功");
        }else{
            System.out.println("编辑用户失败");
        }
    }
    @Test
    public void modifyOneTest1(){
        Wine wine = wineService.getOne(1);
        wine.setWineName("翠花");
        wine.setProduceAddress("贵州");
        wine.setWineSale("20.0");
        boolean modified = wineService.modifyOne(wine);
        if(modified){
            System.out.println("编辑成功");
        }else{
            System.out.println("编辑失败");
        }
    }
    @Test
    public void modifyPwdTest(){
        User user = userService.queryOneByName("liukui");

        boolean modified = userService.upPassword(user,"123456789","123456");
        if(modified){
            System.out.println("编辑用户成功");
        }else{
            System.out.println("编辑用户失败");
        }
    }
    @Test
    public void removeSomeTest() {
        String[] ids = new String[]{"2"};
        boolean result = userService.deleteSomeById(ids);
        if (result) {
            System.out.println("删除成功");
        } else {
            System.out.println("删除失败");
        }
    }
}
