<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Simple GSP page</title>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-1.4.2.min.js")}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: "jquery-ui-1.8.6.custom.min.js")}"></script>
  <script>
    $(function() {
      alert("hiiii")
      var url = $("#newVoucherLink").attr("href");
      $("#content").load(url);
    });

    $('a[id$="Link"]').click(function() {
      alert('Hi')
      $("#content").load($(this).attr('href'));
      return false;
    });
  </script>

</head>
<body>
<div id="voucherMainContent">
  <div id="linksMenu">
    <ul>
      <li>
        <g:link elementId="newVoucherLink" controller="voucher">
          New Voucher
        </g:link>
      </li>
      <li>
        <g:link elementId="voucherHistoryLink" controller="voucher">
          Voucher History
        </g:link>
      </li>
    </ul>
  </div>
  <div id="contentPanel">
    <div id="contentHeading">Create New Voucher</div>
    <div id="content"/>
  </div>
</div>
</body>
</html>