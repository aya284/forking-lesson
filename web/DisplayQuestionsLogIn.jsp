<%-- 
    Document   : DisplayQuestionsLogIn
    Created on : Jul 19, 2018, 8:41:09 PM
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

<%! int flag = 0;%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="sa.QuizQuestions, java.util.ListIterator"%>

<%
    if(flag == 0){
        flag++;
%>
        <script>
            alert("Instructions: Click SUBMIT to save your final chosen answer and then NEXT to finally submit it, if not they will not be saved");
        </script>
<%
    }
    
    QuizQuestions alldata = (QuizQuestions)session.getAttribute("alldata");
    String options[] = alldata.getOptions();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Page</title>
        
        <link rel="stylesheet" type="text/css" href="css/quizpage.css"/>
    </head>
    <body onload="timer()">
        <jsp:include page="header_NoLogIn.html"/>
        
        <div class="content">
            <div class="left" style="float:left;">
                <form action="Report.jsp" method="post">
                    <input type="submit" value="Exit"/>
                </form>
            </div>
            <div id="space" >
            </div>
            <div class="whitespace"></div>

            <div class="question">
                <h2>Q.) <%out.print(alldata.getQuestion());%></h2>
            </div>
            <div style="clear: left;"></div>
            <form action="SubmitAnswer.jsp" method="post">
                <div id="optiontable" style="padding-left: 20px;">
                       <table cellpadding="10">
                           <tr>
                               <td id="mark1">
                                   <input type="radio" name="options" id="option1" onclick="selectit(this)" value="<%out.print(options[0]);%>">
                                   <label for="option1">a.) <%out.print(options[0]);%></label>

                               </td>
                               <td class="space"></td>
                               <td id="mark2">
                                   <input type="radio" name="options" id="option2" onclick="selectit(this)" value="<%out.print(options[1]);%>">
                                   <label for="option2">b.) <%out.print(options[1]);%></label>
                               </td>
                           </tr>
                          
                           <tr>
                               <td id="mark3" >
                                   <input type="radio" name="options" id="option3" onclick="selectit(this)" value="<%out.print(options[2]);%>">
                                   <label for="option3">c.) <%out.print(options[2]);%></label>
                               </td>
                               <td class="space"></td>
                               <td id="mark4">
                                   <input type="radio" name="options" id="option4" onclick="selectit(this)" value="<%out.print(options[3]);%>">
                                   <label for="option4">d.) <%out.print(options[3]);%></label>
                               </td>
                           </tr>
                           
                           <tr>
                               <td colspan = '2' align = 'left'>
                                   <button type = "button" onclick="answer()">Submit</button>
                               </td> 
                           </tr>
                       </table>    

                   </div>
                <div style="float: right; padding-right: 10px; padding-bottom: 10px;">

                           <input type="submit" value="Next"/>
                </div>
             </form>
            <div class="whitespace"></div>
        </div>
        
                               
        <script src="js/answerselect.js" type="text/javascript"></script>
        <script src="js/timer.js" type="text/javascript"></script>
                                       
        <script type="text/javascript">
            
            function answer(){
                clearTimeout(this.timer_time);
        
                var answer = "<%=alldata.getAnswer()%>";
                var options = [];
                
                options.push("<%=options[0]%>");
                options.push("<%=options[1]%>");
                options.push("<%=options[2]%>");
                options.push("<%=options[3]%>");
                
                var option = this.optionselect;
                var idno = option.id[option.id.length - 1];
                var no;
                for(var i=1; i<5; i++)
                    if(answer == options[i-1])
                       no = i; 
                
                for(var i = 1; i < 5; i++)
                    if(i != idno)
                        document.getElementById("option" + i).disabled = true;
                
                if(("option" + no) == option.id){
                    document.getElementById("mark"+no).style.backgroundColor = "green";
                }
                else{
                    document.getElementById("mark"+no).style.backgroundColor = "green";
                    document.getElementById("mark"+idno).style.backgroundColor = "red";
                }
                
                
            }    
        </script>
        
        <jsp:include page="footer.html"/>
    </body>
</html>
