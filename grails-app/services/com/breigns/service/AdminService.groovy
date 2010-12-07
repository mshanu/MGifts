package com.breigns.service

import com.breigns.gift.Client
import com.breigns.gift.Voucher
import com.breigns.gift.ClientVoucherSequence
import org.apache.commons.lang.RandomStringUtils

class AdminService {
  def addNewClient(clientName,initials,address, city){
     new Client(name:clientName,initials:initials,address:address,city:city).save()
  }

  def createVouchersForTheClient(clientName,numberOfVouchers,voucherValue){
    def client = Client.findByName(clientName)
    if(client){
      for(int i=0;i<numberOfVouchers;i++){
        def nextSequence = ClientVoucherSequence.nextSequence(client)
        client.addToVouchers(new Voucher(sequenceNumber:nextSequence,barcodeAlpha:getRandomAlpha(),value:voucherValue))
      }
    }
  }

  def getRandomAlpha(){
    RandomStringUtils.random(10).toUpperCase()
  }
}
