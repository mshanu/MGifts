<script type="text/javascript">
  function selectAll() {
    $('input:checkbox').attr('checked', true)
  }
  function unSelectAll() {
    $('input:checkbox').attr('checked', false)
  }
</script>
<table class="staticHeader">
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
      <td>${it.voucherRequest.client.name}</td>
      <td>${it.generatedSequence}</td>
      <td>${it.barcodeAlpha}</td>
      <td>${it.value}</td>
      <td>${it.dateCreated}</td>
      <td>${it.status}</td>
    </tr>
  </g:each>
  </tbody>
</table>
<div id="voucherTableLinks" style="padding:10px;">
  <span><a href="#" onclick="selectAll()">Select All</a></span>
  <span><a href="#" onclick="unSelectAll()">UnSelect All</a></span>
  <span style="float:right">
    <g:link controller="admin" action="deleteVouchers" elementId="deleteLink" onclick="return deleteVoucher()">Delete Voucher</g:link>
  </span>
</div>