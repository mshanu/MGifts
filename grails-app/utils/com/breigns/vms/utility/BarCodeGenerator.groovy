package com.breigns.vms.utility

import groovy.xml.MarkupBuilder
import groovy.text.GStringTemplateEngine
import org.codehaus.groovy.grails.commons.GrailsResourceUtils

class BarCodeGenerator {

  def generateXmlForBarCode(voucherList) {
    def writer = new StringWriter()
    def xml = new MarkupBuilder(writer)
    xml.labels(_FORMAT: "E:VOUCHER.ZPL", _QUANTITY: "1", _PRINTERNAME: "Printer 1", _JOBNAME: "LBL101") {
      voucherList.eachWithIndex {value, index ->
        if ((index + 4) % 4 == 0) {
          label() {
            for (i in 0..3) {
              variable(name: "SEQUENCE_NUMBER" + (i + 1),
                      (index + i < voucherList.size()) ? voucherList.get(index + i).getGeneratedSequence() : "")
              variable(name: "BARCODE" + (i + 1),
                      (index + i < voucherList.size()) ? voucherList.get(index + i).barcodeAlpha : "")
            }
          }
        }

      }
    }
    writer.toString()
  }

  def generateZlpForBarcode(voucherList, templateFile) {
    def writer = new StringWriter()
    def engine = new GStringTemplateEngine()
    def voucherListSize = voucherList.size()
    voucherList.eachWithIndex {value, index ->
      if ((index + 1) % 2 != 0) {
        def barcodeAlpha2 = voucherListSize > (index + 1) ? voucherList.getAt(index + 1).barcodeAlpha : ""
        def sequenceNumber2 = voucherListSize > (index + 1) ? voucherList.getAt(index + 1).sequenceNumber : ""
        def binding = ["BARCODE1": value.barcodeAlpha, "SEQUENCE1": value.
                sequenceNumber, "BARCODE2": barcodeAlpha2,
                "SEQUENCE2": sequenceNumber2]
        writer.append(engine.createTemplate(templateFile).make(binding).toString())
      }
    }
    writer.toString()
  }
}
