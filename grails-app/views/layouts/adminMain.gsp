<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Admin DashBoard</title>

  <link type="text/css" href="${resource(dir: 'css/ui-lightness', file: "jquery-ui-1.8.6.custom.css")}" rel=" Stylesheet"/>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-1.4.2.min.js")}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-ui-1.8.6.custom.min.js")}"></script>
  <script>
    $(function() {
      //Set Up The Menu
      $('#adminTabList').children().addClass('ui-state-default ui-corner-top ui-tabs-selected');

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

     /* //Setup the link
      $('ul.subnav li a').click(function () {
        $('#tabContent').load($(this).attr('href'))
        return false
      });*/

    })
    
  </script>

  <style type="text/css">
  .subnav {
    display: none;
  }

  ul.ui-tabs-nav li span.subhover {
    background-color: orange;
    background-position: center bottom bottom;
    cursor: pointer;
  }

  ul.ui-tabs-nav li ul.subnav {
    position: absolute;
    lef: 0;
    top: 35px;
    background: #333;
    float: left;
  }

  ul.ui-tabs-nav li span {
    width: 17px;
    height: 35px;
    float: left;
    background: url(/MGifts/images/downarrow.gif) no-repeat center top;
  }

  ul.ui-tabs-nav li ul.subnav li {
    margin: 0;
    padding: 0;
    border-top: 1px solid #252525; /*--Create bevel effect--*/
    border-bottom: 1px solid #444; /*--Create bevel effect--*/
    clear: both;
    width: 170px;
  }
  </style>
</head>
<body>
<div id="adminTab" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
  <ul id="adminTabList" class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
    <li>
      <a href="#">Voucher</a>
      <ul class="subnav">
        <li><g:link controller="voucher">Create Voucher</g:link></li>
        <li><a href="#">Sub Nav1</a></li>
      </ul>
    </li>
    <li>
      <a href="#">Client Management</a>
      <ul class="subnav">
        <li><g:link controller="client">Add a Client</g:link> </li>
        <li><a href="#">Sub Nav1</a></li>
      </ul>
    </li>
    <li>
      <g:link controller="admin" action="client" title="tabContent">Nav2</g:link>
      <ul class="subnav">
        <li><a href="#">Sub Nav1</a></li>
        <li><a href="#">Sub Nav1</a></li>
      </ul>
    </li>
    <li id="logout"><g:link controller="logout">Logout</g:link></li>
  </ul>
  <div id="tabContent">
       <g:layoutBody />
  </div>
</div>

</body>
<script>
  loadThePage()
</script>
</html>