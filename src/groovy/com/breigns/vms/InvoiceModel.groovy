package com.breigns.vms

class InvoiceModel {  
  Long voucherId
  String invoiceNumber
  String dateAsString
  Double totalAmount;
  Double discount;
  Double netTotal;
  Long itemId;  
}
