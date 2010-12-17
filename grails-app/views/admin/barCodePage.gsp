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
    $("form").attr('action', 'printBarCodeForClient')
    $("form").submit()

  }
  function validateAndSubmitToGetVouchers() {
    $("form").attr('action', 'getCreatedVouchers')
    $("form").submit()
  }
</script>

<div>
  <g:form action="getCreatedVouchers" name="barCodeForm">
    <div class="leftNav">
      <ul class="leftNavUL">
        <li id="clientSelectLi">Client</li>
        <li>
          <g:select name="clientId" value="${selectedClient?.id}" from="${clientList}"
                  optionKey="id" optionValue="name"/>
        </li>
        <li>
          <input type="button" style="width:150px;" value="Search Vouchers" onclick="validateAndSubmitToGetVouchers()"/>
        </li>
      </ul>
      <g:hiddenField name="dateToSearch"/>
    </div>
    <div class="rightContent">
      <div id="message_box" style="text-align:center">
        <g:if test="flash.message">
          ${flash.message}
        </g:if>
      </div>
      <div>
        <table>
          <thead>
          <tr>
            <th style="width:300px;">Client Name</th>
            <th style="width:300px;">SQ # Range</th>
            <th>Value</th>
            <th>Status</th>
            <th>Created By</th>
            <th>Action</th>
          </tr>
          </thead>
          <tbody>
          <g:each in="${voucherGroupList}">
            <tr>
              <td style="width:300px;">${it.client.name}</td>
              <td style="width:300px;">${it.sequenceRange}</td>
              <td>${it.value}</td>
              <td>${it.status}</td>
              <td>${it.createdBy.firstName},${it.createdBy.lastName}</td>
              <td><input type="button" value="Generate Bar Code" onclick="printBarCode(${it.client.id}, ${it.sequenceStart}, ${it.sequenceEnd})"/></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <g:hiddenField name="clientIdForBarcode"/>
      <g:hiddenField name="sequenceStart"/>
      <g:hiddenField name="sequenceEnd"/>
    </div>
  </g:form>
</div>
</body>
</html>