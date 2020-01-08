<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Profile</title>
    </head>
    
    <body>
        <%
            User user = db.getUserDetails(session.getAttribute("uname").toString());
            if(user.getType().equals("teacher")){
        %>
        
        <div class="sidebar">
            <h3>Online Examination System</h3>
            <img src="images/logo.png" width="80" height="80" alt="OES"/>
            <a class ="active" href="tchr-page.jsp?pgprt=0">Profile</a>
            <a href="tchr-page.jsp?pgprt=1">Classes</a>
            <a href="tchr-page.jsp?pgprt=2">Tests</a>
            <a href="tchr-page.jsp?pgprt=3">Questions</a>
            <a class="logout" href="index.jsp">Logout</a>
        </div>
        <%
            }
            else{
        %>
        
        <div class="sidebar">
            <h3>Online Examination System</h3>
            <img src="images/logo.png" width="80" height="80" alt="OES"/>
            <a class ="active" href="std-page.jsp?pgprt=0">Profile</a>
            <a href="std-page.jsp?pgprt=1">Exams</a>
            <a href="std-page.jsp?pgprt=2">Results</a>
            <a class="logout" href="index.jsp">Logout</a>
        </div>       
        <%
            }
            if(request.getParameter("pedt") == null){
        %>
        
        <div class="profile-box">
            <div class="title">Profile</div>
            <table>
                <tr>
                    <th>Username</th>
                    <td><%=user.getUsername()%></td>
                </tr>

                <tr>
                    <th>Your name</th>
                    <td><%=user.getFirst_name()+ " " +user.getLast_name()%></td>
                </tr>

                <tr>
                    <th>Email</th>
                    <td><%=user.getEmail()%></td>
                </tr>
                
            </table>
                
            <%
                if(user.getType().equals("teacher")){
            %>
            <a class="edit-btn" href="tchr-page.jsp?pgprt=0&pedt=1">Edit profile</a>
            <%
                }
                else{
            %>
                <a class="edit-btn" href="std-page.jsp?pgprt=0&pedt=1">Edit profile</a>
            <%
                }
            %>
        </div>
        <%
            }else{
        %>
            
            <div class="edit-box">
                <div class="edit-title">Edit Profile</div>
                <form action="controller" method="POST">
                    <input type="hidden" name="page" value="profile">
                    <input type="hidden" name="utype" value="<%=user.getType()%>">
                    <input type="hidden" name="uid" value="<%=user.getUser_id()%>">
                    <table class="edit-table">
                        <tr>
                            <td>
                                <label>Username</label>
                            </td>
                            <td>
                                <input class="text" type="text" name="username" value="<%=user.getUsername()%>" placeholder="Username">
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <label>First name</label>
                            </td>
                            <td>
                                <input class="text" type="text" name="first-name" value="<%=user.getFirst_name()%>" placeholder="First Name">
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <label>Last name</label>
                            </td>
                            <td>
                                <input class="text" type="text" name="last-name" value="<%=user.getLast_name()%>" placeholder="Last Name">
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <label>Email</label>
                            </td>
                            <td>
                                <input class="text" type="email" name="email" value="<%=user.getEmail()%>" placeholder="Email">
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <label>Password</label>
                            </td>
                            <td>
                                <input class="text" type="password" name="password1" value="<%=user.getPassword()%>" placeholder="Password">
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <label>Confrim Password</label>
                            </td>
                            <td>
                                <input class="text" type="password" name="password2" value="<%=user.getPassword()%>" placeholder="Password">
                            </td>
                        </tr>
                    </table>
                    <input class="btn" type="submit" name="submit" value="Done">
                </form>
            </div>
        <%
            }
        %>
    </body>
</html>
