package com.breigns.vms.service

import com.breigns.vms.Client
import com.breigns.vms.Voucher
import com.breigns.vms.ClientVoucherSequence
import org.apache.commons.lang.RandomStringUtils
import com.breigns.vms.AppUser
import com.breigns.vms.VoucherStatus
import java.text.SimpleDateFormat

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
    Voucher.findAllByClientAndDateCreated(client, new java.sql.Date(dateToSearch.getTime()), [sort: 'sequenceNumber'])
  }

  def getRandomAlpha() {
    RandomStringUtils.randomAlphabetic(10).toUpperCase()
  }
}
