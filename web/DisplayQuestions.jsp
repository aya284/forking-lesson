<%-- 
    Document   : DisplayQuestions
    Created on : Jul 18, 2018, 10:36:02 PM
    Author     : Shreyash Agrawal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="sa.QuizQuestions, java.util.ListIterator"%>
<%
    QuizQuestions alldata = (QuizQuestions)session.getAttribute("alldata");
    String options[] = alldata.getOptions();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Page</title>
        <script src="js/answerselect.js" type="text/javascript"></script>
        <script type="text/javascript">
            var timer_time;
            var ans = "<%=alldata.getAnswer()%>";
            function timer(){
                var time_left = 30;
                var space = document.getElementById('space');
                
                this.timer_time = setInterval(countdown, 1000);
                function countdown(){
                    if(time_left === -1){
                        clearTimeout(timer_time);
                        document.getElementById('optiontable').innerHTML = '<strong style="font-size: 19px;"> Answer: <u>' + this.ans + '</u></strong>';
                        var flag = true;
                        setInterval(function blink(){
                            if(flag === true){
                            document.getElementById('space').style.color = "#444";
                            flag = false;
                            }
                            else{
                            document.getElementById('space').style.color = "white";
                            flag = true;

                            }
                        } , 1000);
                    }
                    else{
                        space.innerHTML = "0:" + time_left + " sec left";
                        time_left--;
                    }
                }
            }
            
            function answer(){
                clearTimeout(this.timer_time);
        
                var answer = this.ans;
                var options = [];
                
                for(var i = 1; i < 5; i++)
                    document.getElementById("option" + i).disabled = true;
                
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
                
                if(("option" + no) === option.id){
                    document.getElementById("mark"+no).style.backgroundColor = "green";
                }
                else{
                    document.getElementById("mark"+no).style.backgroundColor = "green";
                    document.getElementById("mark"+idno).style.backgroundColor = "red";
                }
                
                
            }    
        </script>
        <link rel="stylesheet" type="text/css" href="css/quizpage2.css"/>
    </head>
    <body onload="timer()">
        <jsp:include page="header_LogIn.html"/>
        
        <div class="content">
            <div id="space" >
            </div>
            <div class="whitespace"></div>

            <div class="question">
                <h2>Q.) <%out.print(alldata.getQuestion());%></h2>
            </div>
             <div id="optiontable">
                <table cellpadding="10">
                    <tr>
                        <td id="mark1">
                            <input type="radio" name="options" id="option1" onclick="selectit(this)" value="<%out.print(options[0]);%>">
                            <label for="option1">a.) <%out.print(options[0]);%></label>
                            
                        </td>
                        <td class="space"></td>
                        <td id="mark2" >
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
                            <button onclick="answer()">Submit</button>
                        </td> 
                    </tr>
                </table>    

            </div>
            <div style="float: right; padding-right: 10px; padding-bottom: 10px;">
                    <form action="CheckNext.jsp" method="post">
                       <input type="submit" value="Next"/>
                     </form>
             </div>
            <div class="whitespace"></div>
        </div>
        
        <jsp:include page="footer.html"/>
    </body>
</html>
