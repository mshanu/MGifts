<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<script type="text/javascript">
  function validateMandatoryFields() {
    var isAnyFieldEmpty = false;
    if ($('input:text').each(function() {
      isAnyFieldEmpty = $(this).val() == '' ? true : isAnyFieldEmpty
    }))
      if (isAnyFieldEmpty) {
        $("#message_box").html("Please Enter All The Mandatory Fields")
        return false;
      }
    if ($("#password").val() != $("#confirmPassword").val()) {
      $("#message_box").html("Password and Confirm Password doesnt match")
      return false
    }
    /*if (!$("#password").val().match('^.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*$')) {
     alert($("#password").val().match('^.(?=.*[a-z])(?=.*[A-Z]).*$'))
     //$("#message_box").html("Password must be atleast 8 characters long with a combination of lower/upper/special characters")
     return false;
     }*/
    return true
  }
</script>
<g:form action="insertUser" onsubmit="return validateMandatoryFields()">
  <div>
    <div id="message_box" style="text-align:center">
      <g:if test="flash.message">
        ${flash.message}
      </g:if>
    </div>
    <h3>User Management</h3>
    <div id="addUser">

      <table id="userTable">
        <tr>
          <td><label>First Name</label><span class="mandotry">*</span></td>
          <td><g:textField name="firstName" value="${params.firstName}"/></td>
        </tr>
        <tr>
          <td><label>Last Name</label><span class="mandotry">*</span></td>
          <td><g:textField name="lastName" value="${params.lastName}"/></td>
        </tr>
        <tr>
          <td><label>User Name</label><span class="mandotry">*</span></td>
          <td><g:textField name="username" value="${params.username}"/></td>
        </tr>
        <tr>
          <td><label>Password</label><span class="mandotry">*</span></td>
          <td><g:passwordField name="password"/></td>
        </tr>
        <tr>
          <td><label>Confirm Password</label><span class="mandotry">*</span></td>
          <td><g:passwordField name="confirmPassword"/></td>
        </tr>
        <tr>
          <td><label>Role</label></td>
          <td><g:select name="userRole" from="${roles}" value="${params.userRole}" optionKey="authority" optionValue="description"></g:select></td>
        </tr>
        <tr>
          <td><label>Shop</label></td>
          <td><g:select name="shop" from="${shops}" value="${params.shop}" optionKey="id" optionValue="name"></g:select></td>
        </tr>
        <tr>
          <td colspan="2"><g:submitButton name="Create" value="Save"/></td>
        </tr>
      </table>

    </div>
    <div id="userList">
      <table>
        <thead>
        <tr>
          <th>First Name</th>
          <th>Second Name</th>
          <th>User Name</th>
          <th>Shop</th>
          <th>Reset Password</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${users}">
          <tr>
            <td>${it.firstName}</td>
            <td>${it.lastName}</td>
            <td>${it.username}</td>
            <td>${it.shop.name}</td>
            <td><input type="button" value="Reset Password"></td>
          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
  </div>
</g:form>
</body>
</html>