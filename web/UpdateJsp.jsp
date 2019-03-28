<%-- 
    Document   : UpdateJsp
    Created on : Jul 12, 2018, 2:02:44 PM
    Author     : Shreyash Agrawal
--%>

<%@page import="sa.UsersCrude"%>
<jsp:useBean id="user" class="sa.UsersInfo">
    <jsp:setProperty name="user" property="*"/>
</jsp:useBean>
<%
    int check = UsersCrude.updateUser(user);
    
    if(check > 0){
        %>
        <script>
            alert("succesfully updated");
        </script>
        <jsp:include page="ProfileJsp.jsp"/>
<%
    }
    else{
        out.print("error in UpdateJsp.jsp");
    }
%>