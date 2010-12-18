package com.breigns.vms

class Client {
  String name
  String initials;
  String address
  String city
  Date dateCreated

  static constraints = {
    address(nullable:true)
    city(nullable:true)
    initials(unique: true)
  }
}
