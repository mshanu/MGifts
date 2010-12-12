<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<body>
<script type="text/javascript">

  function validateMandatoryFields() {
    var isAllFieldsFilled = true;
    $.each(["invoiceNumber","invoiceDate","totalAmount","discount","netTotal"], function(index, value) {
      if ($("#" + value).val() == "") {
        isAllFieldsFilled = false;
      }
    });
    return isAllFieldsFilled;
  }

  function checkNumericFields() {
    var allNumeric = true
    $(".numeric").each(function() {
      if (!$(this).val().match(/^\d*$/)) {
        allNumeric = false;
      }
    })
    return allNumeric
  }

  function voucherSell() {
    $("#message_box").html("")
    if (validateMandatoryFields()) {
      if (!$("#invoiceDate").val().match(/^(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d$/)) {
        $("#message_box").html('Date fomat is invalid')
      }
      if (checkNumericFields()) {
        var sellButton = $("#sellButton")
        sellButton.attr('disabled','true');
        var url = $("#sellUrl").attr("href");
        $.post(url, {voucherId:getValue("voucherId"),invoiceNumber:getValue("invoiceNumber"),
          invoiceDate:getValue("invoiceDate"),totalAmount:getValue("totalAmount"),discount:getValue("discount"),
          netTotal:getValue("netTotal"),itemId:getValue('item')},
                function(data) {
                  sellButton.removeAttr('disabled')
                  $("#voucherToSell").html(data)
                })
      }
      else {
        $("#message_box").html('Total, Discount, Net Total should be numeric')
        return false;
      }


      /*var voucheId = $("#voucherId").val()

       */
    } else {
      $("#message_box").html('Please fill all mandatory fields')
      return false;
    }


  }
  function getValue(name){
    return $("#"+name).val()
  }
</script>
<div id="voucherToSell">
  <span id="voucherToSell_msg" style="color: red;font-weight: normal;margin-left:20%;margin-top:30px;">
    <g:if test="flash.message">
      ${flash.message}
    </g:if>
  </span>
  <g:if test="${voucherFound}">
    <table>
      <tr>
        <tr>
        <td colspan="4" style="text-align:center">Voucher Details</td>
      </tr>
        <td>Sequence Number</td>
        <td><input disabled="true" value="${voucher.generatedSequence}"/></td>
    <td style="text-align:center">Bar Code</td>
    <td><input disabled="true" value="${voucher.barcodeAlpha}"/></td>
    </tr>
    <tr>
      <td>Value</td>
      <td><input disabled="true" value="${voucher.value}"/></td>
      <td style="text-align:center">Company Name</td>
      <td><input disabled="true" value="${voucher.client.name}"/></td>
    </tr>
    <tr>
      <td colspan="4" style="text-align:center">Invoice Details</td>
    </tr>
    <tr>
      <td>Invoice Number<span class="mandotry">*</span></td>
      <td><g:textField name="invoiceNumber"></g:textField></td>
      <td style="text-align:center">Date(mm/dd/yyy)<span class="mandotry">*</span></td>
      <td><g:textField name="invoiceDate"></g:textField></td>
    </tr>
    <tr>
      <td>Total<span class="mandotry">*</span></td>
      <td><g:textField name="totalAmount" class="numeric"></g:textField></td>
      <td style="text-align:center">Discount<span class="mandotry">*</span></td>
      <td><g:textField name="discount" class="numeric"></g:textField></td>
    </tr>
    <tr>
      <td>Net Total<span class="mandotry">*</span></td>
      <td><g:textField name="netTotal" class="numeric"></g:textField></td>
      <td style="text-align:center">Item<span class="mandotry">*</span></td>
      <td><g:select from="${items}" name="item" optionKey="id" optionValue="description"></g:select></td>
    </tr>
    <tr>
      <td colspan="4" style="text-align:center"><input id="sellButton" type="button" value="SELL" onclick="voucherSell()"/></td>
    </tr>
    </table>
    <g:hiddenField name="voucherId" value="${voucher.id}"/>
    <g:link controller="voucher" action="sell" elementId="sellUrl"/>
  </g:if>

</div>
</body>
</html>