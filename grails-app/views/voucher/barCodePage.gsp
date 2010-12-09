<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<script type="text/javascript">
  function printBarCode(clientId, sequenceStart, sequenceEnd) {
    $("#clientIdForBarcode").val(clientId)
    $("#sequenceStart").val(sequenceStart)
    $("#sequenceEnd").val(sequenceEnd)
    $("form").attr('action','printBarCodeForClient')
    $("form").submit()

  }
</script>

<div id="voucherHistoryMainContent" style="height:500px;margin-top:40px;margin-left:30px;">
<div id="normal_left_nav">
  <g:form action="getCreatedVouchers" name="barCodeForm" onsubmit="return validateSubmitForm()">
    <ul style="list-style:none;margin-left:-40px;margin-top:50px;">
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
<div>
  <table id="voucherHistoryTable">
    <thead>
    <tr>
      <th>Client Name</th>
      <th>SQ Number Range</th>
      <th>Value</th>
      <th>Status</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${voucherGroupList}">
      <tr>
        <td>${it.clientName}</td>
        <td>${it.sequenceRange}</td>
        <td>${it.value}</td>
        <td>${it.status}</td>
        <td><input type="button" value="Generate Bar Code" onclick="printBarCode(it.clientId, it.sequenceStart, it.sequenceEnd)"/></td>
      </tr>
    </g:each>
    </tbody>
   </table>
 </div>
    <g:hiddenField name="clientIdForBarcode"/>
    <g:hiddenField name="sequenceStart"/>
    <g:hiddenField name="sequenceEnd"/>
  </g:form>
</div>
</div>
</body>
</html>