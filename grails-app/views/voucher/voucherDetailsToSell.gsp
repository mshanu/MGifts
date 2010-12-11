<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<body>
<script type="text/javascript">
  function voucherSell() {
    var invoiceNumber = $("#invoiceNumber").val();
    var invoiceDate = $("#invoiceDate").val();

    if (invoiceNumber == "" || invoiceDate == "") {
      $("#voucherToSell_msg").html("Invoice Number and Date are mandatory to sell the voucher")
      return false;
    }
    //TODO: have to have more validation on date..

    var voucheId = $("#voucherId").val()
    var sellButton = $("#sellButton").val()
    var url = $("#sellUrl").attr("href");
    alert(url)
    $.post(url, {voucherId:voucheId,invoiceNumber:invoiceNumber,invoiceDate:invoiceDate},
            function(data) {
              sellButton.removeAttr('disabled')
              $("#voucherToSell").html(data)
            })
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
        <td>Invoice Number<span class="mandotry">*</span></td>
        <td><g:textField name="invoiceNumber"></g:textField></td>
        <td style="text-align:center">Invoice Date(mm/dd/yyy)<span class="mandotry">*</span></td>
        <td><g:textField name="invoiceDate"></g:textField></td>
      </tr>
      <tr>
        <td colspan="4" style="text-align:right"><input id="sellButton" type="button" value="SELL" onclick="voucherSell()"/></td>
      </tr>
    </table>
    <g:hiddenField name="voucherId" value="${voucher.id}"/>
    <g:link controller="voucher" action="sell" elementId="sellUrl"/>
  </g:if>

</div>
</body>
</html>