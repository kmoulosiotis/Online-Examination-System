
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="images/logo.png" type="image/logo" sizes="18x18">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="_css/sidebar.css">
    </head>
    
    <body>
        <div class="right-side">
            <div class="top-bar">
                <h2>Teacher's Panel</h2>
            </div>
        </div>
        <%
            if (request.getParameter("pgprt").equals("1")){
        %>
                <jsp:include page="classes.jsp"/>
        <%  }
            else if(request.getParameter("pgprt").equals("2")){
        %>
                <jsp:include page="tests.jsp"/>
        <%
            }
            else if(request.getParameter("pgprt").equals("3")){
        %>
                <jsp:include page="questions.jsp"/>
        <%
            }
            else{
        %>
                <jsp:include page="profile.jsp"/>
        <%
            }
        %>
        

    </body>
</html>
