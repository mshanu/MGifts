package com.breigns.vms

class VoucherModel {
  Integer sequenceNumber
  String barcodeAlpha
  Double value
  Shop validatedAt;
  Date validThru;
  Client client
}
