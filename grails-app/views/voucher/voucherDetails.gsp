<g:if test="${voucherFound}">
  <div style="text-align:center">
    <h3 style="margin:20px;">Voucher Found</h3>
  </div>
  <table>
    <tr>
      <td style="text-align:left">Sequence Number</td>
      <td><input disabled="true" value="${voucher.generatedSequence}"/></td>
      <td style="text-align:left">Bar Code</td>
      <td><input disabled="true" value="${voucher.barcodeAlpha}"/></td>
    </tr>
    <tr>
      <td style="text-align:left">Value</td>
      <td><input disabled="true" value="${voucher.value}"/></td>
      <td style="text-align:left">Company Name</td>
      <td><input disabled="true" value="${voucher.client.name}"/></td>
    </tr>
    <tr>
      <td style="text-align:left">Valid Thru(dd/mm/yyyy)</td>
      <td><input disabled="true" value= <g:formatDate date="${voucher.validThru}" format="dd/MM/yyyy"/>></td>
      <td style="text-align:left">Remarks</td>
      <td><textarea disabled="true">${voucher.voucherInvoice.remarks}</textarea></td>
    </tr>
  </table>
  <g:hiddenField name="voucherId" value="${voucher.id}"/>
</g:if>
<g:elseif test="${voucherFound}">
  <div id="message_box" style="text-align:center">
    <g:if test="flash.message">
      ${flash.message}
    </g:if>
  </div>
</g:elseif>

