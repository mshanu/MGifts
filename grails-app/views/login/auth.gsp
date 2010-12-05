<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
  <meta http-equiv="content-type"
          content="text/html; charset=ISO-8859-1">
  <title>My first styled page</title>
  <style type="text/css">
  body {
    color: black;
    font-family: verdana, arial, sans-serif;
    font-size: 17px;
    font-weight: bold;
    background-color: #e4c52d;
  }

  #login {
    width: 760px;
    height: 237px;
    border: thick double OliveDrab;
    margin-top: 10%;
    margin-left: 12%;
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

  .submit_button {
    color: OliveDrab;
    border: 1px solid OliveDrab;
    font-weight: bold;
  }

  </style>
</head>

<body>
<div id="login">
<div id="login_picture"> <img style="width: 350px; height: 231px;"
 alt="" src="images/malabar_login.jpg"> </div>
<div id="login_form">
<g:if test='${flash.message}'>
  <div>${flash.message}</div>
</g:if>
<form action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>
  <table>
    <tbody>
    <tr>
      <td>Username</td>
      <td><input id="username" type="text" name="j_username"></td>
    </tr>
    <tr>
      <td>Password</td>
      <td><input  type="password" name="j_password" id="password"></td>
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
</div>
</div>
</body>



%{--<div id='login'>
  <div>
    <g:if test='${flash.message}'>
      <div>${flash.message}</div>
    </g:if>
    <div>Please Login..</div>
    <form action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>
      <p>
        <label for='username'>Login ID</label>
        <input type='text' name='j_username' id='username'/>
      </p>
      <p>
        <label for='password'>Password</label>
        <input type='password' name='j_password' id='password'/>
      </p>
      <p>
        <label for='remember_me'>Remember me</label>
        <input type='checkbox' name='${rememberMeParameter}' id='remember_me'
          <g:if test='${hasCookie}'>checked='checked'</g:if>/>
      </p>
      <p>
        <input type='submit' value='Login'/>
      </p>
    </form>
  </div>
</div>--}%
<script type='text/javascript'>
  <!--
  (function() {
    document.forms['loginForm'].elements['j_username'].focus();
  })();
  // -->
</script>
</body>
</html>