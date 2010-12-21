<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<script type="text/javascript">
  function generateBarcode(voucherRequestId) {
    $("#voucherRequestId").val(voucherRequestId)
    $("form").attr('action', 'generateBarcode')
    $("form").submit()
  }

  function deleteVoucherRequest(voucherRequestId) {
    var isOkDelete = confirm("Are you sure you want to delete the voucher request?")
    if (isOkDelete) {
      var url = $("#deleteLink").attr("href");
      $.post(url, {'voucherRequestId':voucherRequestId}, function(data) {
        $("#message_box").html(data)
        $("#voucherRequests").html("")
      });
    }
  }

  function showInvoice(voucherRequestId) {
    $("#voucherRequestId").val(voucherRequestId)
    $("#invoice").dialog();
  }

  function invoice() {
    var url = $("#voucherInvoiceLink").attr("href");
    var voucherRequestId = $("#voucherRequestId").val()
    var shopId = $("#shopId").val()
    var discount = $("#discount").val()
    var remarks = $("#remarks").val()
    if (discount != "" && !isDouble('discount')) {
      $("#message_box").html("Discount field has invalid data")
    }
    $.post(url, {'voucherRequestId':voucherRequestId,'shopId':shopId,'remarks':remarks,discount:discount}, function(data) {
      $("#voucherRequests").html("")
      $("#message_box").html(data)
      $("#invoice").dialog('close')
    });
  }

  function searchVoucherRequest() {
    $("form").attr('action', 'getVoucherRequests')
    $("form").submit()
  }
</script>

<div>
  <g:form action="getVoucherRequests">
    <div class="leftNav">
      <ul class="leftNavUL">
        <li id="clientSelectLi">Client</li>
        <li>
          <g:select name="clientId" value="${selectedClient?.id}" from="${clients}"
                  optionKey="id" optionValue="name"/>
        </li>
        <li>
          <input type="button" name="search" value="Search Voucher Requests" onclick="searchVoucherRequest()">

        </li>
      </ul>
    </div>
    <div class="rightContent">
      <div id="message_box" style="text-align:center">
        <g:if test="flash.message">
          ${flash.message}
        </g:if>
      </div>
      <g:if test="${voucherRequestList}">
        <div id="voucherRequests">
          <div id="invoice" style="display:none">
            <table>
              <tr>
                <td>Invoice At:</td>
                <td><g:select from="${shops}" value="${shopId}" name="shopId" optionKey="id" optionValue="name"/></td>
              </tr>
              <tr>
                <td>Discount Given:</td>
                <td><g:textField name="discount"/></td>
              </tr>
              <tr>
                <td>Remarks:</td>
                <td><g:textArea name="remarks"/></td>
              </tr>
              <tr>
                <td></td>
                <td><input type="button" value="Invoice" onclick="invoice()"></td>
              </tr>
            </table>
            <g:link action="invoiceVoucherRequest" controller="admin" elementId="voucherInvoiceLink"/>
          </div>
          <table>
            <thead>
            <tr>
              <th>Client</th>
              <th>Request #</th>
              <th>Created Date</th>
              <th>SQ # Range</th>
              <th>Created By</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${voucherRequestList}">
              <tr>
                <td>${it.client.name}</td>
                <td>${it.id}</td>
                <td><g:formatDate date="${it.dateCreated}" format="dd/MM/yyyy"/></td>
                <td>${it.sequenceRange}</td>
                <td>${it.createdBy.firstName},${it.createdBy.lastName}</td>
                <td><input type="button" value="Generate Bar Code" onclick="generateBarcode(${it.id})"/></td>
                <td><input type="button" value="Invoice" onclick="showInvoice(${it.id})"/></td>
                <td><input type="button" value="Delete" onclick="deleteVoucherRequest(${it.id})"/></td>
              </tr>
            </g:each>
            </tbody>
          </table>
        </div>
      </g:if>
    </div>
    <input type="hidden" name="voucherRequestId" id="voucherRequestId">
    <g:link action="deleteVoucherRequest" controller="admin" elementId="deleteLink"/>
  </g:form>
</div>
</body>
</html>