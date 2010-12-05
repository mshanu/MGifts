package com.breigns.service

import com.breigns.gift.Company
import com.breigns.gift.Voucher
import org.apache.commons.lang.RandomStringUtils

class CompanyService {
  void createVouchers(String companyName, int sequenceStart, int sequenceEnd,double price) {
    def company = Company.findByName(companyName)
    for(int i=sequenceStart;i<=sequenceEnd;i++){
      company.addToVouchers(new Voucher(sequenceNumber:i,
              barcodeAlpha:generateBarCodeAlpha(),value:price))
    }

  }

  String generateBarCodeAlpha(){
     RandomStringUtils.randomAlphabetic(10).toUpperCase()
  }
}
