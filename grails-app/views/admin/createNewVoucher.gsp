<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>

<script type="text/javascript">


  function addToVoucherList() {
    $("#message_box").html("")
    var isValidationComplete = true;
    $.each(["numberOfVouchers","denomination"], function(index, value) {
      var valueOfField = $('#' + value).val()
      if (valueOfField == "") {
        $("#message_box").html('Number Of Vouchers And Voucher Value Should Not Be Empty')
        isValidationComplete = false;
        return false
      }
      if (!valueOfField.match(/^\d*$/)) {
        $("#message_box").html('Number Of Vouchers And Voucher Value Should Be Numeric')
        isValidationComplete = false;
        return false;
      }
    });
    if (isValidationComplete) {
      var numberOfVouchers = $("#numberOfVouchers").val();
      var inputVoucherNumberField = '<input type="text" class="readOnly" readonly="true" name="voucherSet.numberOfVouchers" id="voucherSet.numberOfVouchers" value="' + numberOfVouchers + '"/>'
      var denomination = $("#denomination").val();
      var inputDenominationField = '<input type="text" class="readOnly" readonly="true" name="voucherSet.denomination" id="voucherSet.denomination" value="' + denomination + '"/>'
      var inputTotalField = "<label>" + (numberOfVouchers * denomination) + "</label>"
      $('#voucherDetailsTable tr:last').after('<tr><td>' + inputVoucherNumberField + '</td><td>' + inputDenominationField + '</td><td>' + inputTotalField + '</td><td><input type="button" value="X"></td></tr>')
      bindRemoveClickHandlerForTableRow('voucherDetailsTable')
      $.each(["numberOfVouchers","denomination"], function(index, value) {
        $('#' + value).val("")
      });
    }
  }

  function validateCreateVoucherForm() {
    if ($('#voucherDetailsTable tr').length < 2) {
      $("#message_box").html('No Voucher In The List To Create')
      return false;
    }
    $('#Create').attr('disabled', 'true')
    return true;
  }
</script>

<div id="createNewVoucher">
  <g:form action="createNewVoucher" controller="admin" onsubmit="return validateCreateVoucherForm()">
    <div class="leftNav">
      <ul class="leftNavUL">
        <li><label>Client:</label></li>
        <li><g:select name="clientId" from="${clientList}" value="${params.clientId}" optionKey="id" optionValue="name"/></li>
        <li><label>Invoiced At:</label></li>
        <li><g:select name="invoicedAt" from="${shops}" value="${params.invoicedAt}" optionKey="id" optionValue="name"/></li>
      </ul>
    </div>


    <div class="rightContent">
      <div id="message_box" style="text-align:center">
        <g:if test="flash.message">
          ${flash.message}
        </g:if>
      </div>
      <div>
        <ul id="voucherAddition">
          <li style="display:inline;padding:5px"><label>Number Of Vouchers</label></li>
          <li style="display:inline;padding:5px"><g:textField name="numberOfVouchers"/></li>
          <li style="display:inline;padding:5px"><label>Voucher Denomination</label></li>
          <li style="display:inline;padding:5px"><g:textField name="denomination"/></li>
          <li style="display:inline;padding:5px"><input type="button" value="Add To List" onclick="addToVoucherList()"/></li>
        </ul>
      </div>
      <div id="voucherList" style="height:300px;overflow-y:auto">
        <h3>Voucher Creation List</h3>
        <table id="voucherDetailsTable" style="margin-left:80px">
          <tr>
            <th># Vouchers</th>
            <th>Voucher Value</th>
            <th>Total Value</th>
            <th>Delete</th>
          </tr>
          <g:each in="${voucherSet}" status="i" var="voucher">
            <tr>
              <td><g:textField name="voucherSet.numberOfVouchers" readonly="true"/></td>
              <td><g:textField name="voucherSet.denomination" readonly="true"/></td>
              <td><label>100</label></td>
              <td><input type="button" value="X"></td>
            </tr>
          </g:each>
        </table>
      </div>
      <div style="margin-left:80px;margin-top:10px;"><g:submitButton name="Create" value="Create Vouchers"/></div>

    </div>
  </g:form>
</div>

</body>
</html>