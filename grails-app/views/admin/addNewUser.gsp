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
<div style="margin-top:10%; margin-left:35%;">
  <span id="message_box">
    <g:if test="flash.message">
      ${flash.message}
    </g:if>
  </span>
  <g:form action="insertUser" onsubmit="return validateMandatoryFields()">
    <table>
      <tr>
        <td><label>First Name</label><span class="mandotry">*</span></td>
        <td><g:textField name="firstName" value="${params.firstName}" style="width:200px;"/></td>
      </tr>
      <tr>
        <td><label>Last Name</label><span class="mandotry">*</span></td>
        <td><g:textField name="lastName" value="${params.lastName}" style="width:200px"/></td>
      </tr>
      <tr>
        <td><label>User Name</label><span class="mandotry">*</span></td>
        <td><g:textField name="username" value="${params.username}" style="width:200px"/></td>
      </tr>
      <tr>
        <td><label>Password</label><span class="mandotry">*</span></td>
        <td><g:passwordField name="password" style="width:200px"/></td>
      </tr>
      <tr>
        <td><label>Confirm Password</label><span class="mandotry">*</span></td>
        <td><g:passwordField name="confirmPassword" style="width:200px"/></td>
      </tr>
      <tr>
        <td><label>Role</label></td>
        <td><g:select name="userRole" from="${roles}" value="${params.userRole}" optionKey="authority" optionValue="description"></g:select></td>
      </tr>
      <tr>
        <td colspan="2"><g:submitButton name="Create" value="Save"/></td>
      </tr>
    </table>
  </g:form>
</div>
</body>
</html>