package com.breigns.vms.service

import com.breigns.vms.AppUser

class UserService {
  def springSecurityService;
  def getLoggedInuser(){
    def username = springSecurityService.getPrincipal().username
    AppUser.findByUsername username
  }
}
