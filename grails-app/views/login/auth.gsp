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
  background-color: #fffff0;
  background-image: url(${resource(dir: 'images', file: 'login_background.gif')});
  background-repeat: repeat-y;
}

#login {
  width: 75%;
  height: 300px;
  border: thick double OliveDrab;
  border-radius: 4px 4px 4px 4px;
  margin-top: 10%;
  margin-left: 10%;
}

#login_picture_breigns {
  float: left;
  width: 200px;
  margin-left: 3%;
  margin-top: 8%;
}

#login_picture_malabar {
  float: left;
  margin-left: 10%;
  margin-top: 6%;
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
<div id="login">
  <div id="login_picture_breigns">
    <img src="${resource(dir: 'images', file: 'breigns.jpg')}" width="250;" alt="breigns">
  </div>
  <div id="login_picture_malabar">
    <img src="${resource(dir: 'images', file: 'malabar.jpg')}" style="width:160;height:160px;" alt="breigns">
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