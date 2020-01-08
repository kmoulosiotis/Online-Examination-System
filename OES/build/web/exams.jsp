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
        <title>Exams</title>
    </head>
    <body>
        <div class="sidebar">
            <h3>Online Examination System</h3>
            <img src="images/logo.png" width="80" height="80" alt="OES"/>
            <a href="std-page.jsp?pgprt=0">Profile</a>
            <a class ="active"  href="std-page.jsp?pgprt=1">Exams</a>
            <a href="std-page.jsp?pgprt=2">Results</a>
            <a class="logout" href="index.jsp">Logout</a>
        </div>
        
        <%
            User user = db.getUserDetails(session.getAttribute("uname").toString());
            if(session.getAttribute("startExam") == null){
        %>
        
        <form action="controller" method="POST">
            <input type="hidden" name="page" value="exams">
            <div class="exam-box1">
                <div class="exam-title">Start an exam</div>
                <%
                    if(session.getAttribute("th") == null){
                %>
                <input class="s-text" type="text" name="teacher-username" placeholder="Search for teacher's username...">
                <input class="n2-btn" type="submit" name="submit" value="Find teacher">
                <%
                    }else if(session.getAttribute("th").equals("1")){
                        User teacher = db.getUserDetails(session.getAttribute("teacher_username").toString());
                        ArrayList list = db.getAllClasses(teacher.getUser_id());
                %>
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
                <input class="n2-btn" type="submit" name="submit" value="Select class">
                <input class="b3-btn" type="submit" name="submit" value="Back">
                <%
                    }else{
                        User teacher = db.getUserDetails(session.getAttribute("teacher_username").toString());
                        ArrayList list2 = db.getAllTests(teacher.getUser_id());
                %>
                <label>Select Test:</label>
                <select class="in" name="test_name">
                    <%
                        for(int i=0; i<list2.size(); i = i + 3){

                            if(list2.get(i+2).equals(db.getClassId2(session.getAttribute("class_name").toString(), teacher.getUser_id()))){

                    %>
                    <option value="<%=list2.get(i)%>"><%=list2.get(i)%></option>
                    <%
                            }
                        }
                    %>
                </select>
                <input class="n2-btn" type="submit" name="submit" value="Start test">
                <input class="b3-btn" type="submit" name="submit" value="Back">
                <%
                    }
                %>
            </div>
        </form>
            <%
                }else{
            %>
            <span id="remainingTime" style="position: fixed;top:90px;left: 300px;font-size: 23px;background: rgba(255,0,77,0.38);border-radius: 5px;padding: 10px;box-shadow: 2px -2px 6px 0px;">
            </span>
            
            <script>
                var time = <%=db.getRemainingTime(Integer.parseInt(session.getAttribute("examId").toString())) %>;
                time--;
                var sec=60;                    
                document.getElementById("remainingTime").innerHTML =  time+" : "+sec;
                   //it calls fuction after specific time again and again                  
                var x= window.setInterval(timerFunction, 1000);

                    function timerFunction(){
                            sec--;
                      // Display the result in the element with id="demo"


                      if (time < 0) {
                        clearInterval(x);
                        document.getElementById("remainingTime").innerHTML = "00 : 00";
                        document.getElementById("myform").submit();
                        
                      }
                      document.getElementById("remainingTime").innerHTML =  time+" : "+sec;
                        if(sec==0){
                            sec=60;
                            time--;

                        }
                    }
            </script>
            
            <form id="myform" action="controller" method="POST">
                <input type="hidden" name="page" value="exams">
                <div class="panel">
                <%
                    int cnt = 1;
                    ArrayList list3 = db.getAllQuestions(Integer.parseInt(session.getAttribute("tid").toString()));
                    
                    for(int i=0; i<list3.size(); i = i + 7){
                        //System.out.println(list3.get(i+6));
                %>
                <div class="show-all-box">
                    <label class="num"><%=cnt%></label>
                    <div class="question"><%=list3.get(i)%></div>
                    
                    
                    <div class="answer">
                        <input type="radio" id="c1<%=cnt%>" name="ans<%=i%>" value="<%=list3.get(i+1)%>">
                        <label for="c1<%=cnt%>">
                            <span><%=list3.get(i+1)%></span>
                        </label>

                        <input type="radio" id="c2<%=cnt%>" name="ans<%=i%>" value="<%=list3.get(i+2)%>">
                        <label for="c2<%=cnt%>">
                            <span><%=list3.get(i+2)%></span>
                        </label>

                        <input type="radio" id="c3<%=cnt%>" name="ans<%=i%>" value="<%=list3.get(i+3)%>">
                        <label for="c3<%=cnt%>">
                            <span><%=list3.get(i+3)%></span>
                        </label>

                        <input type="radio" id="c4<%=cnt%>" name="ans<%=i%>" value="<%=list3.get(i+4)%>">
                        <label for="c4<%=cnt%>">
                            <span><%=list3.get(i+4)%></span>
                        </label>
                    </div>
                </div>
                <input type="hidden" name="question<%=i%>" value="<%=list3.get(i)%>">
                <input type="hidden" name="qid<%=i%>" value="<%=list3.get(i+6)%>">
                <%
                    cnt++;
                    }
                %>
                <input type="hidden" name="size" value="<%=list3.size()%>">
                <input class="done-btn" type="submit" name="submit" value="Done">
            </div>
            </form>
            <%
                }
            %>
        
    </body>
</html>
