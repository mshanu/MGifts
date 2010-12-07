package com.breigns.service

import com.breigns.gift.Client
import com.breigns.gift.Voucher
import org.apache.commons.lang.RandomStringUtils

class ClientService {
  void createVouchers(String clientName, int sequenceStart, int sequenceEnd,double price) {
    def client = Client.findByName(clientName)
    for(int i=sequenceStart;i<=sequenceEnd;i++){
      client.addToVouchers(new Voucher(sequenceNumber:i,
              barcodeAlpha:generateBarCodeAlpha(),value:price))
    }

  }

  String generateBarCodeAlpha(){
    println RandomStringUtils.randomAlphabetic(10)
     RandomStringUtils.randomAlphabetic(10).toUpperCase()
  }
}
