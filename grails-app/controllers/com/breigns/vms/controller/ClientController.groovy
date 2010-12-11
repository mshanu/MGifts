package com.breigns.vms.controller

import com.breigns.vms.Client

class ClientController {
  def adminService;
  def index = {
    render view: 'addNewClient'
  }

  def insert = {

    def clientName = params['name']
    def initials = params['initials'].toUpperCase()
    if (Client.findByName(clientName) || Client.findByInitials(initials)) {
      flash['message'] = 'Client With The Same Name/Initials Already Exists'

    } else {
      adminService.addNewClient(clientName, initials, params['address'], params['city'])
      flash['message'] = 'New Client Added Successfully'
      params.clear()
    }
    render view:'addNewClient'
  }

}
