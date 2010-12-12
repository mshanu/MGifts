<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<script type="text/javascript">
  function validateSubmitForm() {
    if ($("#clientId").attr('selectedIndex') == 0) {
      $("#clientSelectLi").css('color', 'red');
      return false
    }
    return true;
  }

  function showInvoice() {

  }
</script>

<div id="voucherHistoryMainContent" style="height:500px;margin-top:10px;">
<div id="normal_left_nav">
  <g:form action="trackVoucher" onsubmit="return validateSubmitForm()">
    <ul style="list-style:none;margin-left:-40px;margin-top:50px;">
      <li style="text-align:center;margin-top:40px;" id="clientSelectLi">Select the client</li>
      <li style="text-align:center">
        <g:select name="clientId" value="${params?.clientId}" style="width:150px" from="${clientList}"
                noSelection="['-1':'---------Select---------']" optionKey="id" optionValue="name"/>
      </li>
      %{--<li style="text-align:center;margin-top:40px;">Status</li>
      <li style="text-align:center">
        <g:select name="status" value="${parasm?.status}" style="width:150px" from="${status}"  optionKey="key" optionValue="value"/>
      </li>--}%
      <li style="text-align:center;margin-top:30px;">
        <g:submitButton name="sumit" style="width:150px;" value="Search Vouchers"/>
      </li>
    </ul>

    </div>
<div id="normal_right_content">
<span id="message_box" style="text-align:center"></span>
<div>
  <table id="voucherTrackingTable">
    <thead>
    <tr>
      <th>SQ #</th>
      <th>Sold At</th>
      <th>Item</th>
      <th>Invoice #</th>
      <th>Invoice Date</th>
      <th>Total</th>
      <th>Discount</th>
      <th>Net Total</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${voucherList}">
      <tr>
        <td>${it.generatedSequence}</td>
        <td>${it.invoice.createdBy.firstName}</td>
        <td>${it.invoice.item.description}</td>
        <td>${it.invoice.invoiceNumber}</td>
        <td><g:formatDate format="MM/dd/yyy" date="${it.invoice.invoiceDate}"/></td>
        <td>${it.invoice.totalAmount}</td>
        <td>${it.invoice.discount}</td>
        <td>${it.invoice.netTotal}</td>
      </tr>
    </g:each>
    </tbody>
   </table>
 </div>
  </g:form>
</div>
</div>
</body>
</html>