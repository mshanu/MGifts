<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<script type="text/javascript">

  function selectAll() {
    $('input:checkbox').attr('checked', true)
  }
  function unSelectAll() {
    $('input:checkbox').attr('checked', false)
  }
  function deleteVoucher() {
    if ($('input:checkbox').is(':checked')) {
      $('form').attr('action', function() {
        return $('#deleteLink').attr('href')
      })
      $('form').submit()
    } else {
      $("#message_box").html("Please select the voucher(s) to be printed")
    }
    return false;
  }

  function validateAndSubmit(){
    if($("#invoiceNumber").val()=="" || !$("#invoiceNumber").val().match(/^\d*$/)){
      $("#message_box").html("invoice Number Cannot Be Blank And Should Be Numeric")
      return false;
    }
    return true;
  }

</script>

<div id="voucherHistoryMainContent" style="height:500px;margin-top:40px;margin-left:30px;">
<div id="normal_left_nav">
  <g:form action="searchVoucherToDelete" name="historyForm" onsubmit="return validateAndSubmit()">
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
        <g:submitButton name="sumit" style="width:150px;" value="Search Vouchers"/>
      </li>
    </ul>
    </div>
<div id="normal_right_content">
<span id="message_box" style="text-align:center">
  <g:if test="${voucherList!=null}">
    ${voucherList.size()} Record Found
  </g:if>
  <g:if test="${flash.message}">
    ${flash.message}
  </g:if>
</span>
<div>
  <table id="voucherTrackingTable">
    <thead>
    <tr>
      <th style="width:30px"></th>
      <th>Client Name</th>
      <th>SQ Number</th>
      <th>Barcode</th>
      <th>Value</th>
      <th>Created Date</th>
      <th>Status</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${voucherList}">
      <tr>
        <td style="width:30px"><g:checkBox name="voucherSelected" value="${it.id}" checked="false"></g:checkBox></td>
        <td>${it.client.name}</td>
        <td>${it.generatedSequence}</td>
        <td>${it.barcodeAlpha}</td>
        <td>${it.value}</td>
        <td>${it.dateCreated}</td>
        <td>${it.status}</td>
      </tr>
    </g:each>
    </tbody>
   </table>
 </div>
    <div id="voucherTableLinks" style="padding:10px;">
      <span><a href="#" onclick="selectAll()">Select All</a></span>
      <span><a href="#" onclick="unSelectAll()">UnSelect All</a></span>
      <span style="float:right">
        <g:link controller="admin" action="deleteVouchers" elementId="deleteLink" onclick="return deleteVoucher()">Delete Voucher</g:link>
      </span>
    </div>
  </g:form>
</div>
</div>
</body>
</html>