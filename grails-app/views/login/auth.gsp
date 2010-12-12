<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
  <meta http-equiv="content-type"
          content="text/html; charset=ISO-8859-1"/>
           
  <title>breigns</title>
  <style type="text/css">
  body {
    color: black;
    font-family: verdana, arial, sans-serif;
    font-size: 17px;
    font-weight: bold;
    background-color: #e4c52d;
  }

  #login {
    width: 800px;
    height: 237px;
    border: thick double OliveDrab;
    margin-top: 10%;
    margin-left: 20%;
  }

  #login_picture {
    float: left;
    width: 400px;
  }

  #login_form {
    margin-top: 70px;
    margin-right: 40px;
    position: relative;
    float: right;
  }

  #login_form table {
    border: 5px;
  }

  #error_msg{
    color:red;
    font-size:12px;
    font-weight:normal;
    width:313px;    
  }

  .submit_button {
    color: OliveDrab;
    border: 1px solid OliveDrab;
    font-weight: bold;
  }

  </style>
</head>

<body>
<div id="login">
<div id="login_picture"> <img style="width: 351px; height: 231px;"
 alt="" src="${resource(dir: 'images', file: 'malabar_login.jpg')}"> </div>
<div id="login_form">
  <form action='${postUrl}' method='POST' id='loginForm' autocomplete='off' onsubmit="return validateLoginForm()">
    <table>
      <tbody>
      <tr>
        <td>Username</td>
        <td><input id="username" type="text" name="j_username"></td>
      </tr>
      <tr>
        <td>Password</td>
        <td><input type="password" name="j_password" id="password"></td>
      </tr>
      <tr>
        <td><br>
        </td>
        <td align="left"><input value="Login" class="submit_button"
                type="submit"></td>
      </tr>
      </tbody>
    </table>
  </form>
  <div id="error_msg">
    <g:if test='${flash.message}'>
      ${flash.message}
    </g:if>
  </div>
</div>
</div>
</body>
<script type='text/javascript'>
  function validateLoginForm(){
    var userName = document.getElementById('username');
    var password = document.getElementById('password');
    if(userName.value==""||password.value==""){
      document.getElementById("error_msg").innerHTML="User/Password field cannot be empty"
      return false
    }
    return true
  }

  <!--
  (function() {
    document.forms['loginForm'].elements['j_username'].focus();
  })();
  // -->
</script>
</body>
</html>