package com.breigns.vms

class VoucherInvoice {
  Shop invoicedAt;
  Integer invoiceNumber;
  String remarks
  Date dateCreated;
  static constraints = {
    remarks(nullable: true)
  }
}
