<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
  <meta http-equiv="content-type"
          content="text/html; charset=ISO-8859-1"/>
          <LINK REL="SHORTCUT ICON" HREF="${resource(dir: 'images', file: 'favicon.ico')}">

<title>breigns</title>
<style type="text/css">
body {
  color: black;
  font-family: Verdana, Arial, sans-serif;
  background-image: url(${resource(dir: 'images', file: 'login_background.png')});
  background-repeat: repeat-x;
}

#login {
  width: 75%;
  height: 300px;
  border: thin double #696969;
  border-radius: 4px 4px 4px 4px;
  margin-top: 2%;
  margin-left: auto;
  margin-right: auto;
}

.loginPicture {
  border: #778899 outset thin;
  width: 30%;
  height: 50%;
  margin-top:50px;
  padding:1px;
  border-radius: 4px 4px 4px 4px;
}

.loginPicture img {
  width: 100%;
  height: 100%;
  position: static
}

#login_form {
  float:left;
  margin-left:30px;
  margin-top:80px;
}

#login_form table {
  border: 5px;
}

#error_msg {
  color: red;
  font-size: 12px;
  font-weight: normal;
  width: 313px;
}

.submit_button {
  color: OliveDrab;
  border: 1px solid OliveDrab;
  font-weight: bold;
}

</style>
</head>

<body>
<h2 style="text-align:center;margin-bottom:0px;margin-top:100px;color:#00008b;">Welcome to Voucher Management System</h2>
<div id="login">
  <div class="loginPicture" style="float:left">
    <img src="${resource(dir: 'images', file: 'breigns.jpg')}" alt="breigns">
  </div>
  <div class="loginPicture" style="float:right">
    <img src="${resource(dir: 'images', file: 'malabar.jpg')}" alt="breigns">
  </div>
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
  function validateLoginForm() {
    var userName = document.getElementById('username');
    var password = document.getElementById('password');
    if (userName.value == "" || password.value == "") {
      document.getElementById("error_msg").innerHTML = "User/Password field cannot be empty"
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