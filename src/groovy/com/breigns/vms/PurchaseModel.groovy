package com.breigns.vms

class PurchaseModel {
  List<Long> voucherIds
  Long invoiceNumber
  Date invoiceDate
  Double totalAmount;
  Double discount;
  Double netTotal;
  Long itemId;
}
