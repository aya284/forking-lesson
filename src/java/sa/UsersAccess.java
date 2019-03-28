/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sa;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Shreyash Agrawal
 */
public class UsersAccess {
 
    private static Connection getConnection(){
        Connection conn = null;
        try{
            conn = UsersCrude.getConnection();
            
        }
        catch(Exception e){
            System.out.println("the error is in UsersAccess/getConnection");
        }
        return conn;
    }
    public static boolean getLoginUser(String uname, String pword){
        boolean check = false;
        
        try{
            Connection conn = getConnection();
            Statement ps = conn.createStatement();
            ResultSet rs = ps.executeQuery("select uname, password from users_info");
                while(rs.next()){
                    String user = rs.getString("uname");
                    String pass = rs.getString("password");

                    if(uname.equals(user) && pword.equals(pass)){
                        check = true;
                        break;
                    }
                }
            conn.close();
        }
        catch(Exception e){
            System.out.println("the error is in getLoginUser  " + e);
        }
        
        return check;
    }
    
    
    public static boolean uniqueUnameCheck(String uname){
        boolean check = true;
        
        try{
            Connection conn = getConnection();
           Statement ps = conn.createStatement();
           ResultSet rs = ps.executeQuery("select uname from users_info");
           while(rs.next()){
               String dname = rs.getString("uname");
               if(uname.equals(dname)){
                   check = false;
                   break;
               }
           }
           conn.close();
        }
        catch(Exception e){
            System.out.println("the error is in registrationUnameCheck  " + e);
        }
        
        return check;
    }
    
    
}
