<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<script type="text/javascript">
  function populateVoucherRequests() {
    if ($("#clientId").val() != '-1') {
      var url = $("#retrieveVoucherLink").attr("href");
      $.getJSON(url, $('form').serialize(), function(data) {
        $("#voucherRequestId").fillSelect(data)
      });

    } else {
      $("#voucherRequestId").clearSelect()
    }
  }

  $.fn.clearSelect = function() {
    return this.each(function() {
      if (this.tagName == 'SELECT')
        this.options.length = 0;
    });
  }


  $.fn.fillSelect = function(data) {
    return this.clearSelect().each(function() {
      if (this.tagName == 'SELECT') {
        var dropdownList = this;
        $.each(data, function(index, optionData) {
          var option = new Option(optionData.key, optionData.value);

          if ($.browser.msie) {
            dropdownList.add(option);
          }
          else {
            dropdownList.add(option, null);
          }
        });
      }
    });
  }

  function searchVouchers() {
    var url = $("form").attr('action')
    $.post(url, $("form").serialize(), function(data) {
      $("#searchResult").html(data);
      $("#message_box").html("")
    });
  }

  function deleteVoucher() {
    if ($('input:checkbox').is(':checked')) {
      var url = $("#deleteLink").attr("href")
      $.post(url, $("form").serialize(), function(data) {
        $("#searchResult").html("");
        $("#message_box").html(data);
      });
    } else {
      $("#message_box").html("Please select the voucher(s) to be printed")
    }
    return false;
  }
</script>

<div id="voucherHistoryMainContent">
  <g:form action="searchVoucherToDelete" name="deleteSearchForm">
    <div class="leftNav">
      <ul class="leftNavUL">
        <li id="clientSelectList">Select the client</li>
        <li>
          <g:select name="clientId" value="${params.clientId}" from="${clients}" optionKey="id"
                  optionValue="name" noSelection="${['-1':'---Select Client---']}" onChange="populateVoucherRequests()"/>
          <g:link action="retrieveVouchersAsJson" controller="admin" elementId="retrieveVoucherLink"/>
        </li>
        <li>
          <g:select name="voucherRequestId" from="${voucherRequest}"/>
        </li>
        <li>
          <input type="button" value="Search Vouchers" onclick="searchVouchers()"/>
        </li>
      </ul>
    </div>
    <div class="rightContent">
      <div id="message_box" style="text-align:center;">
        <g:if test="${flash.message}">
          ${flash.message}
        </g:if>
      </div>
      <div id="searchResult">
      </div>
    </div>
  </g:form>
</div>
</body>
</html>