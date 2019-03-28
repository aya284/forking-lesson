<%-- 
    Document   : CheckNext
    Created on : Jul 20, 2018, 12:33:02 AM
    Author     : Shreyash Agrawal
--%>
<%@page import="sa.QuizQuestions, java.util.ListIterator"%>
<%  ListIterator<QuizQuestions> iterator = (ListIterator)session.getAttribute("iterator");
    if(iterator.hasNext()){
       QuizQuestions alldata = iterator.next();
       session.setAttribute("alldata", alldata);
      %>
      <jsp:forward page="DisplayQuestions.jsp"/>
<%
    }
    else{
        %>
        <jsp:forward page="LogInForMore.jsp"/>
<%
    }
%>