<%-- 
    Document   : EditUserName
    Created on : Jul 15, 2018, 8:20:18 PM
    Author     : Shreyash Agrawal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="sa.UsersCrude"%>


<%
    String uname = (String)session.getAttribute("uname");
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit UserName</title>
    </head>
    <body>
        <jsp:include page="header_NoLogIn.html"/>
        
        <h1>Change your UserName</h1><br><br>
        <form action="EditUserName2.jsp" method="post">
            <table>
                <tr>
                    <th>
                        UserName:
                    </th>
                    <td>
                        <input type="text" name="uname" value="<%out.print(uname);%>">
                    </td>
                </tr> 
                <tr>
                    <td colspan="2">
                        <input type="submit" value="OK">
                    </td>
                </tr>
            </table>
        </form>
        <jsp:include page="footer.html"/>
    </body>
</html>
