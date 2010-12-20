<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<h2 style="border-bottom:orange dotted thin;text-align:center;padding:5px;">Voucher Sales Report</h2>
<div style="width:100%;height:270px;display:block">
  <div id="aggregatedVoucherStatus">
    <h3 style="margin-top:10px;">Sales Snapshot</h3>
    <table id="salesSnapshotTable">
      <tr>
        <td><label>Voucher Sale As Of Now</label></td>
        <td>${reportModel?.vocuherStatusReport?.totalSoldValue}</td>
      </tr>
      <tr>
        <td><label># of Vouchers Sold As Of Now</label></td>
        <td>${reportModel?.vocuherStatusReport?.sold}</td>
      </tr>
      <tr>
        <td><label>Vouchers Validated As Of Now</label></td>
        <td>${reportModel?.vocuherStatusReport?.totalValidatedValue}</td>
      </tr>
      <tr>
        <td><label># of Vouchers Validated As Of Now</label></td>
        <td>${reportModel?.vocuherStatusReport?.validated}</td>
      </tr>
    </table>
  </div>
  <div id="aggregatedByShop">
    <h3 style="margin-top:10px;">Sales Snapshot Per Shop</h3>
    <table class="staticHeader">
      <thead>
      <tr>
        <th>Shop Name</th>
        <th>Sold (Rs)</th>
        <th>Sold #</th>
        <th>Validated (Rs)</th>
        <th>Validated #</th>
      </tr>
      </thead>
      <g:if test="${reportModel}">
        <tbody style="height:300px;">
        <g:each in="${reportModel.voucherSaleByShop}">
          <tr>
            <td>${it.shop.name}</td>
            <td>${it.totalSoldValue}</td>
            <td>${it.sold}</td>
            <td>${it.totalValidatedValue}</td>
            <td>${it.validated}</td>
          </tr>
        </g:each>
        </tbody>
      </g:if>
    </table>
  </div>
</div>
<div>
  <div id="voucherReport">
    <h3 style="margin-top:10px;">Voucher Sales</h3>
    <g:form action="voucherReport" controller="report">
      <table>
        <tr>
          <td style="text-align:left">Client:</td>
          <td><g:select from="${clients}" name="clientId" optionKey="id" optionValue="name"/></td>
        </tr>
        <tr>
          <td style="text-align:left">Voucher Status:</td>
          <td>
            <g:select from="${voucherStatus}" name="status" optionKey="key" optionValue="description"/>
          </td>
        </tr>
        <tr>
          <td></td>
          <td style="text-align:left">
            <g:submitButton name="report" value="Generate Report"/>
          </td>
        </tr>
      </table>
    </g:form>
  </div>
  <div id="invoiceReport">
    <h3 style="margin-top:10px;">Sales By Shop</h3>
    <g:form action="invoiceReport" controller="report">
      <table>
        <tr>
          <td style="text-align:left">Shop:</td>
          <td><g:select from="${shops}" name="shopId" optionKey="id" optionValue="name"/></td>
        </tr>
        <tr>
          <td></td>
          <td style="text-align:left">
            <g:submitButton name="report" value="Generate Report"/>
          </td>
        </tr>
      </table>
    </g:form>
  </div>
</div>
</body>
</html>