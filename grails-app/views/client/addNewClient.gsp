
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="adminMain"/>
  </head>
  <body>
  <div style="margin-top:10%; margin-left:35%;">
  <g:form action="insert" controller="client">
    <table>
      <tr>
        <td><label>ClientName</label></td>
        <td><g:textField name="name" style="width:200px"/></td>
      </tr>
      <tr>
        <td><label>Initials</label></td>
        <td><g:textField name="initials" style="width:200px"/></td>
      </tr>
      <tr>
        <td><label>Address</label></td>
        <td><g:textArea name="address"/></td>
      </tr>
      <tr>
        <td><label>City</label></td>
         <td><g:textField name="city" style="width:200px"/></td>
      </tr>
      <tr>
         <td colspan="2"><g:submitButton name="Create" value="Save"/></td>
      </tr>
    </table>
  </g:form>
    </div>
  </body>
</html>