<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<script type="text/javascript">
  $(function() {
    var currentDate = new Date()
    var dateAsString = currentDate.getFullYear() + '-' + (currentDate.getMonth() + 1) + '-' + currentDate.getDate();
    $('#datePickerSpan').DatePicker({
      flat: true,
      date: dateAsString,
      current: dateAsString,
      calendars: 1,
      starts: 1
    });
  })
  function validateSubmitForm() {
    if ($("#clientId").attr('selectedIndex') == 0) {
      $("#clientSelectLi").css('color', 'red');
      return false
    }
    $('#dateToSearch').val($('#datePickerSpan').DatePickerGetDate(true))
    return true;
  }
  function selectAll() {
    $('input:checkbox').attr('checked', true)
  }
  function unSelectAll() {
    $('input:checkbox').attr('checked', false)
  }
  function printBarCode() {
    if ($('input:checkbox').is(':checked')) {
      $('form').attr('action', function() {
        return $('#printLink').attr('href')
      })
      $('form').submit()
    } else {
      $("#message_box").html("Please select the voucher(s) to be printed")
    }
    return false;
  }
</script>

<div id="voucherHistoryMainContent" style="height:500px;margin-top:40px;margin-left:30px;">
<div id="normal_left_nav">
  <g:form action="getHistory" name="historyForm" onsubmit="return validateSubmitForm()">
    <ul style="list-style:none;margin-left:-40px;margin-top:50px;">
   <li>
     <li style="text-align:center;">Select the date</li>
     <li><span id="datePickerSpan"></span></li>
   </li>
   <li style="text-align:center;margin-top:40px;" id="clientSelectLi">Select the client</li>
   <li style="text-align:center">
    <g:select name="clientId" value="{clientId}" style="width:150px" from="${clientList}"
            noSelection="['-1':'---------Select---------']" optionKey="id" optionValue="name"/>
    </li>
    <li style="text-align:center;margin-top:30px;">
      <g:submitButton name="sumit" style="width:150px;" value="Search Vouchers"/>
    </li>
    </ul>
    <g:hiddenField name="dateToSearch"/>

    </div>
<div id="normal_right_content">
<span id="message_box" style="text-align:center"></span>
<div>
  <table id="voucherHistoryTable">
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

      <span style="float:right"><g:link controller="voucher" action="print" elementId="printLink" onclick="return printBarCode()">Print Barcode</g:link></span>

    </div>
  </g:form>
</div>
</div>
</body>
</html>