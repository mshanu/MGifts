package com.breigns.vms

class VoucherInvoiceSequence {
  Shop shop;
  Integer lastSquenceNumber;


  static def nextSequence(Shop shop) {
    def shopInvoiceSequence = VoucherInvoiceSequence.findByShop(shop)
    if (shopInvoiceSequence) {
      shopInvoiceSequence.lastSquenceNumber+= 1
    } else {
      shopInvoiceSequence = new VoucherInvoiceSequence(shop: shop, lastSquenceNumber: 1).save()
    }
    shopInvoiceSequence.lastSquenceNumber
  }
}
