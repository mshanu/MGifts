package com.breigns.vms

class Purchase {
  Long invoiceNumber
  Date invoiceDate
  AppUser createdBy
  Shop shoppedAt
  Date dateCreated
  Item item;
  Double totalAmount
  Double discount
  Double netTotal
  static hasMany = [vouchers:Voucher]
  static constraints = {
    totalAmount(nullable:true)
    totalAmount(discount:true)
    totalAmount(netTotoal:true)
  }

}
