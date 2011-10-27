package com.breigns.vms.controller

import com.breigns.vms.Item
import com.breigns.vms.PurchaseModel
import grails.converters.JSON
import java.text.SimpleDateFormat
import com.breigns.vms.Purchase

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

      render "FAILURE"
    }
  }
  def validateAndGetVoucher = {
    def sequenceNumber = params['sequenceNumber'] ? Long.parseLong(params['sequenceNumber']) : null
    def voucher = voucherService.getVoucherToValidateAndUpdateStatus(params['clientInitials'], sequenceNumber, params['barcode'])
    if (voucher) {
      def converter = voucher.getVoucherModel() as JSON
      converter.render(response)
    } else {
      render 'FAILURE'
    }
  }

  def submitInvoice = {
    def dateFormat = new SimpleDateFormat("dd/MM/yyyy")
    def voucherIds = params['voucherId']
    def purchaseModel = new PurchaseModel(invoiceNumber: Long.parseLong(params['invoiceNumber']), invoiceDate: dateFormat.parse(params['invoiceDate']),
            totalAmount: Double.parseDouble(params['totalAmount']), discount: Double.parseDouble(params['discount']),
            netTotal: Double.parseDouble(params['netTotal']), itemId: Long.parseLong(params['item']),
            voucherIds: voucherIds.class == String.class ? [voucherIds] : voucherIds.collect {Long.parseLong(it)})
    def invoice = voucherService.submitInvoice(purchaseModel)
    render invoice.id
  }
  
  def printInvoice = {
    def invoiceId = params['invoiceId']
    render view:"printInvoice", model:[invoice:Purchase.get(invoiceId)] 	
  }	
}

