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
        <title>Tests</title>
    </head>
    <body>
        <div class="sidebar">
            <h3>Online Examination System</h3>
            <img src="images/logo.png" width="80" height="80" alt="OES"/>
            <a href="tchr-page.jsp?pgprt=0">Profile</a>
            <a href="tchr-page.jsp?pgprt=1">Classes</a>
            <a class ="active" href="tchr-page.jsp?pgprt=2">Tests</a>
            <a href="tchr-page.jsp?pgprt=3">Questions</a>
            <a class="logout" href="index.jsp">Logout</a>
        </div>
        
        <%
            User user = db.getUserDetails(session.getAttribute("uname").toString());
            ArrayList list = db.getAllClasses(user.getUser_id());
        %>
        
        <div class="test-box1">
            <form action="controller" method="POST">
                <input type="hidden" name="page" value="tests">
                <input type="hidden" name="operation" value="add">
                <table class="test-table">
                    <div class="test-title">Add test</div>
                    <tr>
                        <td>
                            <label>Select Class</label>
                            <select class="in" name="class_name">
                                <%
                                    for(int i=0; i<list.size(); i++){
                                %>
                                <option value="<%=list.get(i)%>"><%=list.get(i)%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><input class="in" type="text" name="test_name" placeholder="Test name"></td>
                    </tr>
                    <tr>
                        <td>
                            <input class="in" type="text" name="test_time" placeholder="Test duration (minuets)">
                        </td>
                    </tr>
                    <tr>
                        <td><input class="test-btn" type="submit" name="add_test" value="Add test"></td>
                    </tr>
                </table>
            </form>
        </div>
                            
        <%
            ArrayList list2 = db.getAllTests(user.getUser_id());
        %>
        <div class="test-box2">
            <form action="controller" method="POST">
                <input type="hidden" name="page" value="tests">
                <input type="hidden" name="operation" value="del">

                <table class="all-tests">
                    <div class="test-title">All tests</div>
                    <tr>
                        <th class="col">Test Name</th>
                        <th class="col">Duration</th>
                        <th class="col">Class</th>
                        <th class="col">Action</th>
                    </tr>
                    <%
                        for(int i=0; i<list2.size(); i = i + 3){
                    %>
                    <tr>
                        <td><%=list2.get(i)%></td>
                        <td><%=list2.get(i+1)%>m</td>
                        <td><%=db.getClassNameById(Integer.parseInt(list2.get(i+2).toString()))%></td>
                        <td>
                            <button class="del-btn" type="submit" name="tname" title="Delete test" value="<%=list2.get(i)%>">X</button>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </form>
        </div>
    </body>
</html>
