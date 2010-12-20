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
              [barcode: barcode, status: [VoucherStatus.INVOICED, VoucherStatus.VALIDATED]])
    } else
    if (sequenceNumber) {
      def client = Client.findByInitials(clientInitials)
      if (client) {
        voucherList = Voucher.executeQuery("""from Voucher where
              voucherRequest.client = :client and sequenceNumber= :sequenceNumber and status in (:status)""",
                [client: client, sequenceNumber: sequenceNumber.intValue(),
                        status: [VoucherStatus.INVOICED, VoucherStatus.VALIDATED]])
      }
    }
    if (voucherList) {
      voucher = voucherList.get(0)
      voucher.validatedAt = getLoggedInuser().shop
      voucher.status = VoucherStatus.VALIDATED
      voucher.save()
    }
    voucher
  }

  def submitInvoice(PurchaseModel invoiceModel) {
    def vouchers = invoiceModel.voucherIds.collect {Voucher.load(it)}
    def inuser = getLoggedInuser()
    def invoice = new Purchase(invoiceNumber: invoiceModel.invoiceNumber,
            invoiceDate: invoiceModel.invoiceDate,
            vouchers: vouchers, totalAmount: invoiceModel.totalAmount,
            discount: invoiceModel.discount, netTotal: invoiceModel.netTotal,
            createdBy: inuser, soldAt: inuser.shop, item: Item.load(invoiceModel.itemId))
    invoice.validate()
    invoice.save()
    vouchers.each {
      it.purchase = invoice
      it.status = VoucherStatus.SOLD;
      it.save()
    }
  }

  def getLoggedInuser() {
    AppUser.findByUsername(springSecurityService.getPrincipal().username)
  }
}
