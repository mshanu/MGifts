package com.breigns.gift

class Voucher {
  Integer sequenceNumber
  String barcodeAlpha
  Double value
  Date dateCreated
  Date lastUpdated

  static belongsTo = Company

  static constraints = {
    barcodeAlpha(maxSize:10,minSize:10)
  }
}
