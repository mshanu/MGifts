package com.breigns.vms.controller

import com.breigns.vms.Client
import com.breigns.vms.utility.BarCodeXmlGenerator
import com.breigns.vms.VoucherStatus
import java.text.SimpleDateFormat
import com.breigns.vms.Item
import com.breigns.vms.InvoiceModel

class VoucherController {
  def adminService;
  def voucherService

  def print = {
    def idsLisToQuery = []
    def voucherListFromParam = params['voucherSelected']
    if (voucherListFromParam instanceof String) {
      idsLisToQuery.add(Long.valueOf(voucherListFromParam))
    } else {
      voucherListFromParam.each {
        idsLisToQuery.add(Long.valueOf(it))
      }
    }
    def voucherList = adminService.getVouchersForIdsSortedBySequence(idsLisToQuery)
    response.setHeader("Content-Disposition", "attachment; filename=barcode.xml")
    render new BarCodeXmlGenerator().generateXmlForBarCode(voucherList)
  }

 
  def validateVoucherPage = {
    render view: 'searchVoucher', model: [link: 'validate']
  }

  def voucherSellingPage = {

    render view: 'searchVoucher', model: [link: 'sell']
  }

  def validate = {
    flash.clear()
    def sequenceNumber = params['sequenceNumber'] ? Long.parseLong(params['sequenceNumber']) : null
    def voucher = voucherService.getVoucherToValidate(params['clientInitials']?.toUpperCase(), sequenceNumber, params['barcode'])
    if (voucher) {
      render view: 'voucherDetails', model: [voucher: voucher, voucherFound: true]
    } else {
      flash.message = "System cannot find a voucher for your search"
      render view: 'voucherDetails', model: [voucherFound: false]
    }
  }
  def searchToSell = {
    flash.clear()
    def sequenceNumber = params['sequenceNumber'] ? Long.parseLong(params['sequenceNumber']) : null
    def voucher = voucherService.getVoucherToValidate(params['clientInitials'], sequenceNumber, params['barcode'])
    if (voucher) {
      render view: 'voucherDetailsToSell', model: [voucher: voucher, voucherFound: true,items:Item.list()]
    } else {
      flash.message = "System cannot find a voucher for your search"
      render view: 'voucherDetailsToSell', model: [voucherFound: false]
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
    def invoiceModel = new InvoiceModel(voucherId:voucherId,
            invoiceNumber:invoiceNumber,dateAsString:invoiceDateAsString,
            totalAmount:Double.parseDouble(totalAmount),discount:Double.parseDouble(discount),netTotal:Double.parseDouble(netTotal),itemId:itemId)
    voucherService.sell(invoiceModel)
    render view: 'voucherSold'
  }
}

