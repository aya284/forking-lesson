<%-- 
    Document   : index
    Created on : Jul 19, 2018, 10:14:01 PM
    Author     : Shreyash Agrawal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
    if(session.getAttribute("flag") != null){
        if(((String)session.getAttribute("flag")).equals("false")){
            %>
            <script>
                alert('Log In First Please');
            </script>
            <%      session.removeAttribute("flag");
        }
    }     
    if(session.getAttribute("alldata") != null){
        session.removeAttribute("alldata");
    }
    
    if(session.getAttribute("iterator") != null)
        session.removeAttribute("iterator");
   
%>

	<title>HomePage</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

	<header>
		<div class="firstHeader">
			<h1>Quiz Trivia</h1>
		</div>

		<div class="secondHeader">
						
		</div>

		<div class="thirdHeader"> 
			<form action="LoginCheck.jsp" method="post">
			<table>
                            <tr><th colspan="2" style="color: white;"><h3>Login</h3></th></tr>
					
					<tr> 
						<td>
							UserName:
						</td>
						<td>
							<input type="text" name="uname" placeholder="Type your UserName here" required>
						</td>
					</tr>

					<tr>
						<td>
							Password:
						</td>
						<td>
							<input type="password" name="password" placeholder="Type your Password here" required>
						</td>
					</tr>

					<tr>
						<td colspan="2" style="text-align: center;"> 
							<input class ="button" type="submit" value="OK">
						</td>
					</tr>
				</table>
                        </form>
			
		</div>

		<div class="whitespace">
			
		</div>

		<nav>
			<div class="mainmenu">
				<a href="index.jsp"> Home</a>
				<div class="hovermenu">
					<a href="">Topics <strong>v</strong></a>
						<div class="hovercontent">
							<a href="CheckLogInForQuestions.jsp?topic=gk">G.K.</a>
							<a href="CheckLogInForQuestions.jsp?topic=science">Science</a>
                                                        <a href="CheckLogInForQuestions.jsp?topic=technology">Technology</a>
                                                        <a href="CheckLogInForQuestions.jsp?topic=space" >Space</a>
							<a href="CheckLogInForQuestions.jsp?topic=c">C</a>
                                                        <a href="CheckLogInForQuestions.jsp?topic=c++">C++</a>
                                                        <a href="CheckLogInForQuestions.jsp?topic=java">Java</a>
                                                        
                                                        <a href="CheckLogInForQuestions.jsp?topic=python">Python</a>
                                                        <a href="CheckLogInForQuestions.jsp?topic=html">HTML</a>
                                                        <a href="CheckLogInForQuestions.jsp?topic=javascript">JavaScript</a>
                                                        
						</div>
				</div>
                                <a href="CheckLogInForQuestions.jsp?topic=random">Quick Test</a>
			</div>
		</nav>

	</header>
	<div class="form">
		
		<h2>Register Now!</h2><br>

		<form action="SaveJsp.jsp" method="post">
			
			<table>

				<tr>
						<td>
							Email:
						</td>

						<td>
							<input type="email" name="email" required>
						</td>

				</tr>

				<tr>
					<td>
						UserName:
					</td>
					<td>
						<input type="text" name="uname" placeholder="Create a Unique UserName" required>
					</td>
				</tr>

				<tr>
					<td>
						Password:
					</td>
					<td>
						<input type="password" name="password" required>
					</td>
				</tr>

				<tr>
					<td>
						Gender:
					</td>
					<td style="text-align: left;">
                                                <input type="radio" name="gender" value="Male" id="1"/>
                                                <label for="1">Male</label>
						<br>
                                                <input type="radio" name="gender" value="Female" id="2">
                                                <label for="2">Female</label>
						<br>
                                                <input type="radio" name="gender" value="other" id="3">
                                                <label for="3">other</label>

					</td>
				</tr>
				<tr>
					<td>
						Country:
					</td>
					<td style="text-align: left;">
						<select name = "country">
							<option>India</option>
							<option>U.S.A</option>
							<option>U.K.</option>

						</select>
					</td>
				</tr>
                                
                                <tr>
                                    <td>
                                        Date of Birth:
                                    </td>
                                    <td>
                                        <input type="date" name="dob" value="2000-01-01">
                                    </td>
                                </tr>

				<tr>
					<td colspan="2" style="text-align: center;">
						<input class="button" type="submit" value="Save" id="buttonlength">
					</td>
				</tr>
                                
                               

			</table>

		</form>

	</div>
    
	<div class="whitespace">
		
	</div>

       <div class="footer">
                    <p>
                        Copyright Shreyash Technologies Pvt. Ltd.
                    </p>

                <div class="right">
                    <a href="">Contact Us</a>	
                    <a href="">Report</a>
                </div>
        </div>
	
        
    <div class="whitespace">
        
    </div>

</body>
</html>