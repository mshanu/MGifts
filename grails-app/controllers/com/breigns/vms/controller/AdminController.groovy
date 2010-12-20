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
import com.breigns.vms.VoucherRequestStatus
import com.breigns.vms.VoucherStatus

class AdminController {
  def adminService;
  def dateUtil = new VMSDateUtils()
  def index = {
    voucherReportPage()
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
    def voucherRequestId = Long.parseLong(params['voucherRequestId'])
    def file = grailsApplication.getMainContext().getResource("/template/barcode.template").getFile()
    adminService.updateBarcodeGenerated(voucherRequestId)
    def voucherRequest = VoucherRequest.get(voucherRequestId)
    response.setContentType("application/octet-stream")
    response.setHeader("Content-Disposition", "attachment; filename=barcode.txt")
    render new BarCodeGenerator().generateZlpForBarcode(voucherRequest.vouchersBySequence, file)
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
    if (VoucherRequest.get(voucherRequestId).status == VoucherRequestStatus.BARCODE_GENERATED) {
      def voucherInvoice = adminService.invoiceVoucherRequest(voucherRequestId, shopId, remarks)
      render "Voucher Request Invoiced At:" + voucherInvoice.invoicedAt.name + " Invoice Number:" + voucherInvoice.invoiceNumber
    }
    else {
      render "Voucher Request Can Be Invoiced Only After Barcode Generation";
    }
  }

  def addNewUserPage = {
    flash.clear()
    render view: 'addNewUser', model: [roles: Role.list(), shops: Shop.list(),users:AppUser.list()]
  }

  def insertUser = {
    if (AppUser.findByUsername(params['username'])) {
      flash.message = 'User with username already exists'
      render view: 'addNewUser', params: params, model: [roles: Role.list(),shops: Shop.list(),users:AppUser.list()]
    }
    else {
      def shop = Shop.load(Long.parseLong(params['shop']))
      adminService.createNewUser(params['firstName'], params['lastName'], params['username'], params['password'], params['userRole'], shop)
      flash.message = 'User Created Successfully'
      params.clear()
      render view: 'addNewUser', model: [roles: Role.list(), shops: Shop.list(),users:AppUser.list()]
    }
  }

  def searchToDeletePage = {
    render view: 'searchToDeletePage', model: [clients: Client.list()]
  }

  def retrieveVouchersAsJson = {
    def clientId = Long.parseLong(params['clientId'])
    render VoucherRequest.findAllByClientAndStatusNot(Client.load(clientId), VoucherRequestStatus.INVOICED).collect { [value: it.id, key: it.id + " - " + dateUtil.getDateAsString(it.dateCreated)] } as JSON
  }
  def searchVoucherToDelete = {
    flash.clear()
    def voucherRequestId = Long.parseLong(params['voucherRequestId'])
    render view: 'searchResultToDelete', model: [voucherList: VoucherRequest.get(voucherRequestId).vouchersBySequence, clients: Client.list()]
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
    render "Vouchers Deleted Successfully"
  }

  def clientListPage = {
    render view: 'clientList', model: [clientList: Client.list()]
  }

  def voucherReportPage = {
    def reportModel = adminService.getAggregatedReport()
    render view: 'voucherReport', model: [reportModel: reportModel,
            clients: Client.listOrderByName(),
            voucherStatus: VoucherStatus.values().collect {[key: it, description: it.description]},shops:Shop.list()]
  }
}