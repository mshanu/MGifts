package com.breigns.vms.controller

import com.breigns.vms.Client

import com.breigns.vms.utility.ReportUtil
import com.breigns.vms.Voucher
import com.breigns.vms.VoucherStatus
import com.breigns.vms.Shop
import com.breigns.vms.Purchase

class ReportController {

  def voucherReport = {
    def clientId = Long.parseLong(params['clientId'])
    def status = VoucherStatus.valueOf(params['status'])
    def client = Client.load(clientId)
    def vouchers = Voucher.findAll("from Voucher where voucherRequest.client = :client and status = :status", [client: client, status: status],
            [sort: 'sequenceNumber', order: 'asc'])
    writeToResponse(ReportUtil.generateReport("voucher.jasper", vouchers), 'vouchers.xls')
  }

  def invoiceReport = {
    def shopId = Long.parseLong(params['shopId'])
    def shop = Shop.load(shopId)
    def invoices = Purchase.findAllBySoldAt(shop, [sort: 'invoiceNumber', order: 'asc'])
    writeToResponse ReportUtil.generateReport("invoice.jasper", invoices), 'invoices.xls'
  }

  private void writeToResponse(ByteArrayOutputStream byteStream, String name) {
    response.contentType = "application/octet-stream"
    response.setHeader("Content-disposition", "attachment;filename=${name}")
    response.characterEncoding = "UTF-8"
    response.outputStream << byteStream.toByteArray()
    response.flushBuffer()
  }

}
