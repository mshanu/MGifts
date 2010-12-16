<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>breigns - VMS</title>

  <link type="text/css" href="${resource(dir: 'css/ui-lightness', file: "jquery-ui-1.8.6.custom.css")}" rel=" Stylesheet"/>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-1.4.2.min.js")}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-ui-1.8.6.custom.min.js")}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: "common.js")}"></script>

  <!-- Loads for Date-->
  <link rel="stylesheet" media="screen" type="text/css" href="${resource(dir: 'css', file: "datepicker.css")}"/>
  <script type="text/javascript" src="/${resource(dir: 'js', file: "datepicker.js")}"></script>
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
    background-image: url('${resource(dir: 'images', file: "arrow_rover.gif")}');
    cursor: pointer;
  }

  ul.ui-tabs-nav li ul.subnav {
    z-index: 2;
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
    background: url(${resource(dir: 'images', file: "arrow.gif")}) no-repeat bottom;
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

  #tabContent {
    font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
  }

  #tabContent select {
    width: 150px;
  }

  #message_box {
    color: red;
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
  }

  #normal_right_content {
    float: left;
    margin-left: 20px;
  }

  #adminTab {
    height: 600px;

  }

  #voucherTrackingTable {
    text-align: left;
    float: left;
    width: 100%;
  }

  #voucherTrackingTable th {
    color: gray;
    width: 120px;
    text-align: left;
  }

  #voucherTableLinks a {
    color: blue;
  }

  #voucherTrackingTable thead tr {
    position: relative;
    display: block;
  }

  #voucherTrackingTable td {
    width: 120px;
    text-align: left;
  }

  #voucherTrackingTable tbody {
    height: 400px;
    display: block;
    overflow: auto;
    background-color: #f5f5f5;
  }

  #voucherToSell_msg {
    color: red;
    width: 313px;
    height: 30px;
    display: block;
    text-align: center;

  }

  .numeric {

  }

  .mandatoryText {

  }

  #clientListTable th {
    width: 200px
  }

  #clientListTable td {
    width: 200px;
    text-align: center;
  }

  #editVoucherTable tr th {
    text-align: left;
    width: 150px;
  }

  #editVoucherTable tr td {
    width: 150px;
  }

  #aggregatedVoucherStatus {
    float: left;
    width: 32%;
    height: 300px;
    margin-left: 1%;
    border: orange dotted thin;
  }

  #aggregatedByShop {
    float: left;
    height: 300px;
    margin-left: 4%;
    width: 58%;
    overflow: auto;
    border: orange dotted thin;
  }

  #salesSnapshot {
    margin-left: 10px;
  }

  #salesSnapshot tr td {
    padding: 5px;
  }

  #salePerShop tbody {
    height: 200px;
    overflow-y: auto;
    overflow-x: hidden;
  }

  #salePerShop tr th {
    width: 200px;
    color: #00008b;

  }

  #salePerShop tr td {
    text-align: center;
  }
  </style>
</head>
<body>
<div id="adminTab" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
  <ul id="adminTabList" class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
    <li>
      <a href="#">Voucher</a>
      <ul class="subnav">
        <li><g:link controller="admin" action="voucherReportPage" class="subNavLinks">Voucher Report</g:link></li>
        <li><g:link controller="admin" action="createNewVoucherPage" class="subNavLinks">Create Vouchers</g:link></li>
        <li><g:link controller="admin" action="editVoucherPage" class="subNavLinks">Edit Vouchers</g:link></li>
        <li><g:link controller="admin" action="searchToDeletePage" class="subNavLinks">Delete Vouchers</g:link></li>
        <li><g:link controller="admin" action="barcodePage" class="subNavLinks">Barcode</g:link></li>
      </ul>
    </li>
    <li>
      <a href="#">Client Management</a>
      <ul class="subnav">
        <li><g:link controller="client">Add a Client</g:link></li>
        <li><g:link controller="admin" action="clientListPage">Client List</g:link></li>
      </ul>
    </li>
    <li>
      <a href="#">User Management</a>
      <ul class="subnav">
        <li><g:link controller="admin" action="addNewUserPage">Add User</g:link></li>
      </ul>
    </li>
    <li id="logout" style="float:right;width:100px"><g:link style="float:right;" controller="logout">Logout</g:link></li>
  </ul>
  <div id="tabContent">
    <g:layoutBody/>
  </div>
</div>

</body>
</html>