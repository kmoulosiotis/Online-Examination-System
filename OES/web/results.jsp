<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.oes.dao.User" %>
<%@page import="com.oes.dao.Exams" %>
<%@page import="com.oes.dao.Answers" %>
<jsp:useBean id="db" class="com.oes.database.Database" scope="page"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="images/logo.png" type="image/logo" sizes="18x18">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="stylesheet" href="_css/sidebar.css">
        <link rel="stylesheet" href="_css/parts_styles.css">
        <title>Results</title>
    </head>
    <body>
        <div class="sidebar">
            <h3>Online Examination System</h3>
            <img src="images/logo.png" width="80" height="80" alt="OES"/>
            <a href="std-page.jsp?pgprt=0">Profile</a>
            <a href="std-page.jsp?pgprt=1">Exams</a>
            <a  class ="active" href="std-page.jsp?pgprt=2">Results</a>
            <a class="logout" href="index.jsp">Logout</a>
        </div>
        <%
            if(request.getParameter("eid")==null){
        %>
        
        <div class="result-box">
            <div class="result-title">All results</div>
            <table id="result-table">
                <th>Class Name</th>
                <th>Test Name</th>
                <th>Status</th>
                <th>Action</th>
        <%
            User user = db.getUserDetails(session.getAttribute("uname").toString());
            ArrayList list=db.getAllResultsFromExams(user.getUser_id());
            for(int i=0; i<list.size(); i++){
                Exams e=(Exams)list.get(i);
                String testName = db.getTestNameById(e.getTestId());
                int classId = db.getClassIdByTestId(e.getTestId());
                String className = db.getClassNameById(classId);
        %>
            <tr>
                <td><%=className%></td>
                <td><%=testName%></td>
                <td><%=e.getStatus()%></td>
                <td><a href="std-page.jsp?pgprt=2&eid=<%=e.getExamId()%>">View Details</a></td>
            </tr>
        
        <%
            }
        %>
            </table>
        </div>
        
            <%
                }else{
            %>
            <div class="detail-box">
                <div class="result-title">Result Details</div>
                    <table id="detail-table">
                <%
                    ArrayList list2 = db.getAllAnswersByExamId(Integer.parseInt(request.getParameter("eid")));
                    for(int i=0; i<list2.size(); i++){
                        Answers ans = (Answers)list2.get(i);
                        System.out.println(ans.getQuestion());
                %>
                
                    <tr>
                        <td rowspan="2"><%=i+1%>)</td>
                        <td colspan="2"><%=ans.getQuestion()%></td>
                        <td rowspan="2"><%=ans.getStatus()%></td>
                    </tr>
                    <tr>
                        <td>Your Answer: <%=ans.getAnswer()%></td>
                        <td>Correct Answer: <%=ans.getCorrectAnswer()%></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="style"></td>
                    </tr>
                <%
                    }
                %>
                    </table>
            </div>
            <%
                }
            %>
    </body>
</html>
