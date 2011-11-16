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
    StringUtils.join(vouchers.collect {it.generatedSequence}, ',')
  }

  def getClientsForReport() {
    def clients = vouchers.collect {it.voucherRequest.client.name} as Set
    StringUtils.join(clients, ',')
  }

  def getTotalVoucherValue() {
    int sum = 0;
    vouchers.each {
      sum += it.value
    }
    sum
  }

  static def getSumTotalValue(shop) {
    def criteria = Purchase.createCriteria()
    criteria.get {
      projections {
        sum('totalAmount')
      }
      eq('soldAt', shop)
    }
  }
}
