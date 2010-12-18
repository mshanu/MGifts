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
    if (!validateDate('validThru')) {
      $("#message_box").html('Valid Thru , Not A Valid Date')
      return false;
    }
    $('#Create').attr('disabled', 'true')
    return true;
  }
</script>

<div id="createNewVoucher">
  <g:form action="createNewVoucherRequest" controller="admin" onsubmit="return validateCreateVoucherForm()">
    <div class="leftNav">
      <ul class="leftNavUL">
        <li><label>Client:</label></li>
        <li><g:select name="clientId" from="${clientList}" value="${params.clientId}" optionKey="id" optionValue="name"/></li>
      </ul>
    </div>


    <div class="rightContent">
      <div id="message_box" style="text-align:center">
        <g:if test="flash.message">
          ${flash.message}
        </g:if>
      </div>
      <div>
        <table>
          <tr>
            <td>No Of Vouchers</td>
            <td><g:textField name="numberOfVouchers"/></td>
            <td>Voucher Value</td>
            <td><g:textField name="denomination"/></td>
            <td><input type="button" value="Add To List" onclick="addToVoucherList()"/></td>
          </tr>
        </table>
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
      <div>
        <table>
          <tr>
            <td>Valid Thru(dd/mm/yyyy)</td>
            <td><g:textField name="validThru"/></td>            
            <td><g:submitButton name="Create" value="Create Voucher Request"/></td>
          </tr>
        </table>

      </div>

    </div>
  </g:form>
</div>

</body>
</html>