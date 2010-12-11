package com.breigns.vms.controller

import com.breigns.vms.Client
import com.breigns.vms.utility.BarCodeXmlGenerator
import com.breigns.vms.VoucherStatus
import java.text.SimpleDateFormat

class VoucherController {
  def adminService;
  def voucherService

  def index = {
    render view: 'createNewVoucher', model: [clientList: Client.listOrderByName()]
  }

  def insert = {
    adminService.createVouchersForTheClient(params['clientId'], Integer.parseInt(params['numberOfVouchers']), Double.parseDouble(params['voucherValue']))
    flash.message = 'Voucher(s) Created Successfully'
    redirect controllerName: 'voucher'
  }

  def historyPage = {
    render view: 'voucherHistory', model: [clientList: Client.listOrderByName()]
  }

  def getHistory = {
    def voucherList = adminService.getVouchersFor(Long.parseLong(params['clientId']), params['dateToSearch'])
    render view: 'voucherHistory', model: [clientList: Client.listOrderByName(), voucherList: voucherList]
  }

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

  def barcodePage = {
    render view: 'barCodePage',
            model: [clientList: Client.listOrderByName()]
  }

  def getCreatedVouchers = {
    def clientId = Long.parseLong(params['clientId'])
    def voucherGroupList = adminService.getVouchersCreatedGroupedByValue(clientId)
    render view: 'barCodePage', model: [clientList: Client.listOrderByName(),
            voucherGroupList: voucherGroupList, selectedClient: Client.get(clientId)]
  }

  def printBarCodeForClient = {
    def clientId = Long.parseLong(params['clientIdForBarcode'])
    def sequenceStart = Integer.parseInt(params['sequenceStart'])
    def sequenceEnd = Integer.parseInt(params['sequenceEnd'])
    def voucherList = adminService.getVouchersForSequence(clientId,
            sequenceStart, sequenceEnd)
    adminService.updateStatusForRangeOfSequence(clientId, sequenceStart, sequenceEnd, VoucherStatus.BARCODE_GENERATED)
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
    def voucher = voucherService.getVoucherToValidate(params['clientInitials'], sequenceNumber, params['barcode'])
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
      render view: 'voucherDetailsToSell', model: [voucher: voucher, voucherFound: true]
    } else {
      flash.message = "System cannot find a voucher for your search"
      render view: 'voucherDetailsToSell', model: [voucherFound: false]
    }
  }
  def sell = {
    def invoiceDateAsString = params['invoiceDate']
    def dateFormate = new SimpleDateFormat("dd/MM/yyyy")
    voucherService.sell(Long.parseLong(params['voucherId']), params['invoiceNumber'], dateFormate.parse(invoiceDateAsString))
    render view: 'voucherSold'
  }
}

