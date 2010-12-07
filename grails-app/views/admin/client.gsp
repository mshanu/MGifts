<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Simple GSP page</title>

  <style type="text/css">
  #links {
    margin-top: 10px;
    float: left;
    width: 250px;
    height: 550px;
    border-right: olive inset medium;

  }
  #contentPanel{
    border:black dashed thin;
    float:right;
    width:80%;
    height:550px;
    margin-left: 10px;
    margin-top: 10px;
  }
  #contentHeading{
    height:50px;
  }
  #content {
    border: orange dashed thin;
  }

  #links ul li {
    list-style-type: none;
    border-bottom: 1px groove #f5f5dc;
    margin-top: 15px;
    height: 25px;
    width: 200px;
  }

  #links ul li a {
    text-decoration: none;
    color: #555;
    font-family: Trebuchet MS;
    font-size: 90%;
    padding-bottom: 5px;
    display: block;
    padding-left: 10px;
  }

  #links ul li a:hover {
    background: #faebd7;
  }

  </style>

  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-1.4.2.min.js")}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-ui-1.8.6.custom.min.js")}"></script>
  <script>
    $(function() {
      var url = $("#newClientLink").attr("href");
      $("#content").load(url);
    });
     
    $('a[id$="Link"]').click(function() {
      $("#content").load($(this).attr('href'));
      return false;
    });
  </script>

</head>
<body>
<div id="voucherMainContent">
  <div id="links">
    <ul>
      <li>
        <g:link elementId="newClientLink" controller="client">
          New Client
        </g:link>
      </li>
      <li>
        <g:link elementId="clientHistoryLink" controller="client">
          Client History
        </g:link>
      </li>
    </ul>
  </div>
  <div id="contentPanel">
       <div id="contentHeading">Create New Client</div>
       <div id="content"/>
  </div>
</div>
</body>
</html>