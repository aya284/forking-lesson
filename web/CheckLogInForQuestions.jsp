<%-- 
    Document   : CheckLogIn
    Created on : Jul 18, 2018, 10:37:06 PM
    Author     : Shreyash Agrawal
--%>
<%@page import="sa.QuizQuestions, sa.QuizDisplay, java.util.List, java.util.ListIterator, sa.QuizReport" %>
<%
    String topic = request.getParameter("topic");
    List<QuizQuestions> list;
    ListIterator<QuizQuestions> iterator;
    
    if(request.getSession(false) != null && session.getAttribute("uname") != null){
        String uname = (String)session.getAttribute("uname");
        QuizReport report = new QuizReport();
        
        if(topic.equals("random")){
            list = QuizDisplay.getQuestionsRandomly(uname);
        }
        else{
            list = QuizDisplay.getQuestionsByTopic(uname, topic);
        }
            
        iterator = list.listIterator();
        session.setAttribute("report", report);
        session.setAttribute("iterator", iterator);
            
%>
    <jsp:forward page="NextPage.jsp"/>
<%
    }
    
    else{
        if(topic.equals("random")){
            list = QuizDisplay.get5QuestionsRandomly();
        }
        else{
            list = QuizDisplay.get5QuestionsByTopic(topic);
        }
        
        iterator = list.listIterator();
        QuizQuestions alldata = iterator.next();
        session.setAttribute("alldata", alldata);
        session.setAttribute("iterator", iterator);
           
            
%>
        
        <jsp:forward page="CheckNext.jsp"/>
<%
    } 
%>