<%-- 
    Document   : EditJsp
    Created on : Jul 13, 2018, 12:14:29 PM
    Author     : Shreyash Agrawal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page import = "sa.*" %>

<%
    if(session.getAttribute("uname") == null && request.getSession(false) == null){
        
        session.setAttribute("flag", "false");
        %>
        <jsp:forward page="index.jsp"/>
<%
    }

    String uname = (String)session.getAttribute("uname");
    UsersInfo users = UsersCrude.getUserByUName(uname);   
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/other.css">
        <link rel="stylesheet" href="css/block.css">
        
        
    </head>
    <body>
        
        <div class="content">
        <form name ="updateform" action="UpdateJsp.jsp" method = "post" >
            
           <table>
		
               <tr>
					<td>
						UserName:
					</td>
					<td>
                                            <input type="text" name="uname" value = "<%out.print(users.getUname());%>" readonly>
					</td>
				</tr>

               
               <tr>
						<td>
							Email:
						</td>

						<td>
                                                    <input type="email" name="email" value = "<%out.print(users.getEmail());%>">
                                                        
						</td>

				</tr>
				
				<tr>
					<td>
						Password:
					</td>
					<td>
						<input type="password" name="password" value = "<%out.print(users.getPassword());%>">
					</td>
				</tr>

				<tr>
					<td>
						Gender:
					</td>
					<td>
						<input type="text" name="gender" value = "<%out.print(users.getGender());%>">
						
					</td>
				</tr>
				<tr>
					<td>
						Country:
					</td>
					<td >
						<input type="text" name="country" value = "<%out.print(users.getCountry());%>">
						
					</td>
				</tr>
                                
                                <tr>
                                    <td>
                                        Date of Birth:
                                    </td>
                                    <td>
                                        <input type="text" name="dob" value="<%out.print(users.getDob());%>">
                                    </td>
                                </tr>

				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="submit" value="Save" id="buttonlength">
					</td>
				</tr>

			</table>
            
        </form>
        </div>
    </body>
</html>
