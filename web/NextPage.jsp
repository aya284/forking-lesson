<%-- 
    Document   : NextPage
    Created on : Jul 24, 2018, 1:36:21 PM
    Author     : Shreyash Agrawal
--%>

<%@page import="sa.QuizQuestions, java.util.ListIterator"%>
<%  ListIterator<QuizQuestions> iterator = (ListIterator)session.getAttribute("iterator");
    if(iterator.hasNext()){
       QuizQuestions alldata = iterator.next();
       session.setAttribute("alldata", alldata);
      %>
      <jsp:forward page="DisplayQuestionsLogIn.jsp"/>
<%
    }
    else{
        %>
        <jsp:forward page="MoreNextTime.jsp"/>
<%
    }
%>