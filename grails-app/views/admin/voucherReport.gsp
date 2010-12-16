<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<h4 style="border-bottom:orange dotted thin;text-align:center">Voucher Reports</h4>
<div>
  <div id="aggregatedVoucherStatus">
    <h4 style="text-align:center;margin-top:10px;">Sales Snapshot</h4>
    <table id="salesSnapshot">
      <tr>
        <td style="width:300px"><label>Voucher Sale As Of Now</label></td>
        <td>${reportModel?.vocuherStatusReport?.totalSoldValue}</td>
      </tr>
      <tr>
        <td style="width:300px"><label># of Vouchers Sold As Of Now</label></td>
        <td>${reportModel?.vocuherStatusReport?.sold}</td>
      </tr>
      <tr>
        <td style="width:300px"><label>Vouchers Validated As Of Now</label></td>
        <td>${reportModel?.vocuherStatusReport?.totalValidatedValue}</td>
      </tr>
      <tr>
        <td><label># of Vouchers Validated As Of Now</label></td>
        <td>${reportModel?.vocuherStatusReport?.validated}</td>
      </tr>
    </table>
  </div>
  <div id="aggregatedByShop">
    <h4 style="text-align:center;margin-top:10px;margin-bottom:5px;">Sales Snapshot Per Shop</h4>
    <table id="salePerShop">
      <tr>
        <th>Shop Name</th>
        <th>Sold (Rs)</th>
        <th>Sold #</th>
        <th>Validated (Rs)</th>
        <th>Validated #</th>
      </tr>
      <g:if test="${reportModel}">
        <g:each in="${reportModel.voucherSaleByShop}">
          <tr>
            <td>${it.shop.name}</td>
            <td>${it.totalSoldValue}</td>
            <td>${it.sold}</td>
            <td>${it.totalValidatedValue}</td>
            <td>${it.validated}</td>
          </tr>
        </g:each>
      </g:if>
    </table>
  </div>
</div>
</body>
</html>