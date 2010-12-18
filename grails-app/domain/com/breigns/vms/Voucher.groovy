package com.breigns.vms

class Voucher {
  Integer sequenceNumber
  String barcodeAlpha
  Double value
  AppUser createdBy;
  java.sql.Date dateCreated
  Date lastUpdated
  VoucherStatus status;
  Shop validatedAt;
  Shop soldAt;
  Date validThru;
  static belongsTo = [voucherRequest:VoucherRequest]
  static constraints = {
    barcodeAlpha(maxSize: 10, minSize: 10)
    soldAt(nullable: true)
    validatedAt(nullable: true)
  }

  def getGeneratedSequence() {
    voucherRequest.client.initials + sequenceNumber
  }

}
