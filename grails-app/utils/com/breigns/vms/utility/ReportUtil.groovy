package com.breigns.vms.utility

import org.codehaus.groovy.grails.commons.ApplicationHolder
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource
import net.sf.jasperreports.engine.JRDataSource
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.JasperPrint
import net.sf.jasperreports.engine.export.JRXlsExporterParameter
import net.sf.jasperreports.engine.export.JRXlsExporter

class ReportUtil {
  static reportsDir = ApplicationHolder.application.getMainContext().getResource("/WEB-INF/reports").getFile().toString()

  static generateReport(jasperFileName, collection) {
    JRDataSource ds = new JRBeanCollectionDataSource(collection)
    ByteArrayOutputStream byteArray = new ByteArrayOutputStream()
    String resource = reportsDir + "/" + jasperFileName
    JasperPrint jasperPrint = JasperFillManager.fillReport(resource, [:], ds)
    JRXlsExporter exporterXLS = new JRXlsExporter();
    exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
    exporterXLS.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, byteArray);
    exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
    exporterXLS.setParameter(JRXlsExporterParameter.IS_AUTO_DETECT_CELL_TYPE, Boolean.TRUE);
    exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
    exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
    exporterXLS.exportReport();
    byteArray
  }

}
