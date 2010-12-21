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

function getValueOf(elementId) {
    return $('#' + elementId).val()
}

function isNumeric(elementId) {
    return getValueOf(elementId).match(/^\d*$/)
}

function isDouble(elementId){    
    return getValueOf(elementId).match(/^[-]?([1-9]{1}[0-9]{0,}(\.[0-9]{0,2})?|0(\.[0-9]{0,2})?|\.[0-9]{1,2})$/)
}

function bindRemoveClickHandlerForTableRow(tableId) {
    $("#" + tableId).find("input:button").unbind('click');
    $("#" + tableId).find("input:button").click(function() {
        $(this).parent().parent().remove()
    });
}

function validateMandatoryFields(fieldArray) {
    var isAllFieldsFilled = true;
    $.each(fieldArray, function(index, value) {
        if ($("#" + value).val() == "") {
            isAllFieldsFilled = false;
        }
    });
    return isAllFieldsFilled;
}

function validateDate(fieldName) {
    return $("#" + fieldName).val().match(/^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$/)
}

function areFieldsHoldingPriceValue(fieldArray) {
    var isDouble = true;
    $.each(fieldArray, function(index, value) {
        if (!$("#" + value).val().match(/^\d*.?\d?\d?$/)) {
            isDouble = false;
            return false;
        }
    })
    return isDouble
}