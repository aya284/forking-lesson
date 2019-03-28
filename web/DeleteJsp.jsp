<%-- 
    Document   : DeleteJsp
    Created on : Jul 12, 2018, 2:03:04 PM
    Author     : Shreyash Agrawal
--%>

<%@page import="sa.UsersCrude" %>
<%
    String uname = (String)session.getAttribute("uname");
    
    int check = UsersCrude.deleteUser(uname);
    
    if(check > 0){
        session.removeAttribute("uname");
        session.invalidate();
        %>
        <script>
            alert("Successfully deleted account");
        </script>
        <jsp:include page="index.jsp"/>
<%
    }
    else{
        %>
        <script>
            alert("failure");
        </script>
        <jsp:include page="ProfileJsp.jsp"/>
<%
    }
%>