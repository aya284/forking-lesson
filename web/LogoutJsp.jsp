<%-- 
    Document   : LogoutJsp
    Created on : Jul 19, 2018, 10:00:17 PM
    Author     : Shreyash Agrawal
--%>

<%
session.removeAttribute("uname");
session.invalidate();

%>

<script>
    alert("You are successfully logged out");
</script>
<jsp:include page="index.jsp"/>
