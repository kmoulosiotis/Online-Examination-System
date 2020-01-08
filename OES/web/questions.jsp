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
        <title>Questions</title>
    </head>
    <body>
        <div class="sidebar">
            <h3>Online Examination System</h3>
            <img src="images/logo.png" width="80" height="80" alt="OES"/>
            <a href="tchr-page.jsp?pgprt=0">Profile</a>
            <a href="tchr-page.jsp?pgprt=1">Classes</a>
            <a href="tchr-page.jsp?pgprt=2">Tests</a>
            <a class ="active" href="tchr-page.jsp?pgprt=3">Questions</a>
            <a class="logout" href="index.jsp">Logout</a>
        </div>
        
        <%
            User user = db.getUserDetails(session.getAttribute("uname").toString());
            ArrayList list = db.getAllClasses(user.getUser_id());
            ArrayList list2 = db.getAllTests(user.getUser_id());
        %>
        
        <%
            if(session.getAttribute("showall") == null){
        %>
                
        <div class="question-box1">
            <form action="controller" method="POST">
                <input type="hidden" name="page" value="questions">
                <input type="hidden" name="operation" value="add">
                <table class="q-table">
                    <div class="question-title">Add new question</div>
                    <%
                        if(session.getAttribute("op") != null){
                    %>
                        <td colspan="4">
                            <label>For <%=session.getAttribute("class_name")%> class select test:</label>
                            <select class="in" name="test_name">
                                <%
                                    for(int i=0; i<list2.size(); i = i + 3){

                                        if(list2.get(i+2).equals(db.getClassId2(session.getAttribute("class_name").toString(), user.getUser_id()))){

                                %>
                                <option value="<%=list2.get(i)%>"><%=list2.get(i)%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </td>
                        <tr>
                            <td colspan="4"><input type="text" class="q-text" name="question" placeholder="Type your question here"></td>
                        </tr>
                        <tr>
                            <td><input type="text" name="opt1" class="a-text" placeholder="First Option"></td>
                            <td><input type="text" name="opt2" class="a-text" placeholder="Second Option"></td>
                            <td><input type="text" name="opt3" class="a-text" placeholder="Third Option"></td>
                            <td><input type="text" name="opt4" class="a-text" placeholder="Fourth Option"></td>
                        </tr>
                        <tr>
                            <td colspan="4"><center><input type="text" name="correct" class="a-text" placeholder="Correct Answer"></center></td>
                        </tr>
                        <tr>
                            <td colspan="5"><center><input class="q-btn" type="submit" name="submit" value="Add question"></center></td>
                        </tr>
                        <tr>
                            <td colspan="5"><center><input class="b-btn" type="submit" name="submit" value="Back"></center></td>
                        </tr>
                        <%
                            }
                            else{
                        %>
                        <td>
                            <label>Select Class:</label>
                            <select class="in" name="class_name">
                                <%
                                    for(int i=0; i<list.size(); i++){
                                        //System.out.println(list.get(i));
                                %>
                                <option value="<%=list.get(i)%>"><%=list.get(i)%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                        <tr>
                            <td colspan="5"><center><input class="q-btn" type="submit" name="submit" value="Next"></center></td>
                        </tr>
                        <%
                            }
                        %>
                </table>
            </form>
        </div>

        <div class="question-box2">
            <form action="controller" method="POST">
                <input type="hidden" name="page" value="questions">
                <input type="hidden" name="operation" value="del">
                <table>
                    <div class="question-title">Show all questions</div>
                    <%
                        if(session.getAttribute("sh") == null){
                    %>
                    <tr>
                        <label><center>Select class</center></label>
                    </tr>
                    <tr>
                        <td>
                            <select class="in" name="c_name">
                                <%
                                    for(int i=0; i<list.size(); i++){
                                        //System.out.println(list.get(i));
                                %>
                                <option value="<%=list.get(i)%>"><%=list.get(i)%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><center><input class="s1-btn" type="submit" name="submit" value="Next"></center></td>
                    </tr>
                    <%
                        }
                        else{
                    %>                    
                    <tr>
                        <label><center>Select test for <%=session.getAttribute("c_name")%> class</center></label>
                    </tr>
                    <tr>
                        <td>
                            <select class="in" name="t_name">
                                <%
                                    for(int i=0; i<list2.size(); i = i + 3){

                                        if(list2.get(i+2).equals(db.getClassId2(session.getAttribute("c_name").toString(), user.getUser_id()))){

                                %>
                                <option value="<%=list2.get(i)%>"><%=list2.get(i)%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><center><input class="s1-btn" type="submit" name="submit" value="Show questions"></center></td>
                    </tr>
                    <tr>
                        <td><center><input class="b2-btn" type="submit" name="submit" value="Back"></center></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </form>
        </div>
        <%
            }
            else{
        %>
        
        <form action="controller" method="POST">
            <input type="hidden" name="page" value="questions">
            <input type="hidden" name="operation" value="del">
            <div class="panel">
                <%
                    int cnt = 1;
                    ArrayList list3 = db.getAllQuestions(Integer.parseInt(session.getAttribute("tid").toString()));
                    for(int i=0; i<list3.size(); i = i + 7){
                        //System.out.println(list3.get(i+6));
                %>
                <div class="show-all-box">
                    <label class="num"><%=cnt%></label>
                    <button class="delete-question-btn" type="submit" name="submit" value="<%=list3.get(i+6)%>">Delete Question</button>
                    <div class="question"><%=list3.get(i)%></div>
                    
                    <table class="show-table">
                        <tr>
                            <td class="ans"><center><%=list3.get(i+1)%></center></td>
                            <td class="ans"><center><%=list3.get(i+2)%></center></td>
                        </tr>
                        <tr>
                            <td class="ans"><%=list3.get(i+3)%></td>
                            <td class="ans"><%=list3.get(i+4)%></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="ans correct"><%=list3.get(i+5)%></td>
                        </tr>
                    </table>
                </div>
                <%
                    cnt++;
                    }
                %>
                <input class="done-btn" type="submit" name="submit" value="Done">
            </div>
        </form>
        <%
            }
        %>
           
    </body>
</html>
