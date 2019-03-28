/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sa;

import java.sql.*;
import java.util.*;
/**
 *
 * @author Shreyash Agrawal
 */
public class UsersCrude {
    
   public static Connection getConnection(){
        Connection conn = null;
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizproject","root","root");
            
        }
        catch(Exception e){
            System.out.println("the error is at connection");
        }
        return conn;
    }
    
    private static int[] getIdFromUName(String uname){
        int id[] = new int[2];
        
        try{
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("select id from users_info where uname = ?");
            ps.setString(1, uname);
            ResultSet rs = ps.executeQuery();
            while(rs.next())
                id[0] = rs.getInt(1);
            
            ps.close();
            rs.close();
            
            PreparedStatement ps2 = conn.prepareStatement("select id from quizdata where uname = ?");
            ps2.setString(1, uname);
            ResultSet rs2 = ps2.executeQuery();
            while(rs2.next())
                id[1] = rs2.getInt(1);
            
            rs2.close();
            ps2.close();
            conn.close();
        }
        catch(Exception e){
            System.out.println("the error is in getidfromuname");
        }
        return id;
    }
    
    private static boolean checkIfUNameInTableQuizData(String uname){
        boolean check = false;
        try{
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("select uname from quizdata where uname = ?");
            ps.setString(1, uname);
            ResultSet rs = ps.executeQuery();
            while(rs.next())
                check = true;
            rs.close();
            ps.close();
            conn.close();
        }
        catch(Exception e){
            System.out.println("the error is in check uname in table quizdata " + e);
        }
        return check;
    }
    
    public static int changeUname(String olduname, String newuname){
        int check = 0;
        int id[] = getIdFromUName(olduname);
        
        try{
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("update users_info set uname = ? where id = ?", Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, newuname);
            ps.setInt(2, id[0]);
            int check1 = ps.executeUpdate();
            
            boolean flag = true;
                               
            if(checkIfUNameInTableQuizData(olduname)){
                
                PreparedStatement ps2 = conn.prepareStatement("update quizdata set uname = ? where id = ?");
                ps2.setString(1, olduname);
                ps2.setInt(2, id[1]);
                int check2 = ps2.executeUpdate();
                System.out.println("check2 " + check2);
                if(check2<=0)
                    flag = false;
            
                ps.close();
                ps2.close();
                
            }
            if(check1 > 0 && flag){
                check++;
            }
            conn.close();
        }
        catch(Exception e){
            System.out.println("the error is in changeUsername  " + e);
        }
        
        return check;
    }
    
    public static int saveUser(UsersInfo user){
        int check = 0;
        
        try{
            Connection conn = getConnection();
            PreparedStatement stat = conn.prepareStatement("insert into users_info(uname, password, email, gender, country, dob) values(?, ?, ?, ?, ?, ?)");
            stat.setString(1, user.getUname());
            stat.setString(2, user.getPassword());
            stat.setString(3, user.getEmail());
            stat.setString(4, user.getGender());
            stat.setString(5, user.getCountry());
            stat.setString(6, user.getDob());
            
            check = stat.executeUpdate();
            conn.close();
        }
        catch(Exception e){
            System.out.println("the error is at saveUser  " + e);
        }
        
        return check;
    }
    
    public static int updateUser(UsersInfo user){
        int check = 0;
        
        try{
            Connection conn = getConnection();
            PreparedStatement stat = conn.prepareStatement("update users_info set password = ?, email = ?, gender = ?, country = ?, dob = ? where uname = ?");
            
            stat.setString(1, user.getPassword());
            stat.setString(2, user.getEmail());
            stat.setString(3, user.getGender());
            stat.setString(4, user.getCountry());
            stat.setString(5, user.getDob());
            stat.setString(6, user.getUname());
            
            check = stat.executeUpdate();
            
            conn.close();
        }
        catch(Exception e){
            System.out.println("the error is at updateuser  " + e);
        }
        
        return check;
    }
    
    public static int deleteUser(String uname){
        int check = 0;
        
        try{
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("delete from users_info where uname = ?");
            ps.setString(1, uname);
            int check1 = ps.executeUpdate();
            
            boolean flag = true;
            if(checkIfUNameInTableQuizData(uname)){
                PreparedStatement ps2 = conn.prepareStatement("delete from quizdata where uname = ?");
                ps2.setString(1, uname);
                int check2 = ps2.executeUpdate();
                System.out.println("in the second");
                if(check2<=0)
                    flag = false;
            
                ps.close();
                ps2.close();
                
            }
            if(check1 > 0 && flag){
                check++;
            }
            conn.close();
        }
        catch(Exception e){
            System.out.println("error is at deleteUser  " + e);
        }
    
        return check;
    }
    
    public static UsersInfo getUserByUName(String uname){
        
        UsersInfo user = new UsersInfo();
        
        try{
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("select *from users_info where uname = ?");
            ps.setString(1, uname);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                user.setUname(rs.getString("uname"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setGender(rs.getString("gender"));
                user.setCountry(rs.getString("country"));
                user.setDob(rs.getString("dob"));
            }
            conn.close();
        }
        catch(Exception e){
            System.out.println("the error is at getuserbyuname  " + e);
        }
        
        return user;
    }
    
    public static List<UsersInfo> getAllUsers(){
        
        List<UsersInfo> list = new ArrayList<UsersInfo>();
        
        try{
            Connection conn = getConnection();
            Statement stat = conn.createStatement();
            ResultSet rs = stat.executeQuery("select *from users_info");
            
            while(rs.next()){
                UsersInfo users = new UsersInfo();
                users.setId(rs.getInt("id"));
                users.setUname(rs.getString(2));
                users.setPassword(rs.getString(3));
                users.setEmail(rs.getString(4));
                users.setGender(rs.getString(5));
                users.setCountry(rs.getString(6));
                users.setDob(rs.getString(7));
                
                list.add(users);
            }
         }
        catch(Exception e){
        
            System.out.println("error in all users");
        }
              
        
        return list;
    }
}
