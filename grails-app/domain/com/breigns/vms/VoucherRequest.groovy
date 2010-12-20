package com.breigns.vms

class VoucherRequest {
  Client client
  VoucherRequestStatus status
  AppUser createdBy
  Date dateCreated
  Date lastUpdated
  static hasOne = [voucherInvoice: VoucherInvoice]
  static hasMany = [vouchers: Voucher]
  static mapping = {
    vouchers cascade: "all,delete-orphan"
  }

  static constraints = {
    voucherInvoice(nullable: true)
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
