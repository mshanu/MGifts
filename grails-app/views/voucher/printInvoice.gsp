<html>
  <body>
	<table>
		<tbody>
			<tr>
			   <td>Invoice Number</td>
			   <td>${invoice.invoiceNumber}</td>
			   <td>Invoice Date</td>
			   <td>${invoice.invoiceDate}</td>
			</tr>	
			<tr>
			   <td>Total</td>
			   <td>${invoice.totalAmount}</td>
			   <td>Discount</td>
			   <td>${invoice.discount}</td>
			</tr>
			<tr>
			   <td>Net total</td>
			   <td>${invoice.netTotal}</td>
			   <td>Item</td>
			   <td>${invoice.item.name}</td>
			</tr>
		</tbody>
	</table>
	<table>
		<tbody>
		 <tr>
		  <td></td>	
		</tr>
		</tbody>
	</table>
  </body>
</html>
