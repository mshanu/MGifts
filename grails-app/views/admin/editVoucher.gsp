<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<script type="text/javascript">
  function validateSubmitForm() {
    if ($("#invoiceNumber").val() == "" || !$("#invoiceNumber").val().match(/^\d*$/)) {
      $("#message_box").html("invoice Number Cannot Be Blank And Should Be Numeric")
      return false;
    }
    return true;
  }

  function validateAndSubmitForm(linkId) {
    if ($("#invoiceNumber").val() == "" || !$("#invoiceNumber").val().match(/^\d*$/)) {
      $("#message_box").html("invoice Number Cannot Be Blank And Should Be Numeric")
      return false;
    }
    $('form').attr('action', $("#" + linkId).attr('href'))
    $('form').submit()
  }

</script>

<div id="editVoucher" style="height:500px;margin-top:10px;">
<div id="normal_left_nav">
  <g:form action="editVouchersByInvoice" onsubmit="return validateSubmitForm()">
    <ul style="list-style:none;margin-left:-40px;margin-top:50px;">
      <li style="text-align:center;margin-top:40px;" id="clientSelectLi">Select the client</li>
      <li style="text-align:center">
        <g:select name="clientId" value="${params.clientId}" style="width:150px" from="${clients}" optionKey="id" optionValue="name"/>
      </li>
      <li style="text-align:center;margin-top:40px;">Invoiced AT</li>
      <li style="text-align:center">
        <g:select name="shopId" value="${params.shopId}" style="width:150px" from="${shops}" optionKey="id" optionValue="name"/>
      </li>
      <li style="text-align:center;margin-top:40px;">Invoice Number</li>
      <li style="text-align:center">
        <g:textField name="invoiceNumber" value="${params.invoiceNumber}"/>
      </li>
      <li style="text-align:center;margin-top:30px;">
        <g:link controller="admin" action="editVoucherSearch" elementId="searchVoucherInvoiceLink"></g:link>
        <input type="button" value="Search Voucher" onclick="validateAndSubmitForm('searchVoucherInvoiceLink')"/>
      </li>
    </ul>

    </div>
<div id="normal_right_content">
<span id="message_box" style="width:800px;margin-top:10px;text-align:center">
    <g:if test="${flash.message}">
      ${flash.message}
    </g:if>
    </span>
    <div>
      <g:if test="${voucherInvoice}">
        <table id="editVoucherTable">
          <thead>
          <tr>
            <th>Company Name</th>
            <th>Date Created</th>
            <th>Invoiced At</th>
            <th>Voucher Invoice#</th>
            <th>Change Invoicing To</th>
            <th>Action</th>
          </tr>
          </thead>
          <tr>
            <td>${voucherInvoice.client.name}</td>
            <td><g:formatDate format="dd/MM/yyyy" date="${voucherInvoice.dateCreated}"/></td>
            <td>${voucherInvoice.invoicedAt.name}</td>
            <td>${voucherInvoice.invoiceNumber}</td>
            <td>
              <g:select name="newShopId" style="width:150px" from="${shops}" optionKey="id" optionValue="name"/>
            </td>
            <td>
              <g:submitButton name="submit" value="Update"></g:submitButton>
            </td>
          </tr>
        </table>
        <g:hiddenField name="voucherInvoiceId" value="${voucherInvoice.voucherInvoiceId}"/>
      </g:if>
    </div>
  </g:form>
</div>
</div>
</body>
</html>