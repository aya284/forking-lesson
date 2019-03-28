<%-- 
    Document   : SubmitAnswer
    Created on : Jul 24, 2018, 1:39:00 PM
    Author     : Shreyash Agrawal
--%>

<%
    if(session.getAttribute("uname") == null && request.getSession(false) == null){
        session.setAttribute("flag", "false");
        %>
        <jsp:forward page="index.jsp"/>
<%
    }
%>

<%@page import = "sa.QuizSubmit, sa.QuizQuestions, sa.QuizReport"%>
<%  
    String option;
    if(request.getParameter("options") == null){
        option = "";
    }
    else{
        option = request.getParameter("options");
    }
    String uname = (String)session.getAttribute("uname");
    QuizQuestions quiz = (QuizQuestions)session.getAttribute("alldata");
    
    int check = QuizSubmit.checkAnswer(option, quiz.getAnswer());
    QuizReport report = (QuizReport)session.getAttribute("report");
    if(check == 0){
        report.unattempted_increment();
    }
    else if(check == 1){
        report.attempted_increment();
        report.correct_increment();
    }
    else if(check == -1){
        report.attempted_increment();
        report.wrong_increment();
    }
    else{
        System.out.println("error in submitanswer quizreport");
    }
        
    int flag = QuizSubmit.submitAnswerForThisUser(uname, quiz.getId(), option, quiz.getAnswer());
    //System.out.println("Question id " + quiz.getId());
    if(flag > 0){
        
%>
        <jsp:forward page="NextPage.jsp"/>
<%
    }
    else{
        out.print("error in submitAnswer.jsp - submitAnswerfor this user");
    }
%>