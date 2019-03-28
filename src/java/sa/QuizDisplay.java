/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sa;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
//import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 *
 * @author Shreyash Agrawal
 */
public class QuizDisplay {
    
    public static Connection getConnection(){
        Connection conn = null;
        try{
            conn = UsersCrude.getConnection();
            
        }
        catch(Exception e){
            System.out.println("the error is in quizdisplay getconnection");
        }
        return conn;
    }
    
    //fetching topics for dragdown menu
    
    public static List<String> getTopicsInDatabase(){
        List<String> list = new ArrayList<String>();
        
        try{
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("select *from quiztopics");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                list.add(rs.getString("topic"));
            }
            
            rs.close();
            ps.close();
            con.close();
        }
        catch(Exception e){
            System.out.println("the error is in getTopicsInDatabase   " + e);
        }
        
        return list;
    }
    
    //fetching data for those who are Logged IN
    
    public static QuizTotalDataOnly getOnlyTotalQuizData(String uname){
        QuizTotalDataOnly data = new QuizTotalDataOnly();
        
        try{
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("select attempt, correct from quizdata where uname = ?");
            ps.setString(1, uname);
            ResultSet rs = ps.executeQuery();
            int unattempted;
            int attempted = 0;
            int correct = 0;
            int incorrect = 0;
            
            while(rs.next()){
                
                if(Boolean.parseBoolean(rs.getString("attempt")) == true)
                    attempted++;
                                
                if(rs.getString("correct") == null){
                }
                
                else if(Boolean.parseBoolean(rs.getString("correct")) == false)
                    incorrect++;
                
                else
                    if(Boolean.parseBoolean(rs.getString("correct")) == true)
                        correct++;
            }
            
            unattempted = getTotalNumberOfQuestionsInDatabase() - attempted;
            
            data.setTotal_attempted(attempted);
            data.setTotal_correct(correct);
            data.setTotal_incorrect(incorrect);
            data.setTotal_unattempted(unattempted);
            
            ps.close();
            rs.close();
            conn.close();
        }
        catch(Exception e){
            System.out.println("the error is in getonlytotalquizdata");
        }
        
        return data;
    }
    
    /**
     *
     * @param uname
     * @return
     */
    public static Map<String, QuizSubjData> getOnlySubjQuizData(String uname){
        Map<String, QuizSubjData> map = new LinkedHashMap<String, QuizSubjData>();
        
        try{
            Connection conn = getConnection();
            Statement stat = conn.createStatement();
            ResultSet rset = stat.executeQuery("select topic from quiztopics");
                        
            while(rset.next()){
                //System.out.println("inside loop after quiz topic query");
                String topic = rset.getString(1);
                
                int unattempted = 0;
                int attempted = 0;
                int correct = 0;
                int incorrect = 0;
                
                PreparedStatement ps = conn.prepareStatement("select attempt, correct from quizdata where uname = ? AND topic = ?");
                ps.setString(1, uname);
                ps.setString(2, topic);
                ResultSet rss = ps.executeQuery();
                
                while(rss.next()){
                //System.out.println("inside loop after quiz data query");

                    if(Boolean.parseBoolean(rss.getString("attempt")))
                        attempted+=1;

                    if(rss.getString("correct") == null){
                    }
                    
                    else if(Boolean.parseBoolean(rss.getString("correct")))
                        correct+=1;
                
                    else
                        incorrect+=1;
                    
                }
                ps.close();
                rss.close();
                
                int que = getTotalQuestionsByTopic(topic);
                if(que > 0)
                    unattempted = que - attempted;
                else
                    System.out.println("error in total questions by topic not greater than 0");
                
                QuizSubjData data = new QuizSubjData();
                data.setSubj_attempted(attempted);
                data.setSubj_unattempted(unattempted);
                data.setSubj_corrected(correct);
                data.setSubj_incorrect(incorrect);
                
                map.put(topic, data);
            }
            stat.close();
            rset.close();
            conn.close();
            
        }
        catch(Exception e){            
            System.out.println("the error is getonlysubjquizdata");
        }
        
        return map;
    }
    
    public static List<QuizQuestions> getQuestionsByTopic(String uname, String topic){
        
        
        List<QuizQuestions> list = new ArrayList<QuizQuestions>();
        
        try{
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("select quizid from quizdata where uname = ? AND topic = ? AND attempt = 'true' ");
            ps.setString(1, uname);
            ps.setString(2, topic);
            ResultSet rs = ps.executeQuery();
            List<Integer> temp = new ArrayList<Integer>();
            
            while(rs.next()){
                int id = rs.getInt(1);   
                System.out.print("  " + id + "  ");
                temp.add(id);
            }
            rs.close();
            ps.close();
            
            if(temp.isEmpty()){
                PreparedStatement stat = conn.prepareStatement("select *from quiz_questions_all where topic = ?");
                stat.setString(1, topic);
                ResultSet rst = stat.executeQuery();
                
                while(rst.next()){
                    QuizQuestions que = new QuizQuestions();
                
                    que.setId(rst.getInt(1));
                    que.setQuestion(rst.getString("question"));
                    que.setAnswer(rst.getString("answer"));

                    String[] options = new String[4];
                    for(int i=1; i<5; i++){
                        options[i-1] = rst.getString("option" + i);
                    }

                    que.setOptions(options);   

                    list.add(que);
                }
                rst.close();
                stat.close();
            }
            
            else{
                String id = "";
                for(int i=0; i<temp.size(); i++){
                    id += "" + temp.get(i) + ", ";
                    if((i+1) == temp.size()){
                        int len = id.length();
                        id = id.substring(0, len - 2);
                    }
                }
                String query = "select *from quiz_questions_all where topic = '" + topic +"' AND id NOT IN (";

                query += id + ")"; 
                //System.out.println("this is the ids (" + id + ")");
                Statement stat = conn.createStatement();
                ResultSet rst = stat.executeQuery(query); 
                while(rst.next()){
                    QuizQuestions que = new QuizQuestions();
                
                    que.setId(rst.getInt(1));
                    que.setQuestion(rst.getString("question"));
                    que.setAnswer(rst.getString("answer"));

                    String[] options = new String[4];
                    for(int i=1; i<5; i++){
                        options[i-1] = rst.getString("option" + i);
                    }

                    que.setOptions(options);   

                    list.add(que);
                }
                rst.close();
                stat.close();
            }
            
            conn.close();
        }     
        catch(NullPointerException e){
            System.out.println("error in getquestionsbytopic - no question    " + e);
        }
        catch(Exception e){
            System.out.println("the error is in getQuestionbyTopic  " + e);
        }
        
        Collections.shuffle(list, new Random());
        
        return list;
    }
    
    public static List<QuizQuestions> getQuestionsRandomly(String uname){

        List<QuizQuestions> list = new ArrayList<QuizQuestions>();
        
        try{
            Connection conn = getConnection();
            Statement ps = conn.createStatement();
            ResultSet rs = ps.executeQuery("select quizid from quizdata where uname = '"+uname+"' AND attempt = 'true' ");
            List<Integer> temp = new ArrayList<Integer>();
            
            while(rs.next()){
                int id = rs.getInt(1);             
                temp.add(id);
            }
            rs.close();
            ps.close();
            
            if(temp.isEmpty()){
                Statement stat = conn.createStatement();
                ResultSet rst = stat.executeQuery("select *from quiz_questions_all");
                
                while(rst.next()){
                    QuizQuestions que = new QuizQuestions();
                
                    que.setId(rst.getInt(1));
                    que.setQuestion(rst.getString("question"));
                    que.setAnswer(rst.getString("answer"));

                    String[] options = new String[4];
                    for(int i=1; i<5; i++){
                        options[i-1] = rst.getString("option" + i);
                    }

                    que.setOptions(options);   

                    list.add(que);
                }
                rst.close();
                stat.close();
            }
            
            else{
                String id = "";
                for(int i=0; i<temp.size(); i++){
                    id += "" + temp.get(i) + ", ";
                    if((i+1) == temp.size()){
                        int len = id.length();
                        id = id.substring(0, len - 2);
                    }
                }
                String query = "select *from quiz_questions_all where id NOT IN (";

                query += id + ")"; 
                //System.out.println("this is the ids (" + id + ")");
                Statement stat = conn.createStatement();
                ResultSet rst = stat.executeQuery(query); 
                while(rst.next()){
                    QuizQuestions que = new QuizQuestions();
                
                    que.setId(rst.getInt(1));
                    que.setQuestion(rst.getString("question"));
                    que.setAnswer(rst.getString("answer"));

                    String[] options = new String[4];
                    for(int i=1; i<5; i++){
                        options[i-1] = rst.getString("option" + i);
                    }

                    que.setOptions(options);   

                    list.add(que);
                }
                rst.close();
                stat.close();
            }

            conn.close();
        }       
        catch(Exception e){
            System.out.println("the error is in getQuestionbyTopic");
        }
        
        Collections.shuffle(list, new Random());
        
        return list;
    }
    
    //fetching data for those who are not loged in
   public static List<QuizQuestions> get5QuestionsByTopic(String topic){
        
 
        List<QuizQuestions> list = new ArrayList<QuizQuestions>();
        
        List<Integer> qids = get5RandomQIDByTopic(topic);
        
        try{
            Connection con = getConnection();
                        
            for(Integer jump: qids){       
                Statement ps = con.createStatement();
                ResultSet rs = ps.executeQuery("select *from quiz_questions_all where id = '"+jump+"'");
                while(rs.next()){
                    QuizQuestions que = new QuizQuestions();
                    que.setQuestion(rs.getString("question"));

                    String options[] = new String[4];
                    for(int j = 1; j < 5; j++){
                        options[j-1] = rs.getString("option" + j);            
                    }
                    que.setOptions(options);

                    que.setAnswer(rs.getString("answer"));

                    list.add(que);
                }
                rs.close();
                ps.close();
            }
            
            con.close();
        }
        catch(SQLException e){
            System.out.println("the error is in get5QuestionsByTopic  " + e);
        }
        catch(Exception e){
            System.out.println("the error is in get5QuestionsByTopic  " + e);
        }
        Collections.shuffle(list);
        return list;
    }
    
    //fetches 5 questions randomly from quiz material database
    public static List<QuizQuestions> get5QuestionsRandomly(){
        
        List<QuizQuestions> list = new ArrayList<QuizQuestions>();
        
        List<Integer> temp = get5RandomId();
        
        try{
            Connection conn = getConnection();
            for(Integer i: temp){
                Statement ps = conn.createStatement();
                ResultSet rs = ps.executeQuery("select *from quiz_questions_all where id = '"+i+"'");
                
                while(rs.next()){
                    QuizQuestions que = new QuizQuestions();
                    que.setQuestion(rs.getString("question"));

                    String options[] = new String[4];
                    for(int j=1; j<5; j++){
                        options[j-1] = rs.getString("option" + j);            
                    }
                    que.setOptions(options);

                    que.setAnswer(rs.getString("answer"));

                    list.add(que);
                }    
            }
            
            conn.close();
        }
        catch(Exception e){
            System.out.println("the error is in get5Questions Randomly  " + e);
        }
        
        Collections.shuffle(list);
        return list;
    }
    
    //fetches the id of 5 questions in quiz material database randomly
    private static List get5RandomId(){
        Random random = new Random();
        List<Integer> list = new ArrayList<Integer>();
        
        int total = getTotalNumberOfQuestionsInDatabase();
        
        if(total > 0){
            for(int i=0; i<5; i++){
                int number = random.nextInt(total);
                if((!list.contains(number)) && (number>0)){
                    list.add(number);
                }
                else
                    i--;

            }
        }
        else{
            System.out.println("error of totalnumberof entries");
        }
        return list;
    }
    
    //fetches the id of 5 questions of same topic in quiz material database randomly
    private static List<Integer> get5RandomQIDByTopic(String topic){
        List<Integer> list = new ArrayList<Integer>(5);
        
        try{
            Connection conn = getConnection();
            Statement ps = conn.createStatement();
            ResultSet rs = ps.executeQuery("select id, topic from quiz_questions_all where topic='"+topic+"'");
            List<Integer> temp = new ArrayList<Integer>();
            while(rs.next()){
                temp.add(rs.getInt("id"));
            }
            rs.close();
            ps.close();
            conn.close();
            Collections.shuffle(temp, new Random());
            
            for(int i = 0; i < 5; i++){
                list.add((Integer)temp.remove(0));
            }            
        }
        catch(IndexOutOfBoundsException e){
            System.out.println("the error is in get5randomQIDbytopic  " + e);
        }
        catch(Exception e){
            System.out.println("the error is in get5randomQIDbytopic  " + e);
        }
        
             
        return list;
    }
    
    //fetches the size of the quiz material database
    private static int getTotalNumberOfQuestionsInDatabase(){
        int size = 0;
        
        try{
            Connection conn = getConnection();
            
                Statement ps = conn.createStatement();

                ResultSet rs = ps.executeQuery("SELECT id FROM quiz_questions_all ORDER BY id DESC LIMIT 1");
                
                while(rs.next())
                size = rs.getInt("id");

                ps.close();
                rs.close();
                conn.close();
        }
        catch(Exception e){
            System.out.println("the error is in getTotalnumberofentriesindatabase");
        }
        
        return size;
    }
    
    private static int getTotalQuestionsByTopic(String topic){
        int size = 0;
        
        try{
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("select id, topic from quiz_questions_all where topic = ?");
            ps.setString(1, topic);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                size++;
            }
            
            rs.close();
            ps.close();
            con.close();
        }
        catch(Exception e){
            System.out.println("the error is gettotalentriesbytopic  " + e);
        }
        
        return size;
    }
    
    private static List<Integer> whichOnesId(String uname, String topic, String correct){
        List<Integer> list = new ArrayList<Integer>();
        
        try{
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("select quizid from quizdata where uname = ? AND topic = ? AND correct = ? AND attempt = 'true'");
            ps.setString(1, uname);
            ps.setString(2, topic);
            ps.setString(3, correct);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next())
                list.add(rs.getInt("quizid"));
            
            rs.close();
            ps.close();
            conn.close();
        }
        catch(Exception e){
            System.out.println("the error is in correct ones id " + e);
        }
        
        return list;
    }
    
    public static List<AttemptedTopic> correctOnes(String uname, String topic){
        List<AttemptedTopic> list = new ArrayList<AttemptedTopic>();
        
        List ids = whichOnesId(uname, topic, "true");
        
        if(ids.isEmpty())
            return list;
        
        try{
            Connection conn = getConnection();
            
            String id = "";
                for(int i=0; i<ids.size(); i++){
                    id += "" + ids.get(i) + ", ";
                    
                    if((i+1) == ids.size()){
                        int len = id.length();
                        id = id.substring(0, len - 2);
                    }
                }
                
            String query = "select question, answer from quiz_questions_all where id IN (";

            query += id + ")";     
            //System.out.println(query +"  "+ id);
            Statement ps = conn.createStatement();
            ResultSet rs = ps.executeQuery(query);
            while(rs.next()){
                AttemptedTopic a = new AttemptedTopic();
                a.setAnswer(rs.getString("answer"));
                a.setQuestion(rs.getString("question"));
                list.add(a);
            }
            rs.close();
            ps.close();
            conn.close();
        }
        catch(Exception e){
            System.out.println("error is in correct ones " + e);
        }
        
        return list;
    }
    
    public static List<AttemptedTopic> wrongOnes(String uname, String topic){
        List<AttemptedTopic> list = new ArrayList<AttemptedTopic>();
        
        List ids = whichOnesId(uname, topic, "false");
        
        if(ids.isEmpty())
            return list;
        
        try{
            Connection conn = getConnection();
            
            String id = "";
                for(int i=0; i<ids.size(); i++){
                    id += "" + ids.get(i) + ", ";
                    if((i+1) == ids.size()){
                        int len = id.length();
                        id = id.substring(0, len - 2);
                    }
                }
                
            String query = "select question, answer from quiz_questions_all where id IN (";

            query += id + ")";     
            
            Statement ps = conn.createStatement();
            ResultSet rs = ps.executeQuery(query);
            while(rs.next()){
                AttemptedTopic a = new AttemptedTopic();
                a.setAnswer(rs.getString("answer"));
                a.setQuestion(rs.getString("question"));
                list.add(a);
            }
            rs.close();
            ps.close();
            conn.close();
        }
        catch(Exception e){
            System.out.println("error is in correct ones " + e);
        }
        
        return list;
    }
    
}
