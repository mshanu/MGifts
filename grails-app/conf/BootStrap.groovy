import com.breigns.vms.AppUser
import com.breigns.vms.AppUserRole
import com.breigns.vms.Role

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
