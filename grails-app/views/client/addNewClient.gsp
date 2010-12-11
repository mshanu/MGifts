<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<script type="text/javascript">
  function validateMandatoryFields() {
    var isAllFieldsFilled = true;
    $("span.mandotry").each(function() {
      var mandotoryTextBox = $(this).parent().parent().find("input:text");
      if (mandotoryTextBox.val() == "") {
        isAllFieldsFilled = false;
      }

    });
    if (!isAllFieldsFilled) {
      $("#message_box").html('Mandatory fields are not filled!!')
      return false;
    }

    if ($("#initials").val().length < 3) {
      $("#message _box").html('Initials should be of three characters')
      return false;
    }
    if (!$("#initials").val().match(/^[a-zA-Z]*$/)) {
      $("#message_box").html('Initials cannot have digits')
      return false;

    }
    return true;
  }
</script>
<div style="margin-top:10%; margin-left:35%;">
  <span id="message_box">
    <g:if test="flash.message">
      ${flash.message}
    </g:if>
  </span>
  <g:form action="insert" controller="client" onsubmit="return validateMandatoryFields()">
    <table>
      <tr>
        <td><label>ClientName</label><span class="mandotry">*</span></td>
        <td><g:textField name="name" value="${params.name}" style="width:200px"/></td>
      </tr>
      <tr>
        <td><label>Initials</label><span class="mandotry">*</span></td>
        <td><g:textField name="initials" value="${params.initials}" maxlength="3" style="width:40px;"/></td>
      </tr>
      <tr>
        <td><label>Address</label></td>
        <td><g:textField name="address" value="${params.address}"/></td>
      </tr>
      <tr>
        <td><label>City</label></td>
        <td><g:textField name="city" style="width:200px" value="${params.city}"/></td>
      </tr>
      <tr>
        <td colspan="2"><g:submitButton name="Create" value="Save"/></td>
      </tr>
    </table>
  </g:form>
</div>
</body>
</html>