package com.breigns.vms

class VoucherInvoice {
  Shop invoicedAt;
  Integer invoiceNumber;
  String remarks
  Date dateCreated;
  VoucherRequest voucherRequest;
  static constraints = {
    remarks(nullable: true)
  }
}
