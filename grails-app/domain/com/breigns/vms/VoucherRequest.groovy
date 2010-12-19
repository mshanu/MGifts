package com.breigns.vms

class VoucherRequest {
  Client client
  Boolean isInvoiced = false
  AppUser createdBy
  Date dateCreated
  Date lastUpdated
  static hasMany = [vouchers: Voucher]
  static mapping = {
    vouchers cascade: "all,delete-orphan"
  }

  def getSequenceRange() {

    client.initials + getVouchersBySequence().first().sequenceNumber + "-" + client.initials + getVouchersBySequence().last().sequenceNumber
  }

  def getSequenceStart() {
    getSequenceRange().first().sequenceNumber
  }

  def getSequenceEnd() {
    getSequenceRange().last().sequenceNumber
  }

  def getVouchersBySequence() {
    Voucher.findAllByVoucherRequest(this, [sort: 'sequenceNumber'])
  }
}
