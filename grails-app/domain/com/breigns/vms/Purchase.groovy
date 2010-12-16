package com.breigns.vms

class Purchase {
  Long invoiceNumber
  Date invoiceDate
  AppUser createdBy
  Shop shoppedAt
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
