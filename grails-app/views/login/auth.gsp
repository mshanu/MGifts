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
  height: 280px;
  background-image: url('${resource(dir: 'images', file: 'login_form_background.png')}');
  border-radius: 4px 4px 4px 4px;
  margin-left: auto;
  margin-right: auto;
  border: #a9a9a9 outset medium;
}

#login_pic_div {
  float: right;
  padding:80px;
  margin-left:100px;
  position: static;
}

#login_pic_div img {
  height: 100px;
  width: 250px;
  position: static;
  border: #b8860b thin ridge;
  opacity:0.7;
  border-radius: 4px 4px 4px 4px;
}

#malabar_pic_div {
  width: 300px;
  margin-top: 5%;
  padding: 2px;
  margin-left: auto;
  margin-right: auto;
}

#malabar_pic_div h4 {
  margin-left: 40px;
  margin-bottom: 5px;
  font-family: verdana;
  color: #8b0000;
  text-decoration: underline;
}

#malabar_pic_div img {
  height: 140px;
  width: 200px;
  position: static;
  border: #b8860b thin ridge;
}

#login_form {
  float: left;
  margin-left: 30px;
  margin-top: 80px;
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

#loginHeading {
  text-align: center;
  font-family: SERIF,HELVETICA;
  font-weight:500;
  margin-bottom: 50px;
  margin-top: 50px;
  color: #a52a2a;
  text-shadow: black 2px 0px 1px
}
</style>
</head>

<body>

<h2 id="loginHeading">Welcome to Voucher Management System</h2>
<div id="login">
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
  <div id="login_pic_div">
    <img src="${resource(dir: 'images', file: 'breigns.jpg')}" alt="breigns">
  </div>
</div>
<div id="malabar_pic_div">
  <h4>Powered By</h4>
  <img src="${resource(dir: 'images', file: 'malabar.jpg')}" alt="breigns">
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