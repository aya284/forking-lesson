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
public class QuizSubmit {
    public static Connection getConnection(){
        Connection conn = null;
        try{
            conn = UsersCrude.getConnection();
        }
        catch(Exception e){
            System.out.println("the error is in quizsubmit getconnection");
        }
        return conn;
    }
    
    public static int checkAnswer(String option, String answer){
        int check = 0;
        if(option.equals("") || option == null){
            return check;
        }
        else if(option.equals(answer)){
            check = 1;
        }
        else{
            check = -1;
        }
        return check;
    }
    
    public static int submitAnswerForThisUser(String uname, int id, String option, String answer){
        int flag = 0;
        int check = checkAnswer(option, answer);
        String topic = getTopicFromId(id);
        if(id == 0 || topic == null){
            System.out.println("the error is of qid being 0 or topic being null in submitAnswersForThisUser");
        }
        try{
            Connection con = getConnection();
            boolean gate = checkWhetherQuestionSeenFromId(uname, id);
            
            if(check == 1){
                if(gate){
                    PreparedStatement ps = con.prepareStatement("update quizdata set correct = ?, attempt = ? where uname = ? AND quizid = ?");
                    ps.setString(1, "true");
                    ps.setString(2, "true");
                    ps.setString(3, uname);
                    ps.setInt(4, id);
                    flag = ps.executeUpdate();
                    ps.close();
                }
                else{
                    PreparedStatement ps = con.prepareStatement("insert into quizdata(topic, correct, attempt, uname, quizid) values(?, ?, ?, ?, ?)");
                    ps.setString(1, topic);
                    ps.setString(2, "true");
                    ps.setString(3, "true");
                    ps.setString(4, uname);
                    ps.setInt(5, id);
                    flag = ps.executeUpdate();
                    ps.close();
                }    
            }
            
            else if(check == -1){
                if(gate){
                    PreparedStatement ps = con.prepareStatement("update quizdata set correct = ?, attempt = ? where uname = ? AND quizid = ?");
                    ps.setString(1, "false");
                    ps.setString(2, "true");
                    ps.setString(3, uname);
                    ps.setInt(4, id);
                    flag = ps.executeUpdate();
                    ps.close();
                }
                else{
                    PreparedStatement ps = con.prepareStatement("insert into quizdata(topic, correct, attempt, uname, quizid) values(?, ?, ?, ?, ?)");
                    ps.setString(1, topic);
                    ps.setString(2, "false");
                    ps.setString(3, "true");
                    ps.setString(4, uname);
                    ps.setInt(5, id);
                    flag = ps.executeUpdate();
                    ps.close();
                }    
            }
            
            else if(check == 0){
                if(gate){
                    PreparedStatement ps = con.prepareStatement("update quizdata set attempt = ? where uname = ? AND quizid = ?");
                    ps.setString(1, "false");
                    ps.setString(2, uname);
                    ps.setInt(3, id);
                    flag = ps.executeUpdate();
                    ps.close();
                }    
                else{
                    PreparedStatement ps = con.prepareStatement("insert into quizdata(topic, attempt, uname, quizid) values(?, ?, ?, ?)");
                    ps.setString(1, topic);
                    ps.setString(2, "false");
                    ps.setString(3, uname);
                    ps.setInt(4, id);
                    flag = ps.executeUpdate();
                    ps.close();
                }
            }
            
            else
                System.out.println("the error is of check in submitAnswerForThisUser");
        
            
            con.close();
        }                
        catch(Exception e){
            System.out.println("the error is submitAnswerfor this user  " + e);
        }
        return flag;
    }
    
    private static String getTopicFromId(int id){
        String topic = null;
        try{
            Connection con = getConnection();
            Statement stat = con.createStatement();
            ResultSet rs = stat.executeQuery("select topic from quiz_questions_all where id = '"+id+"'");
            
            while(rs.next())
                topic = rs.getString(1);
            
            rs.close();
            stat.close();
            con.close();
        }
        catch(Exception e){
            System.out.println("the error is getIDFromQuestion");
        }
        
        return topic;
    }
    
    private static boolean checkWhetherQuestionSeenFromId(String uname, int id){
        boolean gate = false;
        
        try{
            Connection conn = getConnection();
            Statement stat = conn.createStatement();
            ResultSet rs = stat.executeQuery("select quizid from quizdata where quizid = '"+id+"' AND uname = '"+uname+"'");
            while(rs.next())
                gate = true;
        }
        catch(Exception e){
            System.out.println("the error is in checkwhether is seenfrom id");
        }
        
        return gate;
    }

}
