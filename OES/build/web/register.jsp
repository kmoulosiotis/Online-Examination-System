<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="images/logo.png" type="image/logo" sizes="18x18">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="_css/login_register_styles.css">
    <title>Create your account</title>
</head>

<body class="register-body">
    <form class="register-form" action="controller" method="POST">
        <input type="hidden" name="page" value="register">
        <div class="register-box">
            <h1>Create an account</h1>
            <h1 class="diffPass" style="font-size: 13px;">${diffpass}</h1>
            <h1 class="inclUsr" style="font-size: 13px;">${exists}</h1>
            <img class="user-icon" src = "images/register-icon.png" alt="user" width="100" height="-60">
            <table class="register-table">
                <tr><td><input class="table-cell" type="text" name="username" placeholder="Username" required></td></tr>
                <tr><td><input class="table-cell" type="text" name="first-name" placeholder="First name" required></td></tr>
                <tr><td><input class="table-cell" type="text" name="last-name" placeholder="Last name"></td></tr>
                <tr><td><input class="table-cell" type="email" name="email" placeholder="E-mail" required></td></tr>
                <tr><td><input class="table-cell" type="password" name="password1" placeholder="Password" required></td></tr>
                <tr><td><input class="table-cell" type="password" name="password2" placeholder="Confirm password" required></td></tr>
                <tr>
                    <td>
                        I am:
                        <input type="radio" name="radio" value="student" id="student" required>
                        <label class="student-opt" for="student">
                            <span>Student</span>
                        </label>
                        
                        <input type="radio" name="radio" value="teacher" id="teacher" required>
                        <label class="teacher-opt" for="teacher">
                            <span>Teacher</span>
                        </label>
                    </td>
                </tr>
                <tr><td><input class="table-cell submit"type="submit" name="submit" value="SIGN UP"</td></tr>
            </table>
        </div>
    </form>
</body>
</html>
