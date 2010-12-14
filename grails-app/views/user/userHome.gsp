<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>breigns - VMS</title>
  <link type="text/css" href="${resource(dir: 'css/ui-lightness', file: "jquery-ui-1.8.6.custom.css")}" rel=" Stylesheet"/>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-1.4.2.min.js")}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-ui-1.8.6.custom.min.js")}"></script>

  <!-- Loads for Date-->
  <link rel="stylesheet" media="screen" type="text/css" href="${resource(dir: 'css', file: "datepicker.css")}"/>
  <script type="text/javascript" src="/${resource(dir: 'js', file: "datepicker.js")}"></script>
  <script>
    $(function() {
      var logoutLink = $("#logoutLink").attr('href')
      $("#userTab").tabs();

      $("#logoutLink").unbind('click')
      $("#logoutLink").click(function() {
        window.location = logoutLink
      })
    });

  </script>

  <style type="text/css">
  #validateVoucherLeft {
    float: left;
    width: 200px;
    height: 500px;
    border-right: orange dashed thin
  }

  #validateVoucherRight {
    margin-left: 200px;
    height: 500px;
  }

  #validateVoucherLeft ul {
    list-style-type: none;
    margin-left: -45px;
  }

  #validateVoucherRight div table {
    padding: 100px;
  }

  #validateVoucherRight div table td {
    width: 150px;
    padding-bottom: 10px;
  }

  #message_box {
    color: red;
    font-family: verdana, arial, sans-serif;
    font-size: 16px;
    font-weight: normal;
    width: 400px;
    height: 30px;
    display: block;
    text-align: center;
  }

  .mandotry {
    color: red;
    float: right;
    margin-left: 5px;
  }

  </style>
  <script type="text/javascript" src="${resource(dir: 'js', file: "common.js")}"></script>
</head>
<body>
<div id="userTab">
  <ul>
    <li>
      <g:link controller="user" title="tabContent" action="index">Home</g:link>
    </li>
    <li>
      <g:link controller="voucher" title="tabContent" action="validateVoucherPage">Validate Voucher</g:link>
    </li>
    <li>
      <g:link controller="voucher" title="tabContent" action="invoice">Invoice Entry</g:link>
    </li>
    <li id="logout" style="float:right;width:100px"><g:link style="float:right;" elementId="logoutLink" controller="logout">Logout</g:link></li>
  </ul>
  <div id="tabContent" style="height:500px;">

  </div>
</div>

</body>
</html>