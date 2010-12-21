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
  margin-left: 20%;
  margin-right: 20%;
  height: 250px;
  overflow-y: auto;
}

h3 {
  text-align: left;
  border-bottom: orange dashed thin;

}

#invoiceTable {
  margin-left: 15%;
}

#invoiceTable tr td {
  text-align: left;
}

#voucherSearchTable {
  margin-left: 15%;
}

#voucherSearchTable tr td {
  text-align: left;
}
</style>
<script type="text/javascript">
  function validateAndAddVoucher() {
    if (!validateVoucherSearchWith('clientInitials', 'voucherSequenceNumber', 'barcode')) {
      return false;
    }
    $("#loadingDiv").css('display','block')
    $.post($("#validateAndAddVoucherLink").attr('href'),
    {sequenceNumber:getValueOf('voucherSequenceNumber'),
      barcode:getValueOf('barcode'),clientInitials:getValueOf('clientInitials')},
            function(data) {
              $("#loadingDiv").css('display','none')
              if (data != 'FAILURE') {

                if ($("#voucherId").length == 0 || !isVoucherAlreadyPresent('voucherId', data.id)) {
                  $('#voucherTable tr:last').after('<tr><td><input type="hidden" id="voucherId" name="voucherId" value="' + data.id + '"/>' + data.sequenceNumber + '</td><td>' + data.barcodeAlpha + '</td><td>' + data.voucherRequest.client.name + '</td><td>' + data.value + '</td><td><input type="button" value="X"></td></tr>')
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

  function isVoucherAlreadyPresent(voucherId, valueToBeCompared) {
    var isPresent = false;
    $.each($.find('#voucherId'), function() {
      if ($(this).val() == valueToBeCompared) {
        isPresent = true;
        return false;
      }
    })
    return isPresent;
  }

  function validateAndSubmitInvoice() {
    if (!validateMandatoryFields(['invoiceNumber','invoiceDate','totalAmount','discount','netTotal'])) {
      $("#message_box").html("All Mandotory Fields Need To Be Filled To Submit Invoice")
      return false;
    }
    if (!validateDate("invoiceDate")) {
      $("#message_box").html("Invalid Date - Date Should Be Entered in dd/mm/yyyy")
      return false;
    }
    if (!areFieldsHoldingPriceValue(['totalAmount','netTotal','discount'])) {
      $("#message_box").html("Total,Discount,NetTotal should have proper values")
      return false;
    }
    if (!isNumeric("invoiceNumber")) {
      $("#message_box").html("Invoice Number Should Be Numeric")
      return false
    }
    if ($("#voucherId").length == 0) {
      $("#message_box").html("Atleast One Voucher Should Be Added To Invoice")
      return false

    }
    $.post($("#submitInvoiceLink").attr('href'), $('form').serialize(), function() {
      $("#message_box").html("Invoice Submitted Successfully")
      $("input:text").val("")
      $("#voucherTable").find('tr:gt(0)').remove()

    });

  }
</script>
<form style="margin:0px;padding:0px;">
  <div id="message_box" style="text-align:center;width:100%;margin-top:0px;">
    <g:if test="flash.message">
      ${flash.message}
    </g:if>
  </div>
  <div id="invoiceMainContent">
    <h3 style="margin:2px;">Invoice</h3>
    <table id="invoiceTable">
      <tr>
        <td>Invoice Number<span class="mandotry">*</span></td>
        <td><g:textField name="invoiceNumber"></g:textField></td>
        <td>Date(dd/mm/yyy)<span class="mandotry">*</span></td>
        <td><g:textField name="invoiceDate"></g:textField></td>
      </tr>
      <tr>
        <td>Total<span class="mandotry">*</span></td>
        <td><g:textField name="totalAmount" class="numeric"></g:textField></td>
        <td>Discount<span class="mandotry">*</span></td>
        <td><g:textField name="discount" class="numeric"></g:textField></td>
      </tr>
      <tr>
        <td>Net Total<span class="mandotry">*</span></td>
        <td><g:textField name="netTotal" class="numeric"></g:textField></td>
        <td>Item<span class="mandotry">*</span></td>
        <td><g:select from="${items}" name="item" optionKey="id" optionValue="description"></g:select></td>
      </tr>
    </table>
    <div style="border-top:orange dashed thin;margin-top:5px;"></div>
    <div style="margin-top:5px;">
      <table id="voucherSearchTable">
        <tr>
          <td>BarCode</td>
          <td><g:textField name="barcode"></g:textField></td>
          <td>Voucher Seq #</td>
          <td>
            <g:textField name="clientInitials" maxlength="3" style="width:40px;"></g:textField>
            <g:textField name="voucherSequenceNumber" style="width:150px;"></g:textField>
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
      <div style="margin-left:45%;padding-top:5px;"><input type="button" value="Submit Invoice" onclick="validateAndSubmitInvoice()"></div>
    </div>
  </div>
  <g:link controller="voucher" action="validateAndGetVoucher" elementId="validateAndAddVoucherLink"></g:link>
  <g:link controller="voucher" action="submitInvoice" elementId="submitInvoiceLink"></g:link>
</form>
</body>
</html>