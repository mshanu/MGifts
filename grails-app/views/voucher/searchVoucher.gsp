<html>
<head></head>
<body>
<script type="text/javascript">
  function validateVoucherSearch() {
    if (!validateVoucherSearchWith("clientInitials", "sequenceNumber", "barcode")) {
      return false;
    }
    var searchButton = $("#searchButton")
    searchButton.attr('disabled', 'true')
    $.post($("#link").attr("href"), {sequenceNumber:getValueOf('sequenceNumber'),barcode:getValueOf('barcode'),clientInitials:getValueOf('clientInitials')},
            function(data) {
              searchButton.removeAttr('disabled')
              $("#searchResult").html(data)
            })
  }

</script>
<div>
  <div class="leftNav">
    <ul class="leftNavUL">
      <li>
        <label>Bar Code:</label>
      </li>
      <li>
        <g:textField name="barcode"></g:textField>

      </li>
      <li>
        <label>Sequence Number:</label>
      </li>
      <li>
        <g:textField name="clientInitials" maxlength="3" style="width:50px"></g:textField>
        <g:textField name="sequenceNumber" style="width:140px;"></g:textField>
      </li>
      <li>
        <g:link controller="voucher" action="validate" style="display:hidden" elementId="link"/>
        <input type="button" id="searchButton" value="Validate Voucher" onclick="validateVoucherSearch()"/>

      </li>
    </ul>
  </div>
  <div id="searchResult" class="rightContent">
    <div id="message_box" style="text-align:center">
      <g:if test="flash.message">
        ${flash.message}
      </g:if>
    </div>
  </div>
</div>
</body>
</html>