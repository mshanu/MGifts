<%@ page import="com.breigns.gift.Voucher" contentType="text/html;charset=UTF-8" %>
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
  function validateSubmitForm(){
    if($("#clientId").attr('selectedIndex')==0){
      $("#clientSelectLi").css('color','red');
      return false
    }
    $('#dateToSearch').val($('#datePickerSpan').DatePickerGetDate())
    return true;
  }
</script>
<div id="voucherHistoryMainContent" style="height:500px;margin-top:40px;margin-left:30px;">
  <div id="normal_left_nav">
    <g:form action="getHistory" onsubmit="return validateSubmitForm()">
      <ul style="list-style:none;margin-left:-40px;">
        <li>
          <li style="text-align:center;">Select the date</li>
          <li><span id="datePickerSpan"></span></li>
        </li>
        <li style="text-align:center;margin-top:40px;" id="clientSelectLi">Select the client</li>
        <li style="text-align:center">
      <g:select name="clientId" style="width:150px" from="${clientList}"
              noSelection="['-1':'---------Select---------']" optionKey="id" optionValue="name"/>
      </li>
      <li style="text-align:center;margin-top:30px;">
       <g:submitButton name="sumit" style="width:150px;" value="Search Vouchers"/> 
      </li>
      </ul>
      <g:hiddenField name="dateToSearch"/>
    </g:form>
  </div>
  <div id="normal_right_content">
  </div>
</div>
</body>
</html>