<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<body>
<style type="text/css">
#invoiceMainContent {
  height: 510px;
}

#voucherTable {
  margin-top: 5px;
}

#voucherTable tr th {
  width: 150px;
  text-align: center;

}

#voucherTable tr td {
  text-align: center;

}

#voucherTableDiv {
  border: orange dashed thin;
  margin-left: 25%;
  margin-right: 25%;
  height: 250px;
  overflow-y: auto;
}

h3 {
  text-align: left;
  border-bottom: orange dashed thin;
  
}

.invoiceTable td {
  width: 150px;
}
</style>
<script type="text/javascript">
  function validateAndAddVoucher() {
    if (!validateVoucherSearchWith('clientInitials', 'voucherSequenceNumber', 'barcode')) {
      return false;
    }
    $.post($("#validateAndAddVoucherLink").attr('href'),
    {sequenceNumber:getValueOf('voucherSequenceNumber'),
      barcode:getValueOf('barcode'),clientInitials:getValueOf('clientInitials')},
            function(data) {
              if (data != 'FAILURE') {

                if ($("#voucherId").length == 0 || !isVoucherAlreadyPresent('voucherId', data.id)) {
                  $('#voucherTable tr:last').after('<tr><td><input type="hidden" id="voucherId" name="voucherId" value="' + data.id + '"/>' + data.sequenceNumber + '</td><td>' + data.barcodeAlpha + '</td><td>' + data.client.name + '</td><td>' + data.value + '</td><td><input type="button" value="X"></td></tr>')
                  bindRemoveClickHandlerForTableRow('voucherTable')
                  $.each(["barcode","clientInitials","voucherSequenceNumber"], function(index, value) {
                    $('#' + value).val("")
                  });
                }
              } else {
                $("#message_box").html("Voucher is not found")
              }
            })
  }

  function isVoucherAlreadyPresent(voucherId, value) {
    var isPresent = false;
    $("#voucherId").each(function() {
      if ($(this).val() == value) {
        isPresent = true;
        return;
      }
    });
    return isPresent;
  }
</script>

<div id="invoiceMainContent">
  <span id="message_box" style="margin-left:35%;position:absolute">

  </span>
  <h3>Invoice</h3>
  <table class="invoiceTable" style="margin-left:25%">
    <tr>
      <td>Invoice Number<span class="mandotry">*</span></td>
      <td><g:textField name="invoiceNumber"></g:textField></td>
      <td style="text-align:right">Date(mm/dd/yyy)<span class="mandotry">*</span></td>
      <td><g:textField name="invoiceDate"></g:textField></td>
    </tr>
    <tr>
      <td>Total<span class="mandotry">*</span></td>
      <td><g:textField name="totalAmount" class="numeric"></g:textField></td>
      <td style="text-align:right">Discount<span class="mandotry">*</span></td>
      <td><g:textField name="discount" class="numeric"></g:textField></td>
    </tr>
    <tr>
      <td>Net Total<span class="mandotry">*</span></td>
      <td><g:textField name="netTotal" class="numeric"></g:textField></td>
      <td style="text-align:right">Item<span class="mandotry">*</span></td>
      <td><g:select from="${items}" name="item" optionKey="id" optionValue="description"></g:select></td>
    </tr>
  </table>
  <div style="border-top:orange dashed thin;margin-top:5px;"></div>
  <div style="margin-top:5px;">
    <table class="invoiceTable" style="margin-left:25%;">
      <tr>
        <td>BarCode</td>
        <td><g:textField name="barcode"></g:textField></td>
        <td style="text-align:right">Voucher Seq #</td>
        <td style="width:250px;">
          <span>
            <g:textField name="clientInitials" maxlength="3" style="width:40px;"></g:textField>
          </span>
          <span>
            <g:textField name="voucherSequenceNumber"></g:textField>
          </span>
        </td>
        <td><input type="button" value="Add Voucher" onclick="validateAndAddVoucher()"/></td>
      </tr>
    </table>
    <div id="voucherTableDiv">
      <table id="voucherTable">
        <tr>
          <th>Voucher Seq #</th>
          <th>BarCode</th>
          <th>Company Name</th>
          <th>Value</th>
          <th>Delete</th>
        </tr>
      </table>
    </div>
    <div  style="margin-left:45%;padding-top:5px;"><input type="button" value="Save The Invoice"></div>
  </div>
</div>
<g:link controller="voucher" action="validateAndGetVoucher" elementId="validateAndAddVoucherLink"></g:link>
</body>
</html>