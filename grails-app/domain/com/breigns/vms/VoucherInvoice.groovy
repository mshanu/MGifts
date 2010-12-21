package com.breigns.vms

class VoucherInvoice {
  Shop invoicedAt;
  Integer invoiceNumber;
  Double discount;
  String remarks
  Date dateCreated;
  VoucherRequest voucherRequest;
  static constraints = {
    remarks(nullable: true)
    discount(nullable: true)
  }
}
