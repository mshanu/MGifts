package com.breigns.vms.service

import com.breigns.vms.Voucher
import com.breigns.vms.Client
import com.breigns.vms.VoucherStatus
import com.breigns.vms.Purchase
import com.breigns.vms.AppUser
import java.text.SimpleDateFormat
import com.breigns.vms.PurchaseModel
import com.breigns.vms.Item

class VoucherService {
  def springSecurityService

  def getVoucherToValidateAndUpdateStatus(clientInitials, sequenceNumber, barcode) {
    Voucher voucher
    List voucherList
    if (barcode) {
      voucherList = Voucher.executeQuery("from Voucher where barcodeAlpha = :barcode and status in (:status)",
              [barcode: barcode, status: [VoucherStatus.BARCODE_GENERATED, VoucherStatus.VALIDATED]])
    } else
    if (sequenceNumber) {
      def client = Client.findByInitials(clientInitials)
      if (client) {
        voucherList = Voucher.executeQuery("""from Voucher where
              client = :client and sequenceNumber= :sequenceNumber and status in (:status)""",
                [client: client, sequenceNumber: sequenceNumber.intValue(),
                        status: [VoucherStatus.BARCODE_GENERATED, VoucherStatus.VALIDATED]])
      }
    }
    if (!voucherList.isEmpty()) {
      voucher = voucherList.get(0)
      voucher.status = VoucherStatus.VALIDATED
      voucher.save()
    }
    voucher
  }

  def sell(PurchaseModel invoiceModel) {
    def dateFormat = new SimpleDateFormat("MM/dd/yyyy")
    def loggedInUser = AppUser.findByUsername(springSecurityService.getPrincipal().username)
    def voucher = Voucher.load(invoiceModel.voucherId)
    def invoice = new Purchase(invoiceNumber: invoiceModel.invoiceNumber,
            invoiceDate: dateFormat.parse(invoiceModel.dateAsString),
            voucher: Voucher.load(invoiceModel.voucherId), totalAmount: invoiceModel.totalAmount,
            discount: invoiceModel.discount, netTotal: invoiceModel.netTotal, createdBy: loggedInUser, item: Item.load(invoiceModel.itemId))

    invoice.save()
    voucher.status = VoucherStatus.SOLD

  }
}
