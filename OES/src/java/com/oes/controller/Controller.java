package com.oes.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oes.database.*;
import com.oes.dao.User;

@WebServlet(name = "Controller", urlPatterns = {"/controller"})
public class Controller extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Controller</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Controller at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("page").equals("login")){
            if(Database.loginValidate(request.getParameter("username"),request.getParameter("password1"))){
                if(Database.getUserType(request.getParameter("username")).equals("teacher")){
                    request.getSession().setAttribute("uname", request.getParameter("username"));
                    response.sendRedirect("tchr-page.jsp?pgprt=0");
                    
                }
                else{
                    request.getSession().setAttribute("uname", request.getParameter("username"));
                    response.sendRedirect("std-page.jsp?pgprt=0");
                }
            }
            else{
                response.sendRedirect("index.jsp");
            }
        }else if(request.getParameter("page").equals("register")){
            User u = new User();
            
            u.setUsername(request.getParameter("username"));
            u.setFirst_name(request.getParameter("first-name"));
            u.setLast_name(request.getParameter("last-name"));
            u.setEmail(request.getParameter("email"));
            u.setPassword(request.getParameter("password1"));
            u.setType(request.getParameter("radio"));
            if(Database.userExists(u.getUsername())){
                request.setAttribute("exists", "Username already exists");
                //System.out.println("Helloo");
                //response.sendRedirect("register.jsp");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }else if(!u.getPassword().equals(request.getParameter("password2"))){
                request.setAttribute("diffpass", "Passwords do not match");
                //response.sendRedirect("register.jsp");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }else{
                Database.addUser(u);
            }
            
            response.sendRedirect("index.jsp");
        }else if(request.getParameter("page").equals("profile")){
            String uname = request.getParameter("username");
            String fName = request.getParameter("first-name");
            String lName = request.getParameter("last-name");
            String email = request.getParameter("email");
            String ps = request.getParameter("password1");
            String type = request.getParameter("utype");
            int uid = Integer.parseInt(request.getParameter("uid"));
            Database.updateUser(uid, uname, fName, lName, email, ps, type);
            
            if(Database.getUserType(request.getParameter("username")).equals("teacher")){
                    request.getSession().setAttribute("uname", request.getParameter("username"));
                    response.sendRedirect("tchr-page.jsp?pgprt=0");
                    
                }
                else{
                    request.getSession().setAttribute("uname", request.getParameter("username"));
                    response.sendRedirect("std-page.jsp?pgprt=0");
                }
        }else if(request.getParameter("page").equals("classes")){
            if(request.getParameter("operation").equals("del")){
                Database.delClass(request.getParameter("cname"), Database.getUserId(request.getSession().getAttribute("uname").toString()));
                response.sendRedirect("tchr-page.jsp?pgprt=1");
            }else if(request.getParameter("operation").equals("add")){
                Database.addClass(request.getParameter("new_class"), Database.getUserId(request.getSession().getAttribute("uname").toString()));
                response.sendRedirect("tchr-page.jsp?pgprt=1");
            }
        }else if(request.getParameter("page").equals("tests")){
            if(request.getParameter("operation").equals("add")){
                String tname = request.getParameter("test_name");
                String duration = request.getParameter("test_time");
                int uid = Database.getUserId(request.getSession().getAttribute("uname").toString());
                int cid = Database.getClassId(request.getParameter("class_name"), uid);
                Database.addTest(tname, duration, cid, uid);
                response.sendRedirect("tchr-page.jsp?pgprt=2");
            }else if(request.getParameter("operation").equals("del")){
                Database.delTest(request.getParameter("tname"), Database.getUserId(request.getSession().getAttribute("uname").toString()));
                response.sendRedirect("tchr-page.jsp?pgprt=2");
            }
        }else if(request.getParameter("page").equals("questions")){
            if(request.getParameter("operation").equals("add")){
                String cname = request.getParameter("class_name");
                if(request.getParameter("submit").equals("Next")){
                    request.getSession().setAttribute("op", 1);
                    request.getSession().setAttribute("class_name", cname);
                }else if(request.getParameter("submit").equals("Back")){
                    request.getSession().setAttribute("op", null);
                    request.getSession().setAttribute("class_name", null);
                }else{
                    int uid = Database.getUserId(request.getSession().getAttribute("uname").toString());
                    int cid = Database.getClassId(request.getSession().getAttribute("class_name").toString(), uid);
                    String tname = request.getParameter("test_name");
                    int tid = Database.getTestId(tname, cid, uid);
                    
                    String q = request.getParameter("question");
                    String op1 = request.getParameter("opt1");
                    String op2 = request.getParameter("opt2");
                    String op3 = request.getParameter("opt3");
                    String op4 = request.getParameter("opt4");
                    String correct = request.getParameter("correct");
                    
                    Database.addQuestion(q, op1, op2, op3, op4, correct, tid, cid, uid);
                }
                
                response.sendRedirect("tchr-page.jsp?pgprt=3");
            }else if(request.getParameter("operation").equals("del")){
                String cname = request.getParameter("c_name");
                if(request.getParameter("submit").equals("Next")){
                    request.getSession().setAttribute("sh", 1);
                    request.getSession().setAttribute("c_name", cname);
                    //System.out.println(cname);
                }else if(request.getParameter("submit").equals("Back")){
                    request.getSession().setAttribute("sh", null);
                    request.getSession().setAttribute("c_name", null);
                }else if(request.getParameter("submit").equals("Show questions")){
                    request.getSession().setAttribute("showall", 1);
                    
                    int uid = Database.getUserId(request.getSession().getAttribute("uname").toString());
                    int cid = Database.getClassId(request.getSession().getAttribute("c_name").toString(), uid);
                    String tname = request.getParameter("t_name");
                    int tid = Database.getTestId(tname, cid, uid);
                    
                    request.getSession().setAttribute("tid", tid);
                }else if(request.getParameter("submit").equals("Done")){
                    request.getSession().setAttribute("showall", null);
                }else{
                    Database.delQuestion(Integer.parseInt(request.getParameter("submit")));
                }
                
                response.sendRedirect("tchr-page.jsp?pgprt=3");
            }
        }else if(request.getParameter("page").equals("exams")){
            //System.out.println(request.getParameter("pgprt"));
            if(request.getParameter("submit").equals("Find teacher")){
                if(Database.findTeacher(request.getParameter("teacher-username"))){
                    request.getSession().setAttribute("th", "1");
                    request.getSession().setAttribute("teacher_username", request.getParameter("teacher-username"));
                }
            }else if(request.getParameter("submit").equals("Select class")){
                request.getSession().setAttribute("th", "2");
                request.getSession().setAttribute("class_name", request.getParameter("class_name"));
            }else if(request.getParameter("submit").equals("Start test")){
                request.getSession().setAttribute("test_name", request.getParameter("test_name"));
                
                request.getSession().setAttribute("startExam", 1);
                
                int teacher_id = Database.getUserId(request.getSession().getAttribute("teacher_username").toString());
                //System.out.println(request.getSession().getAttribute("teacher_username"));
                int cid = Database.getClassId(request.getSession().getAttribute("class_name").toString(), teacher_id);
                String tname = request.getSession().getAttribute("test_name").toString();
                int tid = Database.getTestId(tname, cid, teacher_id);
                int uid = Database.getUserId(request.getSession().getAttribute("uname").toString());
                request.getSession().setAttribute("tid", tid);
                Database.startExam(tid, uid);
                int examId = Database.getLastExamIdByUserId(uid);
                //System.out.println(examId);
                request.getSession().setAttribute("examId", examId);
            }else if(request.getParameter("submit").equals("Back")){
                if(request.getSession().getAttribute("th").equals("1")){
                    request.getSession().setAttribute("th", null);
                }else{
                    request.getSession().setAttribute("th", "1");
                }
            }else if(request.getParameter("submit").equals("Done")){
                request.getSession().setAttribute("startExam", null);
                request.getSession().setAttribute("th", null);
                int size = Integer.parseInt(request.getParameter("size"));
                //System.out.println(size);
                int eid = Integer.parseInt(request.getSession().getAttribute("examId").toString());
                int numOfQuestions = 0;
                for(int i=0; i<size; i = i + 7){
                    int qid = Integer.parseInt(request.getParameter("qid"+i));
                    String ans = request.getParameter("ans"+i);
                    String question = request.getParameter("question"+i);
                    Database.insertAnswer(question, ans, eid, qid);
                    numOfQuestions++;
                }
                Database.calculateResult(eid, numOfQuestions);
            }
            
            
            response.sendRedirect("std-page.jsp?pgprt=1");
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
