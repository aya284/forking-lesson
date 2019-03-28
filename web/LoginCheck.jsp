<%-- 
    Document   : LoginCheck.jsp
    Created on : Jul 12, 2018, 11:09:36 PM
    Author     : Shreyash Agrawal
--%>

<%@page import="sa.UsersAccess"%>

<%
    String uname = request.getParameter("uname");
    String password = request.getParameter("password");

    boolean check = UsersAccess.getLoginUser(uname, password);
    
    if (check){
        session.setAttribute("uname", uname);
        
        response.sendRedirect("LoginJsp.jsp");
    }
    else{
    
        %>
        <script>
            alert("Incorrect UserName or Password");
        </script>
        <jsp:include page="index.jsp"/>
        
        <%
}
%>
