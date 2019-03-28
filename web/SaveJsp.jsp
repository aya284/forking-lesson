<%-- 
    Document   : SaveJsp
    Created on : Jul 12, 2018, 1:58:50 PM
    Author     : Shreyash Agrawal
--%>

<%@page import = "sa.UsersCrude, sa.UsersAccess"%>

<jsp:useBean id="user" class="sa.UsersInfo">
    <jsp:setProperty name="user" property="*"/>
</jsp:useBean>    

<%
    boolean flag = UsersAccess.uniqueUnameCheck(user.getUname());
    //System.out.println("password " + user.getPassword() + "username " + user.getUname() + "email  " + user.getEmail() + "gender " + user.getGender() + "country " + user.getCountry());
    if(flag){
        int check = UsersCrude.saveUser(user);
            if(check > 0){
           %>
           <script>
               alert("Successfully Saved!");
           </script>
                <jsp:include page="index.jsp"/>
<%
            }
            else{
                    
            %>
            <script>
                alert("Failure!");
            </script>
            <jsp:include page="index.jsp"/>
<%
            }
    }
    
    else{
        %>
        <script>
            alert("please select a unique username");
        </script>
        <jsp:include page="index.jsp"/>
<%
    }
%>