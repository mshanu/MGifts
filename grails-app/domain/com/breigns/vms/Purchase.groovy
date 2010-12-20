package com.breigns.vms

import org.apache.commons.lang.StringUtils

class Purchase {
  Long invoiceNumber
  Date invoiceDate
  AppUser createdBy
  Shop soldAt
  Date dateCreated
  Item item;
  Double totalAmount
  Double discount
  Double netTotal
  static hasMany = [vouchers: Voucher]

  def getVouchersForReport() {
    StringUtils.join(vouchers*.generatedSequence, ',')
  }

  def getTotalVoucherValue() {
    int sum = 0;
    vouchers.each {
      sum += it.value
    }
    sum
  }
}
