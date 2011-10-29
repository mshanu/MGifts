<html>
  <head>
   <style type="text/css">
	#invoicePrintBlock{
        	padding:10px;
		border-width: 2px; 
		border-style: solid; 
		border-color: #900; 
	}
	#invoicePrintHeader{
		font-style:italic;
		font-size: 25px;
		padding:5px;
		border-bottom: 2px solid;
		border-color: #900;
	}
   	#invoicePrintTable {
		width: 600px;
		margin:20px;
        }
	#invoicePrintTable tbody tr td{
		border-bottom:1px solid;
		padding:3px;
	}
	#invoicePrintVoucher{
		width:600px;
		text-align:center;
	}
   </style>
    <script>
	function printInvoice(){
	   window.print();	
	}
    </script>
  </head>
  <body onload="printInvoice()">
	<div id="invoicePrintBlock">
	<div id="invoicePrintHeader">Invoice Report</div>
	<table id="invoicePrintTable" cellspacing="0">
		<tbody>
			<tr>
			   <td>Invoice Number</td>
			   <td>${invoice.invoiceNumber}</td>
			   <td>Invoice Date</td>
			   <td><g:formatDate format="dd/MM/yyyy" date="${invoice.invoiceDate}"/> </td>
			</tr>	
			<tr>
			   <td>Total</td>
			   <td><g:formatNumber number="${invoice.totalAmount}" format="###.00" /></td>
			   <td>Discount</td>
			   <td><g:formatNumber number="${invoice.discount}" format="###.00" /></td>
			</tr>
			<tr>
			   <td>Net total</td>
			   <td><g:formatNumber number="${invoice.netTotal}" format="###.00" /></td>
			   <td>Item</td>
			   <td>${invoice.item.name}</td>
			</tr>
		</tbody>
	</table>
	<table id="invoicePrintVoucher">
		<thead>
			<tr>
			 <th>Voucher Seq#</th>
			 <th>Barcode</th>
			 <th>Company Name</th>
			 <th>Value</th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${invoice.vouchers}">
		 <tr>
		  <td>${it.sequenceNumber}</td>	
		  <td>${it.barcodeAlpha}</td>	
		  <td>${it.voucherRequest.client.name}</td>	
		  <td><g:formatNumber number="${it.value}" format="###.##" /></td>	
		</tr>
                </g:each>
		</tbody>
	</table>
	</div>
  </body>
</html>
