package com.breigns.vms.controller

import com.breigns.vms.Client
import com.breigns.vms.utility.BarCodeXmlGenerator

class VoucherController {
  def adminService;

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
    def voucherGroupList =adminService.getVouchersCreatedGroupedByValue(Long.parseLong(params['clientId']))
    render view: 'barCodePage', model: [clientList: Client.listOrderByName(),
            voucherGroupList:voucherGroupList]
  }

  def printBarCodeForClient = {
    response.setHeader("Content-Disposition", "attachment; filename=barcode.xml")
    def voucherList = adminService.getVouchersForSequence(params['clientIdForBarcode'],params['sequenceStart'],params['sequenceEnd'])
    render new BarCodeXmlGenerator().generateXmlForBarCode(voucherList)
  }
}
