<html>
<head>
  <meta name="layout" content="adminMain"/>
  <script type="text/javascript">
    function validateCreateVoucherForm() {
      if (validateMandatoryFields) {
        var isNumberFieldValid=true;
        $.each(["numberOfVouchers","voucherValue"],function(index,value){
            if(!$('#'+value).val().match('[0-9]')){
              $("#message_box").html('Number Of Vouchers An Voucher Value Should Be Numeric')
              isNumberFieldValid=false;
            }
        });
        return isNumberFieldValid;
      } else {
        return false;
      }
    }
  </script>
</head>
<div style="margin-top:10%; margin-left:35%;">
  <span id="message_box">
    <g:if test="flash.message">
      ${flash.message}
    </g:if>
  </span>
  <g:form action="insert" controller="voucher" onsubmit="return validateCreateVoucherForm()">
    <table>
      <tr>
        <td><label>Client</label><span class="mandotry">*</span></td>
        <td><g:select name="clientId" from="${clientList}" optionKey="id" optionValue="name"/></td>
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