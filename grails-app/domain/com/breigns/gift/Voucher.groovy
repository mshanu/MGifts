package com.breigns.gift

import java.text.DecimalFormat

class Voucher {
  Integer sequenceNumber
  String barcodeAlpha
  Double value
  Date dateCreated
  Date lastUpdated

  static belongsTo = [client:Client]

  static constraints = {
    barcodeAlpha(maxSize:10,minSize:10)
  }

  def getGeneratedSequence(){
    client.initials + new DecimalFormat("00000000").format(sequenceNumber)
  }

}
