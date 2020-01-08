<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.oes.dao.User" %>
<jsp:useBean id="db" class="com.oes.database.Database" scope="page"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="images/logo.png" type="image/logo" sizes="18x18">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="stylesheet" href="_css/sidebar.css">
        <link rel="stylesheet" href="_css/parts_styles.css">
        <title>Classes</title>
    </head>
    <body>
        
        <div class="sidebar">
            <h3>Online Examination System</h3>
            <img src="images/logo.png" width="80" height="80" alt="OES"/>
            <a href="tchr-page.jsp?pgprt=0">Profile</a>
            <a class ="active" href="tchr-page.jsp?pgprt=1">Classes</a>
            <a href="tchr-page.jsp?pgprt=2">Tests</a>
            <a href="tchr-page.jsp?pgprt=3">Questions</a>
            <a class="logout" href="index.jsp">Logout</a>
        </div>
        
        <%
            User user = db.getUserDetails(session.getAttribute("uname").toString());
            ArrayList list = db.getAllClasses(user.getUser_id());
        %>
        <div class="class-box1">
            <form action="controller" method="POST">
                <input type="hidden" name="page" value="classes">
                <input type="hidden" name="operation" value="del">
                <table class="all-classes">
                    <div class="class-title">All Classes</div>
                    <tr>
                        <th class="col">Classes</th>
                        <th class="col">Action</th>
                    </tr>
                    <%
                        for(int i=0; i<list.size(); i++){
                    %>
                    <tr>
                        <td><%=list.get(i)%></td>
                        <td><button class="del-btn" type="submit" name="cname" title="Delete Class" value="<%=list.get(i)%>">X</button></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </form>
        </div>
                
        <div class="class-box2">
            <form action="controller" method="POST">
                <input type="hidden" name="page" value="classes">
                <input type="hidden" name="operation" value="add">
                <div class="title">Add new class</div>
                <table class="new-class">
                    <tr><td><input class="in" type="text" name="new_class" placeholder="Class name"></td></tr>
                    <tr><td><input class="add-btn" type="submit" name="add-btn" value="Add"></td></tr>
                </table>
            </form>
        </div>
    </body>
</html>
