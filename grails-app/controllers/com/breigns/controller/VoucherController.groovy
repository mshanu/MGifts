package com.breigns.controller

class VoucherController {
  def adminService;

  def index = {
    render view:'createNewVoucher' 
  }

  def insert = {
    redirect controllerName: 'admin', actionName: 'createNewVoucher'
  }
}
