<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<g:form action="insert" controller="voucher">
  <table>
    <tr>
      <td><label>Client</label></td>
      <td><g:select name="voucherRequest.clientId" from="${clientList}" optionKey="id" optionValue="name"/></td>
    </tr>
    <tr>
      <td><label>Sequence Start</label></td>
      <td><g:textField name="voucherRequest.sequenceStart"/></td>
    </tr>
    <tr>
      <td><label>Sequence End</label></td>
      <td><g:textField name="voucherRequest.sequenceEnd"/></td>
    </tr>
    <tr>
      <td><label>Voucher Price</label></td>
      <td><g:textField name="voucherRequest.price"/></td>
    </tr>
    <tr>
      <td><g:submitButton name="Create" value="Save"/></td>
    </tr>
  </table>
</g:form>

</html>