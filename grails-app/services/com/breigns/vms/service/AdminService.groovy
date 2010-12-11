package com.breigns.vms.service

import com.breigns.vms.Client
import com.breigns.vms.Voucher
import com.breigns.vms.ClientVoucherSequence
import org.apache.commons.lang.RandomStringUtils
import com.breigns.vms.AppUser
import com.breigns.vms.VoucherStatus
import java.text.SimpleDateFormat
import com.breigns.vms.VoucherGroupModel
import org.hibernate.SessionFactory
import com.breigns.vms.Role

class AdminService {
  def springSecurityService
  SessionFactory sessionFactory

  def addNewClient(clientName, initials, address, city) {
    new Client(name: clientName, initials: initials, address: address, city: city).save()
  }

  def createVouchersForTheClient(clientId, numberOfVouchers, voucherValue) {
    def client = Client.load(clientId)
    def loggedInUser = AppUser.findByUsername(springSecurityService.getPrincipal().username)
    if (client) {
      for (int i = 0; i < numberOfVouchers; i++) {
        def nextSequence = ClientVoucherSequence.nextSequence(client)
        def barCodeAlpha = getRandomAlpha();
        while (Voucher.findByBarcodeAlpha(barCodeAlpha)) {
          barCodeAlpha = getRandomAlpha();
        }
        client.addToVouchers(new Voucher(sequenceNumber: nextSequence,
                barcodeAlpha: getRandomAlpha(), value: voucherValue, createdBy: loggedInUser, status: VoucherStatus.CREATED))
        if(i%50==0)
          sessionFactory.getCurrentSession().flush();
      }
    }
  }

  def getVouchersFor(Long clientId, String dateAsString) {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    def dateToSearch = dateFormat.parse(dateAsString)

    def client = Client.load(clientId)
    Voucher.findAllByClientAndDateCreated(client, new java.sql.Date(dateToSearch.getTime()), [sort: 'sequenceNumber', order: 'asc'])
  }

  def getVouchersForIdsSortedBySequence(voucherIds) {
    def criteria = Voucher.createCriteria()
    criteria.list {
      'in'('id', voucherIds)
      order('sequenceNumber', 'asc')
    }
  }

  def getVouchersForSequence(clientId, sequenceStart, sequenceEnd) {
    Voucher.findAllByClientAndSequenceNumberBetween(Client.load(clientId), sequenceStart,
            sequenceEnd, [sort: 'sequenceNumber', order: 'asc'])
  }


  def getVouchersCreatedGroupedByValue(clientId) {
    def client = Client.get(clientId)
    def criteria = Voucher.createCriteria()
    def voucherGroupList = criteria.list {
      projections {
        min('sequenceNumber', 'sequenceNumberStart')
        max('sequenceNumber', 'sequenceNumberEnd')
        count('id', 'count')
        groupProperty("value", "value")
        groupProperty("createdBy", "createdBy")
      }
      and {
        eq('client', client)
        eq('status', VoucherStatus.CREATED)
      }
    }
    voucherGroupList.collect {
      new VoucherGroupModel(sequenceStart: it.getAt(0),
              sequenceEnd: it.getAt(1),
              count: it.getAt(2),
              value: it.getAt(3),
              status: VoucherStatus.CREATED,
              client: client,
              createdBy: it.getAt(4)
      )
    }
  }

  def updateStatusForRangeOfSequence(clientId, sequenceStart, sequenceEnd, voucherStatus) {
    /*Voucher.findAllByClientAndSequenceNumberBetween(Client.load(clientId),sequenceStart,sequenceEnd).each{
      it.status = VoucherStatus.BARCODE_GENERATED
    }*/
    Voucher.executeUpdate("update Voucher set status = :status where client = :client and sequenceNumber between :sequenceStart and :sequenceEnd",
            [status: voucherStatus, client: Client.load(clientId), sequenceStart: sequenceStart, sequenceEnd: sequenceEnd])
//    sessionFactory.getCurrentSession().flush();
  }

  def createNewUser(firstName,lastName,userName,password,userRole){
     def role = Role.findByAuthority(userRole)
     def encodedPassword = springSecurityService.encodePassword(password)
     AppUser.createNewUser(firstName,lastName,userName,encodedPassword,userRole)
  }

  def getRandomAlpha() {
    RandomStringUtils.randomAlphabetic(10).toUpperCase()
  }
}
