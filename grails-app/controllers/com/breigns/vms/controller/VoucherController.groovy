package com.breigns.vms.controller

import com.breigns.vms.utility.BarCodeXmlGenerator

import com.breigns.vms.Item
import com.breigns.vms.PurchaseModel
import grails.converters.JSON

class VoucherController {
  def adminService;
  def voucherService

  def validateVoucherPage = {
    render view: 'searchVoucher'
  }

  def invoice = {
    render view: 'invoiceEntry', model: [items: Item.list()]
  }

  def validate = {
    flash.clear()
    def sequenceNumber = params['sequenceNumber'] ? Long.parseLong(params['sequenceNumber']) : null
    def voucher = voucherService.getVoucherToValidateAndUpdateStatus(params['clientInitials']?.toUpperCase(), sequenceNumber, params['barcode'])
    if (voucher) {
      render view: 'voucherDetails', model: [voucher: voucher, voucherFound: true]
    } else {
      flash.message = "System cannot find a voucher for your search"
      render view: 'voucherDetails', model: [voucherFound: false]
    }
  }
  def validateAndGetVoucher = {
    def sequenceNumber = params['sequenceNumber'] ? Long.parseLong(params['sequenceNumber']) : null
    def voucher = voucherService.getVoucherToValidateAndUpdateStatus(params['clientInitials'], sequenceNumber, params['barcode'])
    if (voucher) {
      def converter = voucher as JSON
      converter.render(response)
    } else {
      render 'FAILURE'
    }
  }
  def sell = {
    def voucherId = Long.parseLong(params['voucherId'])
    def invoiceNumber = params['invoiceNumber']
    def invoiceDateAsString = params['invoiceDate']

    def totalAmount = params['totalAmount']
    def discount = params['discount']
    def netTotal = params['netTotal']
    def itemId = Long.parseLong(params['itemId'])
    def invoiceModel = new PurchaseModel(voucherId: voucherId,
            invoiceNumber: invoiceNumber, dateAsString: invoiceDateAsString,
            totalAmount: Double.parseDouble(totalAmount), discount: Double.parseDouble(discount), netTotal: Double.parseDouble(netTotal), itemId: itemId)
    voucherService.sell(invoiceModel)
    render view: 'voucherSold'
  }
}

