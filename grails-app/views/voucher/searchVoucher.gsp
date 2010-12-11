<html>
<head></head>
<body>
<script type="text/javascript">
  function validateVoucherSearch() {
    $("#message_box").html("")
    var sequenceNumber = $("#sequenceNumber").val();

    var clientInitials = $("#clientInitials").val().toUpperCase();
     $("#clientInitials").val(clientInitials)

    var barCode = $("#barcode").val().toUpperCase();
    $("#barcode").val(barCode)
    if ((sequenceNumber + clientInitials) == "" && barCode == "") {
      $("#message_box").html("Enter either sequence number or barcode")
      return false;
    }
    if ((sequenceNumber == "" && clientInitials != "") || (sequenceNumber != "" && clientInitials == "")) {
      $("#message_box").html("Invalid Sequence Number")
      return false;
    }
    if(clientInitials!=="" && clientInitials.length<3){
      $("#message_box").html("Sequence Number starts with 3 alpha characters")
      return false;
    }
    if(!sequenceNumber.match(/^\d*$/)){
      $("#message_box").html("Sequence Number Should Be Numeric")
      return false;
    }
    var searchButton = $("#searchButton")
    searchButton.attr('disabled','true')
    $.post($("#link").attr("href"), {sequenceNumber:sequenceNumber,barcode:barCode,clientInitials:clientInitials},
            function(data) {
              searchButton.removeAttr('disabled')
              $("#validateVoucherRight").html(data)
            })
  }
</script>
<div id="validateVoucherLeft">
  <ul style="list-style-type:none">
    <li>
      <label>Bar Code:</label>

    </li>
    <li>
      <g:textField name="barcode"></g:textField>

    </li>
    <li style="padding-top:15px;">
      <label>Sequence Number:</label>
    </li>
    <li>
      <g:textField name="clientInitials" maxlength="3" style="width:50px"></g:textField>
      <g:textField name="sequenceNumber" style="width:140px;"></g:textField>
    </li>
    <li style="padding-top:15px;">
      <g:if test="${link == 'validate'}">
        <g:link controller="voucher" action="validate" style="display:hidden" elementId="link"/>
        <input type="button" id="searchButton" value="Validate Voucher" onclick="validateVoucherSearch()"/>
      </g:if>
      <g:else>
        <g:link controller="voucher" action="searchToSell" style="display:hidden" elementId="link"/>
        <input type="button" id="searchButton" value="Search the voucher" onclick="validateVoucherSearch()"/>
      </g:else>

    </li>
  </ul>

  <div id="message_box" style="width:200px;text-align:left">
  </div>
</div>
<div id="validateVoucherRight">

</div>
</body>
</html>