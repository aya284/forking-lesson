<%-- 
    Document   : Report
    Created on : Jul 30, 2018, 10:16:51 AM
    Author     : Shreyash Agrawal
--%>

<%@page import="sa.QuizReport" %>
<%!int flag = 0;%>
<%
    if(session.getAttribute("iterator") != null)
        session.removeAttribute("iterator");
    if(session.getAttribute("alldata") != null)
        session.removeAttribute("alldata");
        
    QuizReport report = (QuizReport)session.getAttribute("report");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="css/block2.css"/>
    </head>
    <body>
        <jsp:include page="header_NoLogIn.html"/>
        
        <div class="box">
            <h1>Report</h1>
            <center>
            <table border="1" cellpadding="10">
                <tr>
                    <th rowspan="2">
                        No. of Questions Not Attempted
                    </th>
                    <th colspan="2">Attempted</th>
                </tr>
                <tr>
                    
                    <th>
                        No. of Correct Submissions
                    </th>
                    <th>
                        No. of Wrong Submissions
                    </th>
                </tr>
                <tr>
                    <th rowspan="2" style="font-size: 25px;">
                        <%=report.getUnattempted()%> 
                    </th>
                    <th style="color: green; font-size: 25px;">
                        <%=report.getCorrect()%>
                    </th>
                    <th style="color: red; font-size: 25px;">
                        <%=report.getWrong()%>
                    </th>
                </tr>
                <tr>
                    
                    <th colspan="2" style="font-size: 25px;">
                        <%=report.getAttempted()%>
                    </th>
                </tr>
            </table>
            </center>
        </div>
        <div class="whitespace"></div>
        <br><br><br>
        
        <jsp:include page="footer.html"/>
    </body>
</html>

<%session.removeAttribute("report");%>
