<%-- 
    Document   : LogInForMore
    Created on : Jul 19, 2018, 9:51:32 PM
    Author     : Shreyash Agrawal
--%>

<%session.removeAttribute("iterator");
  session.removeAttribute("alldata");
%>

<script>
    alert('Please Login For More Questions');
</script>

<jsp:include page="index.jsp"/>