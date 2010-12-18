<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="adminMain"/>
</head>
<body>
<h2 style="border-bottom:orange dotted thin;text-align:center;padding:5px;">Voucher Sales Report</h2>
<div>
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
  <g:jasperReport jasper="voucher" format="XLS" name="Voucher Report">

  </g:jasperReport>
</div>
</body>
</html>