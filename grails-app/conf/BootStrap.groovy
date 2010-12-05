import com.breigns.gift.AppUser
import com.breigns.gift.AppUserRole
import com.breigns.gift.Role

class BootStrap {
  def springSecurityService
  def init = { servletContext ->

    /*def adminRole = Role.findByAuthority('ROLE_ADMIN')
    def adminUser = AppUser.findByUsername('admin') ?: new AppUser(
                    firstName:'Fanzeem',
                    lastName:'Ahmed',
                    username: 'admin',
                    password: springSecurityService.encodePassword('breigns$123'),
                    enabled: true).save(failOnError: true)
            if (!adminUser.authorities.contains(adminRole)) {
                AppUserRole.create adminUser, adminRole
            }*/

  }
  def destroy = {
  }
}
