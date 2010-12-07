package com.breigns.controller

class AdminController {
  def index = {
    render view: 'dashboard'
  }

  def createNewVoucher = {
    redirect controllerName-'voucher'
  }

  def addNewClient = {
    redirect controllerName='client'
  }
}