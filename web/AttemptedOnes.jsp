<%-- 
    Document   : AttemptedOnes
    Created on : Aug 2, 2018, 1:44:44 PM
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

<%@page import="sa.QuizDisplay, java.util.List, sa.AttemptedTopic"%>

<%
    String uname = (String)session.getAttribute("uname");
    String topic = request.getParameter("topic");
    List<AttemptedTopic> list1 = QuizDisplay.correctOnes(uname, topic);
    List<AttemptedTopic> list2 = QuizDisplay.wrongOnes(uname, topic);
    
    if(list1.isEmpty() && list2.isEmpty()){
        %>
        <script>
            alert("please attempt questions in this topic first");
        </script>
        <jsp:include page="ProfileJsp.jsp"/>

<%
    }
    else{
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="css/block3.css"/>
    </head>
    <body>
        <jsp:include page="header_NoLogIn.html"/>
        
        <div class="block3">
            
            <h2>All <%=topic%> Questions that you have attempted</h2>   
            <br><br>
            
            <div class="correct">
                <table >
                    <tr>
                        <th>
                            S. No.
                        </th>
                        <th>
                            Questions
                        </th>
                        <th>
                            Answers
                        </th>
                    </tr>
                    <%  int sno = 1;
                    
                        if(!list1.isEmpty()){                            
                            for(AttemptedTopic all : list1){
                            %>

                            <tr>
                                <td class="center">
                                    <%=sno%>.
                                </td>

                                <td class="que">
                                    <%=all.getQuestion()%>
                                </td>

                                <td class="center">
                                    <%=all.getAnswer()%>
                                </td>
                            </tr>

                    <%
                            sno++;
                        }
                            
                    }
                        else{
                            %>
                            <tr>
                                <td colspan="3" class="center">EMPTY</td>
                            </tr>
                                <%
                        }
                    %>
                </table>
            </div>
            
            <div class="wrong">
                <table >
                    <tr>
                        <th>
                            S. No.
                        </th>
                        <th>
                            Questions
                        </th>
                        <th>
                            Answers
                        </th>
                    </tr>
                    <%  if(!list2.isEmpty()){
                            sno = 1;
                            for(AttemptedTopic all : list2){
                            %>

                                <tr>
                                    <td class="center">
                                        <%=sno%>.
                                    </td>

                                    <td class="que">
                                        <%=all.getQuestion()%>
                                    </td>

                                    <td class="center">
                                        <%=all.getAnswer()%>
                                    </td>
                                </tr>

                        <%
                                sno++;
                            }
                        }    
                        else{
                            %>
                            <tr>
                                <td colspan="3" class="center">EMPTY</td>
                            </tr>
                                <%
                        }
                       %>
                </table>
            </div>   
            
            <div class="whitespace"></div>    
                
        </div>
                
        
        
        <jsp:include page="footer.html"/>
    </body>
</html>

<%}%>