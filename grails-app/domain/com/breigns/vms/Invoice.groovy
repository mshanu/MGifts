package com.breigns.vms

class Invoice {
  String invoiceNumber;
  Date invoiceDate;
  AppUser createdBy;
  Date dateCreated;
  Voucher voucher;
  Item item;
  Double totalAmount
  Double discount;
  Double netTotal

  static constraints = {
    totalAmount(nullable:true)
    totalAmount(discount:true)
    totalAmount(netTotoal:true)
  }

}
