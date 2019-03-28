<%-- 
    Document   : ProfileJsp
    Created on : Jul 13, 2018, 3:58:43 PM
    Author     : Shreyash Agrawal
--%>
<%@page import="sa.QuizSubjData, sa.UsersCrude, sa.QuizDisplay, java.util.*"%>



<jsp:useBean id="totaldata" class="sa.QuizTotalDataOnly"/>
<jsp:useBean id="user" class="sa.UsersInfo"/>

<%
    if(session.getAttribute("uname") == null && request.getSession(false) == null){
        
        session.setAttribute("flag", "false");
        %>
        <jsp:forward page="index.jsp"/>
        
<%
    }
    String uname = (String)session.getAttribute("uname");
    Map <String, QuizSubjData> map = QuizDisplay.getOnlySubjQuizData(uname);
    totaldata = QuizDisplay.getOnlyTotalQuizData(uname);
    user = UsersCrude.getUserByUName(uname);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/other.css">
        <style>
            .box{
                margin-left: 50%;
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header_NoLogIn.html"/>
        
        <div class = "content">
            <h2>This is your Profile, <%out.print(uname);%></h2>
            
            <div class="profile">
                <br><br>
                <table>
                    <tr>
                        <th colspan="2" style="text-align: center; font-size: 21px;">
                            Details
                        </th>
                    </tr>
                    <tr>
                        <th>
                            E-Mail:
                        </th>
                        <td>
                            <%out.print(user.getEmail());%>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            UserName:
                        </th>
                        <td>
                            <%out.print(user.getUname());%> <span style="padding-left: 5px;"></span>
                            <a href="EditUserName.jsp"><img src="images/edit.png" width="25" height="25" alt="Edit Username"> </a>
                               
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Password:
                        </th>
                        <td>
                            <%out.print(user.getPassword());%>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Gender:
                        </th>
                        <td>
                            <%out.print(user.getGender());%>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Country
                        </th>
                        <td>
                            <%out.print(user.getCountry());%>
                        </td>
                    </tr>
                    
                    <tr>
                                    <td>
                                        Date of Birth:
                                    </td>
                                    <td>
                                        <%out.print(user.getDob());%>
                                    </td>
                    </tr>
                    
                    <tr>
                        <th colspan="2" style="padding-top: 10px;"><center>
                            <form action="EditJsp.jsp" method="post" >
                                <input type="submit" value="Edit Profile"/>
                            </form></center>
                        </th>
                    </tr>
                    <tr>
                        <th colspan="2" style="padding-top: 10px;">
                            <center>
                                <form action="DeleteJsp.jsp" method="post">
                                    <input type="submit" value="Delete Account" style="padding: 5px"/>
                                </form>
                            </center>
                        </th>
                    </tr>
                </table>
            </div>
            
            <div class="data">
                <br><br><table cellspacing="0" cellpadding="5">
                    <tr>
                        <th colspan="2" style="text-align: center; font-size: 21px;">
                            All Stats Description
                        </th>
                    </tr>
                    <%for(Map.Entry<String, QuizSubjData> entry: map.entrySet()){
                        
                        QuizSubjData data = entry.getValue();
                    %>
                        
                        <tr>
                            <th style="text-align: center;">
                                <%out.print(entry.getKey());%>
                            </th>
                            
                            <td>
                                <ul>
                                    <li><a href="AttemptedOnes.jsp?topic=<%=entry.getKey()%>">Click to see Attempted Questions</a></li>
                                    <li>
                                        Question Attempted:    <%out.print(data.getSubj_attempted());%>
                                    </li>
                                    <li>
                                        Questions Answered correctly:    <span style="color: green;"><%out.print(data.getSubj_corrected());%></span>
                                    </li>
                                    <li>
                                        Questions Answered incorrectly:    <span style="color: red;"><%out.print(data.getSubj_incorrect());%></span>
                                    </li>
                                    <li>
                                        Your Progress in this Topic:   <%
                                        try{
                                            out.print(((float)(data.getSubj_attempted() * 100)/(data.getSubj_attempted() + data.getSubj_unattempted())) + "%");
                                        }
                                        catch(Exception e){
                                            out.print("You have not yet attempted any question");
                                        }%>
                                    </li>
                                    <li>
                                        Your Accuracy in this Topic: <%
                                        try{
                                            out.print(((float)(data.getSubj_corrected() * 100)/ (data.getSubj_corrected() + data.getSubj_incorrect())) + "%");
                                        }
                                        catch(Exception e){
                                            out.print("You have not yet attempted any question");
                                        }%>
                                    </li>
                                    
                                    <li style="border: 1px solid black; list-style: none; margin-top: 20px; text-align: center; margin-right: 25px;">
                                        <a href="CheckLogInForQuestions.jsp?topic=<%=entry.getKey()%>">
                                            <%out.print(data.getSubj_unattempted());%> new Questions Remaining!
                                        </a>    
                                    </li>
                                </ul>                                    
                            </td>
                        </tr>
                        
                    <%}%>
                </table>
            </div>  
            <div class="whitespace">
            </div>          
        </div>
        
        
        
        <jsp:include page="footer.html"/>
    </body>
</html>
