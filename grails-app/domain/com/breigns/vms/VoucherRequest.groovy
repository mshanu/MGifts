package com.breigns.vms

class VoucherRequest {
  Client client
  Boolean isInvoiced = false
  List vouchers
  AppUser createdBy
  Date dateCreated
  Date lastUpdated
  static hasMany = [vouchers: Voucher]
  static mapping = {
    vouchers cascade: "all,delete-orphan"
  }

  def getSequenceRange() {
    client.initials + vouchers.first().sequenceNumber + "-" + client.initials + vouchers.last().sequenceNumber
  }

  def getSequenceStart(){
    vouchers.first().sequenceNumber
  }

  def getSequenceEnd(){
    vouchers.last().sequenceNumber
  }
}
