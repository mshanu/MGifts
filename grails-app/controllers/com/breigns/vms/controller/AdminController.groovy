package com.breigns.vms.controller

import com.breigns.vms.Role
import com.breigns.vms.AppUser
import com.breigns.vms.Client
import com.breigns.vms.utility.BarCodeXmlGenerator
import com.breigns.vms.VoucherStatus

class AdminController {
  def adminService;
  def index = {
    render view: 'dashboard'
  }

  def createNewVoucherPage = {
    render view: 'createNewVoucher', model: [clientList: Client.listOrderByName()]
  }

  def createNewVoucher = {
    adminService.createVouchersForTheClient(params['clientId'], Integer.parseInt(params['numberOfVouchers']), Double.parseDouble(params['voucherValue']))
    flash.message = 'Voucher(s) Created Successfully'
    render view: 'createNewVoucher', model:[clientList:Client.list()]
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

  def trackVoucherPage = {
    render view: 'trackVoucher', model: [clientList: Client.listOrderByName()]
  }

  def trackVoucher= {
    /*def voucherStatus = VoucherStatus.valueOf(params['status'])*/
    def clientId = Long.parseLong(params['clientId'])
    def voucherList = adminService.getVouchersFor(clientId, VoucherStatus.SOLD)
    render view: 'trackVoucher', model: [clientList: Client.listOrderByName(), voucherList: voucherList]
  }

  def addNewUserPage = {
    flash.clear()
    render view: 'addNewUser', model: [roles: Role.list()]
  }

  def insertUser = {
    if (AppUser.findByUsername(params['username'])) {
      flash.message = 'User with username already exists'
      render view: 'addNewUser', params: params, model: [roles: Role.list()]
    }
    else {
      adminService.createNewUser(params['firstName'], params['lastName'], params['username'], params['password'], params['userRole'])
      flash.message = 'User Created Successfully'
      params.clear()
      render view: 'addNewUser', model: [roles: Role.list()]
    }
  }

  def clientListPage = {
    render view:'clientList',model:[clientList:Client.list()]
  }
}