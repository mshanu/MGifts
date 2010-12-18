package com.breigns.vms

class Voucher {
  Integer sequenceNumber
  String barcodeAlpha
  Double value
  AppUser createdBy;
  java.sql.Date dateCreated
  Date lastUpdated
  VoucherStatus status;
  VoucherInvoice voucherInvoice
  Shop soldAt;
  Shop validatedAt;
  Date validThru
  static belongsTo = [client: Client,purchase:Purchase]
  static fetchMode = [client: 'eager']
  static constraints = {
    barcodeAlpha(maxSize: 10, minSize: 10)
    soldAt(nullable: true)
    validatedAt(nullable: true)
    purchase(nullable: true)
  }

  def getGeneratedSequence() {
    client.initials + sequenceNumber
  }

}
