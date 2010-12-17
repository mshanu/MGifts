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
<div id="editVoucher">
  <g:form action="editVouchersByInvoice" onsubmit="return validateSubmitForm()">
    <div class="leftNav">

      <ul class="leftNavUL">
        <li id="clientSelectLi">Client</li>
        <li>
          <g:select name="clientId" value="${params.clientId}" from="${clients}" optionKey="id" optionValue="name"/>
        </li>
        <li>Invoiced AT</li>
        <li>
          <g:select name="shopId" value="${params.shopId}" from="${shops}" optionKey="id" optionValue="name"/>
        </li>
        <li>Invoice Number</li>
        <li>
          <g:textField name="invoiceNumber" value="${params.invoiceNumber}"/>
        </li>
        <li>
          <g:link controller="admin" action="editVoucherSearch" elementId="searchVoucherInvoiceLink"></g:link>
          <input type="button" value="Search Voucher" onclick="validateAndSubmitForm('searchVoucherInvoiceLink')"/>
        </li>
      </ul>

    </div>
    <div class="rightContent">
      <div id="message_box" style="text-align:center;">
        <g:if test="flash.message">
          ${flash.message}
        </g:if>
      </div>
      <div>
        <g:if test="${voucherInvoice}">
          <table id="editVoucherTable" class="staticHeader">
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
            <tbody>
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
            </tbody>
          </table>
          <g:hiddenField name="voucherInvoiceId" value="${voucherInvoice.voucherInvoiceId}"/>
        </g:if>
      </div>
    </div>
  </g:form>
</div>
</body>
</html>