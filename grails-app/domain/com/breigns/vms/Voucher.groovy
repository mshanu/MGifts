package com.breigns.vms

import java.text.DecimalFormat

class Voucher {
  Integer sequenceNumber
  String barcodeAlpha
  Double value
  AppUser createdBy;
  java.sql.Date dateCreated
  Date lastUpdated
  VoucherStatus status;

  static belongsTo = [client: Client]
  static hasOne = [invoice:Invoice]
  static constraints = {
    barcodeAlpha(maxSize: 10, minSize: 10)
  }

  def getGeneratedSequence() {
    client.initials +sequenceNumber
  }

}
