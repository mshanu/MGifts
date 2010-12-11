package com.breigns.vms.controller

import com.breigns.vms.Role
import com.breigns.vms.AppUser

class AdminController {
  def adminService;
  def index = {
    render view: 'dashboard'
  }
  def addNewUserPage = {
    render view: 'addNewUser', model: [roles: Role.list()]
  }

  def insertUser = {
    if (AppUser.findByUsername(params['username'])) {
      flash.message = 'User with username already exists'
      render view: 'addNewUser',params:params,model: [roles: Role.list()]
    }
    else {
      adminService.createNewUser(params['firstName'], params['lastName'], params['username'], params['password'], params['userRole'])
      flash.message = 'User Created Successfully'
      params.clear()
      render view: 'addNewUser',model: [roles: Role.list()]
    }
  }
}