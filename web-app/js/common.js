function validateVoucherSearchWith(clientInitialsId, sequenceNumberId, barcodeId) {
    $("#message_box").html("")
    var sequenceNumber = $("#" + sequenceNumberId).val();
    var clientInitials = $("#" + clientInitialsId).val().toUpperCase();
    $("#clientInitials").val(clientInitials)

    var barCode = $("#" + barcodeId).val().toUpperCase();
    $("#barcode").val(barCode)
    if ((sequenceNumber + clientInitials) == "" && barCode == "") {
        $("#message_box").html("Enter either sequence number or barcode")
        return false;
    }
    if ((sequenceNumber == "" && clientInitials != "") || (sequenceNumber != "" && clientInitials == "")) {
        $("#message_box").html("Invalid Sequence Number")
        return false;
    }
    if (clientInitials !== "" && clientInitials.length < 3) {
        $("#message_box").html("Sequence Number starts with 3 alpha characters")
        return false;
    }
    if (!sequenceNumber.match(/^\d*$/)) {
        $("#message_box").html("Sequence Number Should Be Numeric")
        return false;
    }
    return true
}

function getValueOf(elementId){
    return $('#'+elementId).val()
}

function bindRemoveClickHandlerForTableRow(tableId) {
      $("#"+tableId).find("input:button").unbind('click');
      $("#"+tableId).find("input:button").click(function() {
        $(this).parent().parent().remove()
      });
    }