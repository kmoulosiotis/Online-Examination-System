<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <link rel="icon" href="images/logo.png" type="image/logo" sizes="18x18">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>OES - Home</title>
    <link rel="stylesheet" href="_css/styles.css">
    <link rel="stylesheet" href="_css/login_register_styles.css">
</head>

<body>
	
    <div class="main">
        <header>
            <a href="index.jsp"><img src="images/logo.png" width="80" height="80" alt="OES"></a>
            <nav>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="contact.html">Contact</a></li>
                    <li><a href="#">Support</a></li>
                    <li><button class = "btn" onclick="openMenu()">Login</button></li>
                    <li><button class = "btn"><a href="register.jsp">Sign up</a></button></li>
                </ul>
            </nav>
        </header>

        <div class="text">
                <h1>Online Examination System</h1>
                <p>Use todays technology to your class. With online tests make the process of student evaluation faster, easier and reliable.</p>
        </div>
    </div>
	
    <div class="main2">
        <div class="container2">
            <img src="images/student.jpg" alt="student" height= "250px" width="250px">
            <h1>Student</h1>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
            <h2><a href="#">Learn More &#187;</a></h2>
        </div>

        <div class="container2">
        <img src="images/teacher.png" alt="teacher" height= "250px" width="250px">
            <h1>Teacher</h1>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
            <h2><a href="#">Learn More &#187;</a></h2>
        </div>
    </div>
    
    <form class="login-form" id="login-form" action="controller" method="POST">
        <input type="hidden" name="page" value="login"> 
        <img class="close" src ="images/cancel.png" width="40" height="40" alt="cancel" onclick="closeMenu()">
        <div class="login-box">
            <h1>Login to account</h1>
            <img class="user-icon" src = "images/user-icon.png" alt="user" width="100" height="100">
            <table class="login-table">
                <tr><td><input class="table-cell" type="text" name="username" placeholder="Username"</td></tr>
                <tr><td><input class="table-cell" type="password" name="password1" placeholder="Password"</td></tr>
                <tr><td><input class="table-cell submit" type="submit" name="submit" value="LOG IN"</td></tr>
                <tr><td class="register">Not registered? <a href="register.jsp">Create an account</a></td></tr>
            </table>
        </div>
    </form>
	

    <script>
        function openMenu() {
          document.getElementById("login-form").style.display = "flex";
        }

        function closeMenu() {
          document.getElementById("login-form").style.display = "none";
        }           
    </script>
	
</body>

</html>
