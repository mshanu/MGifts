package com.breigns.controller

class ClientController {
  def adminService;
  def index = {
    render view:'addNewClient'
  }

  def insert = {
    adminService.addNewClient(params['name'],params['initials'].toUpperCase(),params['address'],params['city'])
    flash['message'] = 'New Client Added Successfully'
    render view:'addNewClient'
  }

}
