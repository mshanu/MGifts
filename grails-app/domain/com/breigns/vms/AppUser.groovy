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

  static belongsTo = [shop:Shop]

  static mapping = {
    password column: '`password`'
  }

  Set<Role> getAuthorities() {
    AppUserRole.findAllByAppUser(this).collect { it.role } as Set
  }

  static def createNewUser(firstName,lastName,userName,encodedPassword,role,shop ){
     def user=new AppUser(firstName:firstName,lastName:lastName,
             username:userName,password:encodedPassword,
             enabled:true,accountExpired:false,accountLocked:false,passwordExpired:false,shop:shop).save()

    AppUserRole.create(user,Role.findByAuthority(role),true)
  }
}
