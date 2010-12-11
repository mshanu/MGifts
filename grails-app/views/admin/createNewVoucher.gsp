<html>
<head>
  <meta name="layout" content="adminMain"/>
  <script type="text/javascript">
    function validateCreateVoucherForm() {
      if (validateMandatoryFields()) {
        var isNumberFieldValid = true;
        $.each(["numberOfVouchers","voucherValue"], function(index, value) {
          if (!$('#' + value).val().match(/^\d*$/)) {
            $("#message_box").html('Number Of Vouchers And Voucher Value Should Be Numeric')
            isNumberFieldValid = false;
          }
        });
        return isNumberFieldValid;
      } else {
        $("#message_box").html('Please fill all mandatory fields')
        return false;
      }
    }
    function validateMandatoryFields() {
      var isAllFieldsFilled = true;
      $("span.mandotry").each(function() {
        var mandotoryTextBox = $(this).parent().parent().find("input:text");
        if (mandotoryTextBox.val() == "") {
          isAllFieldsFilled = false;
        }

      });
      return isAllFieldsFilled;
    }
  </script>
</head>
<div style="margin-top:10%; margin-left:35%;">
  <span id="message_box">
    <g:if test="flash.message">
      ${flash.message}
    </g:if>
  </span>
  <g:form action="createNewVoucher" controller="admin" onsubmit="return validateCreateVoucherForm()">
    <table>
      <tr>
        <td><label>Client</label><span class="mandotry">*</span></td>
        <td><g:select name="clientId" from="${clientList}" value="${params.clientId}" optionKey="id" optionValue="name"/></td>
      </tr>
      <tr>
        <td><label>Number of vouchers</label><span class="mandotry">*</span></td>
        <td><g:textField name="numberOfVouchers"/></td>
      </tr>
      <tr>
        <td><label>Voucher Value in Rs:</label><span class="mandotry">*</span></td>
        <td><g:textField name="voucherValue"/></td>
      </tr>
      <tr>
        <td><g:submitButton name="Create" value="Save"/></td>
      </tr>
    </table>
  </g:form>
</div>
</html>