package com.breigns.vms.service

import com.breigns.vms.Client
import com.breigns.vms.Voucher
import com.breigns.vms.ClientVoucherSequence
import org.apache.commons.lang.RandomStringUtils
import com.breigns.vms.AppUser
import com.breigns.vms.VoucherStatus
import java.text.SimpleDateFormat
import com.breigns.vms.VoucherGroupModel

class AdminService {
  def springSecurityService

  def addNewClient(clientName, initials, address, city) {
    new Client(name: clientName, initials: initials, address: address, city: city).save()
  }

  def createVouchersForTheClient(clientId, numberOfVouchers, voucherValue) {
    def client = Client.load(clientId)
    if (client) {
      for (int i = 0; i < numberOfVouchers; i++) {
        def nextSequence = ClientVoucherSequence.nextSequence(client)
        def barCodeAlpha = getRandomAlpha();
        while (Voucher.findByBarcodeAlpha(barCodeAlpha)) {
          barCodeAlpha = getRandomAlpha();
        }
        def loggedInUser = AppUser.findByUsername(springSecurityService.getPrincipal().username)
        client.addToVouchers(new Voucher(sequenceNumber: nextSequence,
                barcodeAlpha: getRandomAlpha(), value: voucherValue, createdBy: loggedInUser, status: VoucherStatus.CREATED))
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
  def getVouchersForSequence(client,sequenceStart,sequenceEnd){
    Voucher.findAllByClientAndSequenceNumberBetween(client,sequenceStart,sequenceEnd)
  }


  def getVouchersCreatedGroupedByValue(clientId) {
    def client=Client.get(clientId)
    def criteria = Voucher.createCriteria()
    def voucherGroupList = criteria.list {
      projections {
        min('sequenceNumber', 'sequenceNumberStart')
        max('sequenceNumber', 'sequenceNumberEnd')
        count('id', 'count')
        groupProperty("value", "value")
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
              clientName: client.name,
              clientInitials: client.initials
      )
    }
  }


  def getRandomAlpha() {
    RandomStringUtils.randomAlphabetic(10).toUpperCase()
  }
}
