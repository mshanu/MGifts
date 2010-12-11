package com.breigns.vms

class Item {
  String name
  String description
  boolean isStandard

  static constraints = {
    description(nullable:true)
  }
}
