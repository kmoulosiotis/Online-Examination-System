package com.oes.database;

import com.oes.dao.Answers;
import com.oes.dao.Exams;
import java.sql.*;
import com.oes.dao.User;
import java.time.Duration;
import java.time.LocalTime;
import java.util.ArrayList;

public class Database {
    static Connection conn = null;
    
    public static Connection getCon(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
        }catch(ClassNotFoundException e){
            System.out.println(e.toString());
        }
        
        try{
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/oes_database", "root", "root");
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return conn;
    }
    
    public static String getUserType(String uname){
        
        String type = null;
        String sql = "SELECT * FROM users WHERE username=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            p.setString(1, uname);
            
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                type = rs.getString("type");
            }
            
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return type;
    }
    
    
    public static boolean loginValidate(String uname, String pass){
        boolean status = false;
        
        String sql = "SELECT * FROM users WHERE username=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            p.setString(1, uname);
            
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                String un = rs.getString("username");
                String ps = rs.getString("password");
                
                if(un.equals(uname) && ps.equals(pass)){
                    status = true;
                }
            }
            
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return status;
    }
    
    public static void addUser(User u){
        
        String sql = "insert into users(username, first_name, last_name, email, password, type) values(?,?,?,?,?,?)";
        
        try{
            conn = Database.getCon();
            
            PreparedStatement p = conn.prepareStatement(sql);
            p.setString(1, u.getUsername());
            p.setString(2, u.getFirst_name());
            p.setString(3, u.getLast_name());
            p.setString(4, u.getEmail());
            p.setString(5, u.getPassword());
            p.setString(6, u.getType());
            
            p.executeUpdate();
            
            conn.close();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public static int getUserId(String uname){
        int id =0;
        
        String sql = "SELECT * FROM users WHERE username=?";
        
        try {
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            p.setString(1, uname);
            
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                id = rs.getInt("user_id");
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return id;
    }
    
    public static void updateUser(int uid, String uname, String fName, String lName, String email, String ps, String utype){
            String sql = "UPDATE users SET username=?, first_name=?, last_name=?, email=?, password=?, type=? WHERE user_id=?";
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setString(1, uname);
            p.setString(2, fName);
            p.setString(3, lName);
            p.setString(4, email);
            p.setString(5, ps);
            p.setString(6, utype);
            p.setInt(7, uid);
            p.executeUpdate();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public User getUserDetails(String uname){
        User u = new User();
        //System.out.println(uname);
        String sql = "SELECT * FROM users WHERE username=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            p.setString(1, uname);
            
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                u.setUser_id(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setFirst_name(rs.getString("first_name"));
                u.setLast_name(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setType(rs.getString("type"));
            }
            
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return u;
    }
    
    public static boolean userExists(String uname){
    
        boolean exists = false;
        
        String sql = "SELECT * FROM users WHERE username=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            p.setString(1, uname);
            
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                String un = rs.getString("username");
                
                if(un.equals(uname)){
                    exists = true;
                }
            }
            
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return exists;
    }
    
    public static boolean findTeacher(String uname){
        boolean status = false;
        
        String sql = "SELECT * FROM users WHERE username=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            p.setString(1, uname);
            
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                String un = rs.getString("username");
                String type = rs.getString("type");
                if(un.equals(uname) && type.equals("teacher")){
                    status = true;
                }
            }
            
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return status;
    }
    
    public ArrayList getAllClasses(int uid){
        ArrayList list = new ArrayList();
        String sql = "SELECT * FROM classes WHERE user_id=?";
   
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            p.setInt(1, uid);
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                list.add(rs.getString("class_name"));
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return list;
    }
    
    public static void addClass(String cname, int uid){
        
        String sql = "INSERT INTO classes(class_name, user_id) VALUES(?, ?)";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            p.setString(1, cname);
            p.setInt(2, uid);
            
            p.executeUpdate();
            
            conn.close();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public static void delClass(String cname, int uid){
        String sql = "DELETE FROM classes WHERE class_name=? AND user_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setString(1, cname);
            p.setInt(2,uid);
            
            p.executeUpdate();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public String getClassNameById(int cid){
        String c = null;
        String sql = "SELECT * FROM classes WHERE class_id=?";
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setInt(1, cid);
            
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                c = rs.getString("class_name");
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return c;
    }
    
    public static int getClassId(String cname, int uid){
        int cid = 0;
        
        String sql = "SELECT * FROM classes WHERE class_name=? AND user_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setString(1, cname);
            p.setInt(2, uid);
            
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                cid = rs.getInt("class_id");
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return cid;
    }
    
    public int getClassId2(String cname, int uid){
        int cid = 0;
        
        String sql = "SELECT * FROM classes WHERE class_name=? AND user_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setString(1, cname);
            p.setInt(2, uid);
            
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                cid = rs.getInt("class_id");
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return cid;
    }
    
    public int getClassIdByTestId(int tid){
        int id = 0;
        
        String sql = "SELECT class_id FROM tests WHERE test_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setInt(1, tid);
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                id = rs.getInt("class_id");
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return id;
    }
    
    public static void addTest(String tname, String duration, int cid ,int uid){
    
           String sql = "INSERT INTO tests(name, duration, class_id, user_id) VALUES(?, ?, ?, ?)";
           
           try{
               conn = Database.getCon();
                PreparedStatement p = conn.prepareStatement(sql);
                
                p.setString(1, tname);
                p.setString(2, duration);
                p.setInt(3, cid);
                p.setInt(4, uid);
                p.executeUpdate();
            
                conn.close();
           }catch(Exception e){
               System.out.println(e.toString());
           }
    }
    
    public ArrayList getAllTests(int uid){
        ArrayList list = new ArrayList();
        String sql = "SELECT * FROM tests WHERE user_id=?";
    
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setInt(1, uid);
            
            ResultSet rs = p.executeQuery();
            while(rs.next()){
                list.add(rs.getString("name"));
                list.add(rs.getString("duration"));
                list.add(rs.getInt("class_id"));
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return list;
    }
    
    public static int getTestId(String tname, int cid, int uid){
        int tid = 0;
        
        String sql = "SELECT * FROM tests WHERE name=? AND class_id=? AND user_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setString(1, tname);
            p.setInt(2, cid);
            p.setInt(3, uid);
            
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                tid = rs.getInt("test_id");
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return tid;
    }
    
    public String getTestNameById(int tid){
        String t = "";
        
        String sql = "SELECT * FROM tests WHERE test_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setInt(1, tid);
            ResultSet rs = p.executeQuery();
            
            while(rs.next()){
                t = rs.getString("name");
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return t;
    }
    
    public static void delTest(String tname, int uid){
        String sql = "DELETE FROM tests WHERE name=? AND user_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setString(1, tname);
            p.setInt(2,uid);
            
            p.executeUpdate();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public static void addQuestion(String question, String op1, String op2, String op3, String op4, String correct, int tid, int cid, int uid){
        
        String sql = "INSERT INTO questions(question,opt1,opt2,opt3,opt4,correct,test_id,class_id,user_id) VALUES(?,?,?,?,?,?,?,?,?)";
        
        try{
                conn = Database.getCon();
                PreparedStatement p = conn.prepareStatement(sql);
                
                p.setString(1, question);
                p.setString(2, op1);
                p.setString(3, op2);
                p.setString(4, op3);
                p.setString(5, op4);
                p.setString(6, correct);
                p.setInt(7, tid);
                p.setInt(8, cid);
                p.setInt(9, uid);
                p.executeUpdate();
            
                conn.close();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public ArrayList getAllQuestions(int tid){
        ArrayList list = new ArrayList();
        String sql = "SELECT * FROM questions WHERE test_id=?";
    
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setInt(1, tid);
            
            ResultSet rs = p.executeQuery();
            while(rs.next()){
                list.add(rs.getString("question"));
                list.add(rs.getString("opt1"));
                list.add(rs.getString("opt2"));
                list.add(rs.getString("opt3"));
                list.add(rs.getString("opt4"));
                list.add(rs.getString("correct"));
                list.add(rs.getInt("question_id"));
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return list;
    }
    
    public static void delQuestion(int qid){
        
        String sql = "DELETE FROM questions WHERE question_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setInt(1,qid);
            
            p.executeUpdate();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public static void startExam(int tid, int uid){
        
        String sql = "INSERT INTO exams(start_time,exam_time,test_id,user_id) VALUES(?,?,?,?)";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setString(1, LocalTime.now().toString());
            p.setString(2, getTestTimeById(tid));
            p.setInt(3, tid);
            p.setInt(4, uid);
            
            p.executeUpdate();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public static String getTestTimeById(int tid){
        String time="";
        
        String sql = "SELECT duration FROM tests WHERE test_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setInt(1,tid);
            
            ResultSet rs = p.executeQuery();
            while(rs.next()){
                time = rs.getString("duration");
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return time;
    }
    
    public static int getLastExamIdByUserId(int uid){
        int id = 0;
        
        String sql = "SELECT * FROM exams WHERE user_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p = conn.prepareStatement(sql);
            
            p.setInt(1, uid);
            
            ResultSet rs = p.executeQuery();
            while(rs.next()){
                id = rs.getInt("exam_id");
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return id;
    }
    
    public int getRemainingTime(int eid){
        int time = 0;
        
        String sql="Select start_time,exam_time from exams where exam_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p=conn.prepareStatement(sql);
            p.setInt(1, eid);
            ResultSet rs=p.executeQuery();
            
            while(rs.next()){
                //totalTime-(Math.abs(currentTime-examStartTime))
                //Duration.between(first,sec) returns difference between 2 dates or 2 times
               time=Integer.parseInt(rs.getString(2))-(int)Math.abs((Duration.between(LocalTime.now(),LocalTime.parse(rs.getString(1))).getSeconds()/60));
            }
            p.close();
        }catch(Exception e){
            System.out.println(e.toString());
        }
        //System.out.println(time);
        return time;
    }
    
    public static void insertAnswer(String question, String answer, int eid, int qid){
        
        String sql = "INSERT INTO answers(question,answer,correct_answer,status,exam_id,question_id) VALUES(?,?,?,?,?,?)";
        
        try{
            conn = Database.getCon();
            PreparedStatement p=conn.prepareStatement(sql);
            
            p.setString(1, question);
            p.setString(2, answer);
            String correct = getCorrectAnswer(qid);
            p.setString(3, correct);
            p.setString(4, getAnswerStatus(answer, correct));
            p.setInt(5, eid);
            p.setInt(6, qid);
            
            p.executeUpdate();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public static String getCorrectAnswer(int qid){
        String ans = "";
        
        String sql = "SELECT correct FROM questions WHERE question_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p=conn.prepareStatement(sql);
            p.setInt(1, qid);
            ResultSet rs=p.executeQuery();
            
            while(rs.next()){
                ans = rs.getString("correct");
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return ans;  
    }
    
    public static String getAnswerStatus(String ans, String correct){
        String status = "";
        
        if(ans.equals(correct)){
            status = "correct";
        }else{
            status = "incorect";
        }
        
        return status;
    }
    
    public static void calculateResult(int eid, int numOfQuestions){
        
        String sql = "UPDATE exams SET status=? WHERE exam_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p=conn.prepareStatement(sql);
            p.setInt(2, eid);
            
            int c = getCorrectAnswers(eid);
            if(c >= numOfQuestions/2){
                if(c==0){
                    p.setString(1, "Fail");
                }
                else{
                    p.setString(1, "Pass");
                }
            }
            else{
                p.setString(1, "Fail");
            }
            p.executeUpdate();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    
    public static int getCorrectAnswers(int eid){
        int c = 0;
        
        String sql = "SELECT COUNT(answer_id) FROM answers WHERE exam_id=? AND status='correct'";
        
        try{
            conn = Database.getCon();
            PreparedStatement p=conn.prepareStatement(sql);
            p.setInt(1, eid);
            
            ResultSet rs=p.executeQuery();
            
            while(rs.next()){
                c = rs.getInt(1);
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return c;
    }
    
    public ArrayList getAllResultsFromExams(int uid){
        ArrayList list = new ArrayList();
        Exams exam = null;
        
        String sql = "SELECT * FROM exams WHERE user_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p=conn.prepareStatement(sql);
            p.setInt(1, uid);
            
            ResultSet rs=p.executeQuery();
            
            while(rs.next()){
                exam = new Exams(rs.getInt("exam_id"), rs.getInt("test_id"), rs.getInt("user_id"), rs.getString("start_time"), rs.getString("exam_time"), rs.getString("status"));
                list.add(exam);
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
    
        return list;
    }
    
    public ArrayList getAllAnswersByExamId(int eid){
        ArrayList list = new ArrayList();
        Answers ans = null;
        
        String sql = "SELECT * FROM answers WHERE exam_id=?";
        
        try{
            conn = Database.getCon();
            PreparedStatement p=conn.prepareStatement(sql);
            p.setInt(1, eid);
            
            ResultSet rs=p.executeQuery();
            
            while(rs.next()){
                ans = new Answers(rs.getInt("answer_id"), rs.getInt("exam_id"), rs.getInt("question_id"), rs.getString("question"), rs.getString("answer"), rs.getString("correct_answer"), rs.getString("status"));
                list.add(ans);
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return list;
    }
}
