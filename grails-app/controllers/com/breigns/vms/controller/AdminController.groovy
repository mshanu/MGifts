package com.breigns.vms.controller

import com.breigns.vms.Role
import com.breigns.vms.AppUser
import com.breigns.vms.Client
import com.breigns.vms.utility.BarCodeGenerator

import com.breigns.vms.Shop
import com.breigns.vms.VoucherSetModel

import com.breigns.vms.VoucherCreationRequestModel
import com.breigns.vms.utility.VMSDateUtils
import com.breigns.vms.VoucherRequest
import grails.converters.JSON

class AdminController {
  def adminService;
  def dateUtil = new VMSDateUtils()
  def index = {
    createNewVoucherRequestPage()
  }

  def createNewVoucherRequestPage = {
    flash.clear()
    render view: 'createNewVoucherRequest', model: [clientList: Client.listOrderByName()]
  }

  def createNewVoucherRequest = {
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
    def voucherRequest = adminService.createVouchersForTheClient(new VoucherCreationRequestModel(clientId: Long.parseLong(params['clientId']), voucherList: voucherSet,
            validThru: dateUtil.getDateFromString(params['validThru'])))
    /*adminService.createVouchersForTheClient(params['clientId'], Integer.parseInt(params['numberOfVouchers']),
            Double.parseDouble(params['voucherValue']),invoicedAt,params['invoiceNumber'])*/
    flash.message = 'Voucher Request Created Successfully. Request # ' + voucherRequest.id
    render view: 'createNewVoucherRequest', model: [clientList: Client.list()]
  }

  def voucherRequestsPage = {
    flash.clear()
    render view: 'voucherRequests', model: [clients: Client.listOrderByName()]
  }

  def getVoucherRequests = {
    def clientId = Long.parseLong(params['clientId'])
    def voucherRequestList = adminService.getVoucherRequestsNotInvoiced(clientId)
    render view: 'voucherRequests', model: [clients: Client.listOrderByName(), shops: Shop.listOrderByName(),
            voucherRequestList: voucherRequestList, selectedClient: Client.get(clientId)]
  }

  def generateBarcode = {
    def file = grailsApplication.getMainContext().getResource("/template/barcode.template").getFile()
    def voucherRequestId = Long.parseLong(params['voucherRequestId'])
    adminService.updateBarcodeGenerated(voucherRequestId)
    def voucherRequest = VoucherRequest.get(voucherRequestId)
    response.setContentType("application/octet-stream")
    response.setHeader("Content-Disposition", "attachment; filename=barcode.txt")
    render new BarCodeGenerator().generateZlpForBarcode(voucherRequest.vouchers, file)
  }

  def deleteVoucherRequest = {
    def voucherRequestId = Long.parseLong(params['voucherRequestId'])
    adminService.deleteVoucherRequest(voucherRequestId)
    render "Voucher Request Deleted Successfully"
  }

  def invoiceVoucherRequest = {
    def voucherRequestId = Long.parseLong(params['voucherRequestId'])
    def shopId = Long.parseLong(params['shopId'])
    def remarks = params['remarks']
    def voucherInvoice = adminService.invoiceVoucherRequest(voucherRequestId, shopId, remarks)
    render "Voucher Request Invoiced At:" + voucherInvoice.invoicedAt.name + " Invoice Number:" + voucherInvoice.invoiceNumber
  }

  /*def editVoucherSearch = {
    flash.clear()
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
*/
  /*def editVouchersByInvoice = {
    def voucherInvoiceId = Long.parseLong(params['voucherInvoiceId'])
    def shopId = Long.parseLong(params['newShopId'])
    def voucherInvoice = adminService.updateVoucherInvoice(voucherInvoiceId, shopId)
    flash.message = "Voucher Invoice Updated Successfully: New Invoice Number: " + voucherInvoice.invoiceNumber
    render view: 'editVoucher', model: [clients: Client.listOrderByName(), shops: Shop.list()]
  }*/

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
    render view: 'searchToDeletePage', model: [clients: Client.list()]
  }

  def retrieveVouchersAsJson = {
    def clientId = Long.parseLong(params['clientId'])
    render VoucherRequest.findAllByClient(Client.load(clientId)).collect { [value: it.id, key: it.id + " - " + dateUtil.getDateAsString(it.dateCreated)] } as JSON
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