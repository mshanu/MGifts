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
  Date validThru;
  static belongsTo = [voucherRequest: VoucherRequest, purchase: Purchase]
  static constraints = {
    barcodeAlpha(maxSize: 10, minSize: 10)
    validatedAt(nullable: true)
    purchase(nullable: true)
  }

  static mapping = {
    id(generator: 'sequence', params: [sequence: "voucher_seq"])
  }

  def getGeneratedSequence() {
    voucherRequest.client.initials + sequenceNumber
  }

  def getDiscountGivenForReport() {
    voucherRequest.voucherInvoice.discount
  }
}
