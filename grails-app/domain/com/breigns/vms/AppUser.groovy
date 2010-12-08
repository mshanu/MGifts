package com.breigns.vms

class AppUser {
  String firstName
  String lastName
  String username
  String password
  boolean enabled
  boolean accountExpired
  boolean accountLocked
  boolean passwordExpired
  Date dateCreated
  Date lastUpdated

  static constraints = {
    username blank: false, unique: true
    password blank: false
  }

  static mapping = {
    password column: '`password`'
  }

  Set<Role> getAuthorities() {
    AppUserRole.findAllByAppUser(this).collect { it.role } as Set
  }
}
