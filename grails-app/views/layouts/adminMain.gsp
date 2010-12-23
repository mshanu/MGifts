<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>breigns - VMS</title>
  <LINK REL="SHORTCUT ICON" HREF="${resource(dir: 'images', file: 'favicon.ico')}">
  <link type="text/css" href="${resource(dir: 'css/ui-lightness', file: "jquery-ui-1.8.6.custom.css")}" rel=" Stylesheet"/>
  <link type="text/css" href="${resource(dir: 'css', file: "main.css")}" rel=" Stylesheet"/>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-1.4.2.min.js")}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-ui-1.8.6.custom.min.js")}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: "common.js")}"></script>

  <script>
    $(function() {
      //Set Up The Menu
      $('#adminTabList').children().addClass('ui-state-default ui-corner-top ui-tabs-selected');
      $('ul.subnav li a').removeClass('ui-tabs-nav');
      $('ul.subnav li a').css('cursor', 'pointer');
      $('ul.subnav li').hover(function() {
        $(this).addClass('subNavLiHover')
      }, function() {
        $(this).removeClass('subNavLiHover')
      });

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
    -moz-border-radius: 4px;
    border-radius: 4px;
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

  .subNavLiHover {
    /*background-image: url('

  ${  resource(dir: 'images', file: "menu_hover.jpg")  }  ');*/
    background-color: #f0f8ff;
  }

  ul.ui-tabs-nav li ul.subnav {
    z-index: 2;
    position: absolute;
    top: 40px;
    background: #F6F6F6;
    float: right;
    list-style: none;
    width: 180px;
  }

  ul.ui-tabs-nav li span {
    width: 20px;
    height: 35px;
    float: right;
    background: url(${resource(dir: 'images', file: "arrow.gif")}) no-repeat bottom;
  }

  ul.ui-tabs-nav li ul.subnav li {
    padding: 0;
    border-top: 1px dashed orange; /*--Create bevel effect--*/
    clear: both;
    margin-left: -30px;
    width: 100%;
  }

  ul.ui-tabs-nav li ul.subnav li a {
    text-align: left;
  }

  .subNavLinks {
    float: right;
    cursor: pointer;

  }

  .mandotry {
    color: red;
    float: right;
    margin-left: 5px;
  }

  #adminTab {
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

  .staticHeader thead tr {
    position: relative;
    display: block;
  }

  .staticHeader thead tr th {
    text-align: center;
  }

  .staticHeader td {
    text-align: center;
  }

  .staticHeader tbody {
    display: block;
    overflow: auto;
    height: 400px;
  }

  #aggregatedVoucherStatus {
    float: left;
    width: 30%;
    height: 250px;
    margin-left: 2%;
    border: orange dotted thin;
  }

  #voucherReport {
    border: orange dotted thin;
    width: 30%;
    margin-left: 2%;
    height: 150px;
    float: left;
  }

  #invoiceReport {
    border: orange dotted thin;
    width: 30%;
    margin-left: 2%;
    height: 150px;
    float: left;
  }

  #aggregatedByShop {
    float: left;
    height: 250px;
    width: 60%;
    margin-left: 2%;
    overflow: auto;
    border: orange dotted thin;
  }

  #salesSnapshotTable {
    margin-left: 10px;
    padding: 25px;
  }

  #salesSnapshotTable tbody tr td {
    width: auto;
    text-align: left;
  }

  #salesSnapshotTable tbody tr label {
    width: 300;
  }

  #salesSnapshotTable tr td {
    padding: 5px;
  }

  #clientAddTable {
    margin-left: 30%;
    margin-top: 5%;
  }

  #clientAddTable tr td {
    text-align: left;
  }

  #addUser {
    margin-left: 5px;
    margin-top: 2%;
    float: left;

  }

  #userList {
    margin-left: 5px;
    margin-top: 2%;
    float: left;
    width: 800px;

  }

  #userList table thead tr td {
    width: 100px;
  }

  #userTable tr td {
    text-align: left;

  }

  </style>
</head>
<body>
<div>
  <div id="adminTab" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
    <ul id="adminTabList" class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
      <li>
        <a href="#">Voucher</a>
        <ul class="subnav">
          <li><g:link controller="admin" action="voucherReportPage" class="subNavLinks">Sales Report</g:link></li>
          <li><g:link controller="admin" action="createNewVoucherRequestPage" class="subNavLinks">New Voucher Request</g:link></li>
          <li><g:link controller="admin" action="voucherRequestsPage" class="subNavLinks">Voucher Requests</g:link></li>
          <li><g:link controller="admin" action="searchToDeletePage" class="subNavLinks">Delete Vouchers</g:link></li>
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
  </div>
  <div id="tabContent">
    <div id="reportLoading" class="loading"><img src="${resource(dir: 'images', file: 'loader.gif')}" alt=""/></div>
    <g:layoutBody/>
  </div>
</div>
</body>
</html>