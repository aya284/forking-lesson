<%-- 
    Document   : LoginJsp
    Created on : Jul 12, 2018, 2:02:15 PM
    Author     : Shreyash Agrawal
--%>

<%@page import="sa.QuizTotalDataOnly"%>
<%@page import="sa.QuizDisplay"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    if(session.getAttribute("uname") == null && request.getSession(false) == null){
        
        session.setAttribute("flag", "false");
        %>
        <jsp:forward page="index.jsp"/>
        
<%
    }
    
if(session.getAttribute("iterator") != null)
        session.removeAttribute("iterator");
if(session.getAttribute("alldata") != null)
        session.removeAttribute("alldata");
if(session.getAttribute("report") != null)
        session.removeAttribute("report");
    
String uname = (String)session.getAttribute("uname");
QuizTotalDataOnly data = QuizDisplay.getOnlyTotalQuizData(uname);

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home | User</title>
        <link rel="stylesheet" href="css/other2.css"/>
    </head>
    <body>
        <jsp:include page="header_NoLogIn.html"/>
        
        <div class="box">
            <h2>Welcome <%out.print(uname);%></h2>
            <table>
                <tr >
                    <th colspan = "2" style = "padding-bottom: 25px; padding-left: 155px; text-align: center;">
                        Your Total Stats till date
                    </th>
                </tr>
                <tr>
                    <th>
                        Total Questions Attempted till date:
                    </th>
                    <td>
                        <%out.print(data.getTotal_attempted());%>
                    </td>
                </tr>
                
                <tr>
                    <th>
                        Total Questions Answered Correctly:
                    </th>
                    <td style="color: green;">
                        <%out.print(data.getTotal_correct());%>
                    </td>
                </tr>
                <tr>
                    <th>
                        Total Questions Answered Incorrectly:
                    </th>
                    <td style="color: red;">
                        <%out.print(data.getTotal_incorrect());%>
                    </td>
                </tr>
                <tr>
                    <th>
                        Accuracy so far:
                    </th>
                    <td>
                        <% try{
                            out.print( (float)( (data.getTotal_correct()* 100)/(data.getTotal_correct() + data.getTotal_incorrect()) ) + "%");
                        }
                        catch(ArithmeticException e){
                            out.print("You have not yet attempted any question.");
                        }
                        %>
                    </td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <th>
                        
                    </th>
                </tr>
                
                <tr>
                    <th colspan="2" style="padding-right: 20px; padding-top: 10px;">
                        <%out.print(data.getTotal_unattempted());%> new Questions remaining!
                    </th>

                </tr>
            </table>
        </div>
        
        <jsp:include page="footer.html"/>
    </body>
</html>
