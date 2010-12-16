package com.breigns.vms.controller

import com.breigns.vms.Role
import com.breigns.vms.AppUser
import com.breigns.vms.Client
import com.breigns.vms.utility.BarCodeXmlGenerator
import com.breigns.vms.VoucherStatus
import com.breigns.vms.Shop
import com.breigns.vms.VoucherSetModel

import com.breigns.vms.VoucherCreationRequestModel

class AdminController {
  def adminService;
  def index = {
    render view: 'dashboard'
  }

  def createNewVoucherPage = {
    flash.clear()
    render view: 'createNewVoucher', model: [clientList: Client.listOrderByName(), shops: Shop.list()]
  }

  def createNewVoucher = {
    def voucherSet = new ArrayList<VoucherSetModel>()
    if (params.voucherSet.numberOfVouchers.class == String.class) {
      voucherSet.add(new VoucherSetModel(numberOfVouchers: Integer.parseInt(params.voucherSet.numberOfVouchers),
              denomination: Integer.parseInt(params.voucherSet.denomination)))
    } else {
      params.voucherSet.numberOfVouchers.eachWithIndex {obj, index ->
        voucherSet.add(new VoucherSetModel(numberOfVouchers: Integer.parseInt(obj),
                denomination: Integer.parseInt(params.voucherSet.denomination[index])))
      }
    }
    def invoiceNumber = adminService.createVouchersForTheClient(new VoucherCreationRequestModel(shopId: Long.parseLong(params['invoicedAt']),
            clientId: Long.parseLong(params['clientId']), voucherList: voucherSet))
    /*adminService.createVouchersForTheClient(params['clientId'], Integer.parseInt(params['numberOfVouchers']),
            Double.parseDouble(params['voucherValue']),invoicedAt,params['invoiceNumber'])*/
    flash.message = 'Voucher(s) Created Successfully with the invoice number: ' + invoiceNumber
    render view: 'createNewVoucher', model: [clientList: Client.list(), shops: Shop.list()]
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

  def editVoucherPage = {
    flash.clear()
    render view: 'editVoucher', model: [clients: Client.listOrderByName(), shops: Shop.list()]
  }

  def editVoucherSearch = {
    def clientId = Long.parseLong(params['clientId'])
    def shopId = Long.parseLong(params['shopId'])
    def invoiceNumber = Long.parseLong(params['invoiceNumber'])
    def voucherInvoice = adminService.getVoucherInvoiceThatCanBeUpdated(clientId, shopId, invoiceNumber)
    if (!voucherInvoice) {
      render view: 'editVoucher', model: [clients: Client.listOrderByName(), shops: Shop.list()]
      flash.message = "No Invoice Voucher Found To Edit"
    } else {
      render view: 'editVoucher', model: [clients: Client.listOrderByName(), shops: Shop.list(), voucherInvoice: voucherInvoice]
    }

  }

  def editVouchersByInvoice = {
    def voucherInvoiceId = Long.parseLong(params['voucherInvoiceId'])
    def shopId = Long.parseLong(params['newShopId'])
    adminService.updateVoucherInvoice(voucherInvoiceId, shopId)
    flash.message = "Voucher Invoice Updated Successfully"
    render view: 'editVoucher', model: [clients: Client.listOrderByName(), shops: Shop.list()]
  }

  def addNewUserPage = {
    flash.clear()
    render view: 'addNewUser', model: [roles: Role.list(), shops: Shop.list()]
  }

  def insertUser = {
    if (AppUser.findByUsername(params['username'])) {
      flash.message = 'User with username already exists'
      render view: 'addNewUser', params: params, model: [roles: Role.list()]
    }
    else {
      def shop = Shop.load(Long.parseLong(params['shop']))
      adminService.createNewUser(params['firstName'], params['lastName'], params['username'], params['password'], params['userRole'], shop)
      flash.message = 'User Created Successfully'
      params.clear()
      render view: 'addNewUser', model: [roles: Role.list(), shops: Shop.list()]
    }
  }

  def searchToDeletePage = {
    render view: 'searchToDeletePage', model: [shops: Shop.list(), clients: Client.list()]
  }

  def searchVoucherToDelete = {
    flash.clear()
    def clientId = Long.parseLong(params['clientId'])
    def shopId = Long.parseLong(params['shopId'])
    def voucherInvoiceNumber = Integer.parseInt(params['invoiceNumber'])
    render view: 'searchToDeletePage', model: [voucherList: adminService.getVouchersNotValidatedOrSold(clientId, shopId, voucherInvoiceNumber), shops: Shop.list(), clients: Client.list()]

  }

  def deleteVouchers = {
    def voucherIdsToDelete = []
    def voucherListFromParam = params['voucherSelected']
    if (voucherListFromParam instanceof String) {
      voucherIdsToDelete.add(Long.valueOf(voucherListFromParam))
    } else {
      voucherListFromParam.each {
        voucherIdsToDelete.add(Long.valueOf(it))
      }
    }
    adminService.deleteVouchers(voucherIdsToDelete)
    flash.message = "Vouchers Deleted Successfully"
    searchToDeletePage()
  }

  def clientListPage = {
    render view: 'clientList', model: [clientList: Client.list()]
  }

  def voucherReportPage = {
    def reportModel = adminService.getAggregatedReport()
    render view: 'voucherReport', model: [reportModel: reportModel]
  }
}