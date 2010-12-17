<div id="message_box" style="text-align:center">
  <g:if test="flash.message">
    ${flash.message}
  </g:if>
</div>
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
  </table>
  <g:hiddenField name="voucherId" value="${voucher.id}"/>
</g:if>

