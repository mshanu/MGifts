package com.breigns.vms.utility

import groovy.xml.MarkupBuilder

class BarCodeXmlGenerator {
  def generateXmlForBarCode(voucherList) {
    def writer = new StringWriter()
    def xml = new MarkupBuilder(writer)
    xml.labels(_FORMAT: "E:VOUCHER.ZPL", _QUANTITY: "1", _PRINTERNAME: "Printer 1", _JOBNAME: "LBL101") {
      voucherList.eachWithIndex {value, index ->
        if ((index + 4) % 4 == 0) {
          label() {
            for (i in 0..3) {
              variable(name: "SEQUENCE_NUMBER" + (i+1),
                      (index + i < voucherList.size())?voucherList.get(index + i).getGeneratedSequence():"")
              variable(name: "BARCODE" + (i+1),
                      (index + i < voucherList.size())?voucherList.get(index + i).barcodeAlpha:"")
            }
          }
        }

      }
    }
    writer.toString()
  }
}
