<html>
<head>
  <meta name="layout" content="adminMain"/>
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
        var inputVoucherNumberField = '<input type="text" readonly="true" name="voucherSet.numberOfVouchers" id="voucherSet.numberOfVouchers" value="' + numberOfVouchers + '"/>'
        var denomination = $("#denomination").val();
        var inputDenominationField = '<input type="text" readonly="true" name="voucherSet.denomination" id="voucherSet.denomination" value="' + denomination + '"/>'
        var inputTotalField = "<label>" + (numberOfVouchers * denomination) + "</label>"
        $('#voucherDetailsTable tr:last').after('<tr><td>' + inputVoucherNumberField + '</td><td>' + inputDenominationField + '</td><td>' + inputTotalField + '</td><td><input type="button" value="X"></td></tr>')
        bindRemoveClickHandlerForTableRow('voucherDetailsTable')
        $.each(["numberOfVouchers","denomination"], function(index, value) {
          $('#'+value).val("")
        });
      }
    }

    function validateCreateVoucherForm(){
       if($('#voucherDetailsTable tr').length<2){
        $("#message_box").html('No Voucher In The List To Create')
         return false;
       }
      return true;
    }
  </script>
  <style type="text/css">
  #createNewVoucher ul {
    list-style-type: none;
    font-family: 'Trebuchet MS', Tahoma;
    font-size: 16px;
    color: black;
    margin-left: -35px;
  }

  #voucherAddition li {
    display: inline;
    padding: 5px;
  }

  #voucherList {
    width: 100%;
    margin-top: 40px;
    height: 250px;
    overflow-y: auto
  }

  #voucherListHeading {
    text-align: center;
    border-bottom: black dotted thin;
  }

  #voucherDetailsTable tr th {
    width: 200px;
    text-align: left;
  }

  #voucherDetailsTable tr td {
    width: 200px;
    text-align: left;
  }
  </style>
</head>
<div id="createNewVoucher" style="margin-top:30px;">
  <g:form action="createNewVoucher" controller="admin" onsubmit="return validateCreateVoucherForm()">
    <div style="float:left;width:230px;height:450px;border-right:orange dotted thin">
      <ul>
        <li><label>Client:</label></li>
        <li><g:select name="clientId" from="${clientList}" value="${params.clientId}" optionKey="id" optionValue="name"/></li>
        <li style="padding-top:20px;"><label>Invoiced At</label></li>
        <li><g:select name="invoicedAt" from="${shops}" value="${params.invoicedAt}" optionKey="id" optionValue="name"/></li>
      </ul>
    </div>


    <div style="float:left;margin-left:20px;">
      <span id="message_box" style="text-align:center">
        <g:if test="flash.message">
          ${flash.message}
        </g:if>
      </span>
      <div>
        <ul id="voucherAddition">
          <li><label>Number Of Vouchers</label></li>
          <li><g:textField name="numberOfVouchers"/></li>
          <li><label>Voucher Denomination</label></li>
          <li><g:textField name="denomination"/></li>
          <li><input type="button" value="Add To List" onclick="addToVoucherList()"/></li>
        </ul>
      </div>
      <div id="voucherList">
        <div id="voucherListHeading">Voucher Creation List</div>
        <table id="voucherDetailsTable" style="margin-top:20px;margin-left:80px">
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
      <div style="margin-left:80px;margin-top:10px;"><g:submitButton name="Create" value="Create"/></div>

    </div>
  </g:form>
</div>
</html>