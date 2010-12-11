package com.breigns.vms.controller

class UserController {
  def userService;
  def index = {
    def inuser = userService.getLoggedInuser()
    render "Welcome "+inuser.firstName+" "+inuser.lastName
  }
  

}
