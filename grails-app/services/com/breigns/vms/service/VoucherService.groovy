package com.breigns.vms.service

import com.breigns.vms.Voucher
import com.breigns.vms.Client
import com.breigns.vms.VoucherStatus
import com.breigns.vms.Invoice
import com.breigns.vms.AppUser

class VoucherService {
    def springSecurityService
  def getVoucherToValidate(clientInitials, sequenceNumber, barcode) {
    Voucher voucher
    List voucherList
    if (barcode) {
      voucher = Voucher.findByBarcodeAlphaAndStatus(barcode, VoucherStatus.BARCODE_GENERATED)

    }
    if (sequenceNumber) {
      def client = Client.findByInitials(clientInitials)
      if (client) {
        voucherList = Voucher.executeQuery("""from Voucher where
              client = :client and sequenceNumber= :sequenceNumber and status = :status""",
                [client: client, sequenceNumber: sequenceNumber.intValue(), status: VoucherStatus.BARCODE_GENERATED])
        if (!voucherList.isEmpty()) {
          voucher = voucherList.get(0)
        }
      }
    }
    voucher
  }

  def sell(voucherId, invoiceNumber, invoiceDate) {
    def loggedInUser = AppUser.findByUsername(springSecurityService.getPrincipal().username)
    def voucher = Voucher.load(voucherId)
    new Invoice(invoiceNumber:invoiceNumber,
            invoiceDate:invoiceDate,voucher:voucher,createdBy:loggedInUser).save()
    voucher.status = VoucherStatus.SOLD
     
  }
}
