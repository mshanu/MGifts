package com.breigns.gift

class Company {
  String name
  String address
  Date dateCreated

  static hasMany = [vouchers:Voucher]
}
