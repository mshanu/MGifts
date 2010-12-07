package com.breigns.gift

class Client {
  String name
  String initials;
  String address
  String city
  Date dateCreated

  static hasMany = [vouchers:Voucher]
  static constraints = {
    address(nullable:true)
    city(nullable:true)
  }
}
