<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Admin DashBoard</title>

  <link type="text/css" href="${resource(dir: 'css/ui-lightness', file: "jquery-ui-1.8.6.custom.css")}" rel=" Stylesheet"/>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-1.4.2.min.js")}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-ui-1.8.6.custom.min.js")}"></script>

  <!-- Loads for Date-->
  <link rel="stylesheet" media="screen" type="text/css" href="/MGifts/css/datepicker.css"/>
  <script type="text/javascript" src="/MGifts/js/datepicker.js"></script>
  <script>
    $(function() {
      //Set Up The Menu
      $('#adminTabList').children().addClass('ui-state-default ui-corner-top ui-tabs-selected');
      $('ul.subnav li a').removeClass('ui-tabs-nav');
      $('ul.subnav li a').css('cursor', 'pointer');
      $('#logout a').css('cursor', 'pointer');
      $('ul.subnav').parent().append('<span></span>');

      $('ul.ui-tabs-nav li span').click(function() {
        $(this).parent().find("ul.subnav").slideDown('fast').show();

        $(this).parent().hover(function() {
        }, function() {
          $(this).parent().find("ul.subnav").slideUp('slow'); //When the mouse hovers out of the subnav, move it back up
        });

      }).hover(function() {
        $(this).addClass("subhover");
      }, function() {
        $(this).removeClass("subhover");
      });
    })


    function validateMandatoryFields() {
      var isAllFieldsFilled = true;
      $("span.mandotry").each(function() {
        var mandotoryTextBox = $(this).parent().parent().find("input:text");
        if (mandotoryTextBox.val() == "") {
          isAllFieldsFilled = false;
        }
      });
      if (!isAllFieldsFilled) {
        $("#message_box").html('Mandatory fields are not filled!!')
      }
      return isAllFieldsFilled;
    }

  </script>

  <style type="text/css">
  .subnav {
    display: none;
  }

  ul.ui-tabs-nav li {
    width: 220px;
  }

  ul.ui-tabs-nav li span.subhover {
    margin-top: 5px;
    height: 30px;
    background-image: url('/MGifts/images/arrow_rover.gif');
    cursor: pointer;
  }

  ul.ui-tabs-nav li ul.subnav {
    position: absolute;
    top: 40px;
    background: #F6F6F6;
    float: right;
    margin-left: 50px;
    list-style: none;
  }

  ul.ui-tabs-nav li span {
    width: 20px;
    height: 35px;
    float: right;
    background: url(/MGifts/images/arrow.gif) no-repeat bottom;
  }

  ul.ui-tabs-nav li ul.subnav li {
    margin: 0;
    padding: 0;
    border-top: 1px dashed orange; /*--Create bevel effect--*/
    clear: both;
    width: 170px;
    margin-left: -40px;
  }

  .subNavLinks {
    float: right;
    cursor: pointer;

  }

  #message_box {
    color: red;
    font-family: verdana, arial, sans-serif;
    font-size: 12px;
    font-weight: normal;
    width: 313px;
    height: 30px;
    display: block;
    text-align: center;
  }

  .mandotry {
    color: red;
    float: right;
    margin-left: 5px;
  }

  #normal_left_nav {
    float: left;
    width: 200px;
    height: 500px;
    border-right: #ff4500 dotted thin;
    display: block;
    font-family: verdana, arial, sans-serif;
    font-size: 12px;
  }

  #normal_right_content {
    float:left;
    margin-left: 100px;
  }

  #adminTab {
    height: 600px;

  }

  #voucherHistoryTable {
    text-align: left;
    float: left;
    width:100%;
  }

  #voucherHistoryTable th {
    font-size: 18px;
    color: gray;
    width:140px;
    text-align:left;
  }

  #voucherTableLinks a {
    color:blue;
    font-family: verdana, arial, sans-serif;
    font-size:12;
  }

   #voucherHistoryTable thead tr{
     position:relative;
     display:block;
   }
  #voucherHistoryTable td{
    width:140px;
    text-align:left;
  }
  #voucherHistoryTable tbody{
     height:400px;
     display:block;
     overflow:auto;
     background-color:#f5f5f5;
   }
  </style>
</head>
<body>
<div id="adminTab" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
  <ul id="adminTabList" class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
    <li>
      <a href="#">Voucher</a>
      <ul class="subnav">
        <li><g:link controller="voucher" class="subNavLinks">Create Voucher</g:link></li>
        <li><g:link controller="voucher" action="barcodePage" class="subNavLinks">Barcode</g:link></li>
        <li><g:link controller="voucher" action="historyPage" class="subNavLinks">Voucher History</g:link></li>
      </ul>
    </li>
    <li>
      <a href="#">Client Management</a>
      <ul class="subnav">
        <li><g:link controller="client">Add a Client</g:link></li>
        <li><a href="#">Client List</a></li>
      </ul>
    </li>
    <li>
      <a href="#">User Management</a>
      <ul class="subnav">
        <li><g:link controller="user">Add User</g:link></li>
      </ul>
    </li>
  </li>
    <li id="logout" style="float:right;width:100px"><g:link style="float:right;" controller="logout">Logout</g:link></li>
  </ul>
  <div id="tabContent">
    <g:layoutBody/>
  </div>
</div>

</body>
</html>