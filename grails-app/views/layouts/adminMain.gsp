<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>breigns - VMS</title>

  <link type="text/css" href="${resource(dir: 'css/ui-lightness', file: "jquery-ui-1.8.6.custom.css")}" rel=" Stylesheet"/>
  <link type="text/css" href="${resource(dir: 'css', file: "main.css")}" rel=" Stylesheet"/>
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



  .loading {
    position: absolute;
    display: none;
    border: 1px solid #5c9ccc;
    padding: 2px;
    background-color: #5c9ccc;
    color: #ffffff;
    opacity: 0.90;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    width: 100px;
    height: 50px;
    text-align: center;
    z-index: 100000;
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
    width: 32%;
    height: 250px;
    margin-left: 1%;
    border: orange dotted thin;
  }

  #aggregatedByShop {
    float: left;
    height: 250px;
    margin-left: 4%;
    width: 58%;
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

  #addUserTable {
    margin-left: 30%;
    margin-top: 5%;
  }

  #addUserTable tr td {
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
  </div>
  <div id="tabContent">
    <div id="reportLoading" class="loading"><img src="${resource(dir: 'images', file: 'loader.gif')}" alt=""/></div>
    <g:layoutBody/>
  </div>
</div>
</body>
</html>