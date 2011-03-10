package com.breigns.vms

class VoucherModel {
  Long id
  Integer sequenceNumber
  String barcodeAlpha
  Double value
  Shop validatedAt;
  Date validThru;
  Client client
}
