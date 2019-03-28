<%-- 
    Document   : EditUserName2
    Created on : Jul 15, 2018, 9:12:21 PM
    Author     : Shreyash Agrawal
--%>

<%@page import = "sa.UsersCrude, sa.UsersAccess"%>

<%  
    String newuname = request.getParameter("uname");
    boolean checks = UsersAccess.uniqueUnameCheck(newuname);

    if(!checks){
       %>
       
       <script>
            alert("Please select a Unique UserName");
        
            <jsp:include page="EditUserName.jsp"/>
        
       </script>   
       
<% 
    }
    
    else{
        String olduname = (String)session.getAttribute("uname");
        int check = UsersCrude.changeUname(olduname, newuname);
        if(check > 0){
            session.setAttribute("uname", newuname);
%>

        <script>
            alert("UserName successfully changed!");
        </script>
        <jsp:include page="ProfileJsp.jsp"/>
<%
    }
    
    else{
         System.out.println("not in if statement");
%>
        <script>
            alert("UserName could not be changed!");
        </script>
        <jsp:include page="EditUserName.jsp"/>
<%
    }
 }           
%>
