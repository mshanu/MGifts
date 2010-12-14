package com.breigns.vms

class Purchase {
  Integer invoiceNumber
  Date invoiceDate
  AppUser createdBy
  Date dateCreated
  List<Voucher> vouchers
  Item item;
  Double totalAmount
  Double discount
  Double netTotal

  static constraints = {
    totalAmount(nullable:true)
    totalAmount(discount:true)
    totalAmount(netTotoal:true)
  }

}
