package com.breigns.vms.controller

import com.breigns.vms.Client

class VoucherController {
  def adminService;

  def index = {
    render view:'createNewVoucher',model:[clientList:Client.listOrderByName()] 
  }

  def insert = {
    adminService.createVouchersForTheClient(params['clientId'],Integer.parseInt(params['numberOfVouchers']),Double.parseDouble(params['voucherValue']))
    flash.message = 'Voucher(s) Created Successfully'
    redirect controllerName: 'voucher'
  }

  def historyPage = {
     render view:'voucherHistory',model:[clientList:Client.listOrderByName()]
  }

  def getHistory = {
     
     render view:'voucherHistory',model:[clientList:Client.listOrderByName()]
  }
}
