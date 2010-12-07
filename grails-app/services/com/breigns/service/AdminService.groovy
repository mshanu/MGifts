package com.breigns.service

import com.breigns.gift.Client
import com.breigns.gift.Voucher
import com.breigns.gift.ClientVoucherSequence
import org.apache.commons.lang.RandomStringUtils
import com.breigns.gift.AppUser

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
        client.addToVouchers(new Voucher(sequenceNumber: nextSequence, barcodeAlpha: getRandomAlpha(), value: voucherValue,createdBy:loggedInUser))
      }
    }
  }

  def getRandomAlpha() {
    RandomStringUtils.randomAlphabetic(10).toUpperCase()
  }
}
