package com.breigns.controller

class ClientController {
  def adminService;
  def index = {
    render view:'addNewClient'
  }

  def insert = {
    adminService.addNewClient(params['companyName'],params['initials'].toUpper(),params['address'],params['city'])
    flash['message'] = 'New Client Added Successfully'
    render view:'addNewClient'
  }

}
