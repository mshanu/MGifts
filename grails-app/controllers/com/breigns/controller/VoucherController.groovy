package com.breigns.controller

import com.breigns.gift.Client

class VoucherController {
  def adminService;

  def index = {
    render view:'createNewVoucher',model:[clientList:Client.list()] 
  }

  def insert = {
    adminService.createVouchersForTheClient(params['clientId'],Integer.parseInt(params['numberOfVouchers']),Double.parseDouble(params['voucherValue']))
    redirect controllerName: 'voucher'
  }
}
