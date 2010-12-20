package com.breigns.vms

class Purchase {
  Long invoiceNumber
  Date invoiceDate
  AppUser createdBy
  Shop soldAt
  Date dateCreated
  Item item;
  Double totalAmount
  Double discount
  Double netTotal
  static hasMany = [vouchers: Voucher]
}
