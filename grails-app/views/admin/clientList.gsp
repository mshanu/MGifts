<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>  
</head>
<body>
<div style="margin-left:30px;margin-top:20px;">
  <table id="clientListTable">
    <tr>
      <th>Client Name</th>
      <th>Client Initials</th>
      <th>Client Address</th>
      <th>City</th>
    </tr>
    <g:each in="${clientList}">
      <tr>
        <td>${it.name}</td>
        <td>${it.initials}</td>
        <td>${it.address}</td>
        <td>${it.city}</td>
      </tr>
    </g:each>
  </table>
</div>
</body>
</html>