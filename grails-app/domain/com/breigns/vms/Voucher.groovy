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
  static belongsTo = [client: Client]
  static fetchMode = [client:'eager']
  static constraints = {
    barcodeAlpha(maxSize: 10, minSize: 10)
  }

  def getGeneratedSequence() {
    client.initials + sequenceNumber
  }

}
