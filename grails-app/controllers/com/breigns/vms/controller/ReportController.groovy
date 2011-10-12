package com.breigns.vms.controller

import com.breigns.vms.Client

import com.breigns.vms.utility.ReportUtil
import com.breigns.vms.Voucher
import com.breigns.vms.VoucherStatus
import com.breigns.vms.Shop
import com.breigns.vms.Purchase
import org.hibernate.FetchMode

class ReportController {

  def voucherReport = {
    def clientId = params['clientId']
    def status = params['status']
    def criteria = Voucher.createCriteria()
    def vouchers = Voucher.withCriteria {
      if (clientId != "%") {
        voucherRequest {
          eq('client', Client.load(clientId))
        }
      }
      if (status != "%") {
        eq('status', VoucherStatus.valueOf(status))
      }
    }
    writeToResponse(ReportUtil.generateReport("voucher.jasper", vouchers), 'vouchers.xls')
  }

  def invoiceReport = {
    def invoices;
    if (params['shopId'] == "%") {
      invoices = Purchase.findAll([sort: 'id', order: 'asc'])
    } else {
      def shopId = Long.parseLong(params['shopId'])
      def shop = Shop.load(shopId)
      invoices = Purchase.findAllBySoldAt(shop, [sort: 'invoiceNumber', order: 'asc'])
    }

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
