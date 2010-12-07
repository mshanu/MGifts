<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<div style="margin-top:10%; margin-left:35%;">
  <g:form action="insert" controller="voucher">
    <table>
      <tr>
        <td><label>Client</label></td>
        <td><g:select name="clientId" from="${clientList}" optionKey="id" optionValue="name"/></td>
      </tr>
      <tr>
        <td><label>Number of vouchers</label></td>
        <td><g:textField name="numberOfVouchers"/></td>
      </tr>
      <tr>
        <td><label>Voucher Value in Rs:</label></td>
        <td><g:textField name="voucherValue"/></td>
      </tr>
      <tr>
        <td><g:submitButton name="Create" value="Save"/></td>
      </tr>
    </table>
  </g:form>
</div>
</html>