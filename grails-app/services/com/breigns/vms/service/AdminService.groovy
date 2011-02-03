package com.breigns.vms.service

import org.apache.commons.lang.RandomStringUtils
import org.hibernate.SessionFactory
import com.breigns.vms.*

class AdminService {
  def springSecurityService
  SessionFactory sessionFactory
  def propertyInstanceMap = org.codehaus.groovy.grails.plugins.DomainClassGrailsPlugin.PROPERTY_INSTANCE_MAP

  def addNewClient(clientName, initials, address, city) {
    def client = new Client(name: clientName, initials: initials, address: address, city: city).save()
    new ClientVoucherSequence(client: client, lastVoucherSequenceNumber: 20000).save();
  }

  def createVouchersForTheClient(VoucherCreationRequestModel voucherCreateRequest) {
    def currentTime = System.currentTimeMillis()
    def client = Client.load(voucherCreateRequest.clientId)
    def loggedInUser = getLoggedInuser()
    def validThru = voucherCreateRequest.validThru
    def voucherRequest
    if (client) {
      voucherRequest = new VoucherRequest(client: client, createdBy: loggedInUser, status: VoucherRequestStatus.CREATED).save()
      def voucherList = voucherCreateRequest.voucherList
      int j = 0;
      def nextSequence = ClientVoucherSequence.lastVouhcerSequenceForClient(client)
      for (def voucher: voucherList) {
        for (int i = 0; i < voucher.numberOfVouchers; i++) {
          def barCodeAlpha = getRandomAlpha();
          while (Voucher.findByBarcodeAlpha(barCodeAlpha)) {
            barCodeAlpha = getRandomAlpha();
          }
          nextSequence++;
          def newVoucher = new Voucher(sequenceNumber: nextSequence,
                  barcodeAlpha: barCodeAlpha, value: voucher.denomination, createdBy: loggedInUser,
                  status: VoucherStatus.CREATED, validThru: validThru, voucherRequest: voucherRequest)
          voucherRequest.addToVouchers(newVoucher.save())
          j++;
          if (j % 50 == 0) {
            sessionFactory.getCurrentSession().flush();
            sessionFactory.getCurrentSession().clear();
            propertyInstanceMap.get().clear()
          }
        }
      }
      ClientVoucherSequence.updateLastSequence(client, nextSequence)      
    }
    voucherRequest
  }

  private def getLoggedInuser() {
    return AppUser.findByUsername(springSecurityService.getPrincipal().username)
  }


  def deleteVouchers(voucherIds) {
    Voucher.executeUpdate("delete from Voucher where id in (:voucherIds)", [voucherIds: voucherIds])
  }


  /*def getVoucherRequestsNotInvoiced(clientId) {
    def client = Client.load(clientId)
    VoucherRequest.findAllByClientAndStatusNot(client, VoucherRequestStatus.INVOICED)
  }*/

  def updateBarcodeGenerated(voucherRequestId) {
    def voucherRequest = VoucherRequest.get(voucherRequestId)
    voucherRequest.vouchers.each {
      it.status = VoucherStatus.BARCODE_GENERATED
      it.save()
    }
    voucherRequest.status = VoucherRequestStatus.BARCODE_GENERATED
  }

  def deleteVoucherRequest(voucherRequestId) {
    VoucherRequest.load(voucherRequestId).delete()
  }


  def invoiceVoucherRequest(voucherRequestId, shopId, discount, remarks) {
    def invoicedAt = Shop.load(shopId)
    def voucherRequest = VoucherRequest.load(voucherRequestId)
    def voucherInvoiceSeq = VoucherInvoiceSequence.nextSequence(invoicedAt)
    voucherRequest.vouchers.each {
      it.status = VoucherStatus.INVOICED
    }
    voucherRequest.status = VoucherRequestStatus.INVOICED
    voucherRequest.save()
    return new VoucherInvoice(invoicedAt: invoicedAt,
            voucherRequest: voucherRequest, discount: discount, remarks: remarks, invoiceNumber: voucherInvoiceSeq).save()
  }


  def createNewUser(firstName, lastName, userName, password, userRole, shop) {
    def role = Role.findByAuthority(userRole)
    def encodedPassword = springSecurityService.encodePassword(password)
    AppUser.createNewUser(firstName, lastName, userName, encodedPassword, userRole, shop)
  }


  def createShop(shopName) {
    def shopCreated
    if (!Shop.findByName(shopName))
      shopCreated = new Shop(name: shopName).save()
    shopCreated
  }

  def getAggregatedReport() {
    def sold = getAggregated(VoucherStatus.SOLD)
    def validatedToday = Voucher.executeQuery("select sum(value),count(*) from Voucher where status = :status and lastUpdated = current_date()",[status:VoucherStatus.VALIDATED]).getAt(0)
    def soldToday = Voucher.executeQuery("select sum(value),count(*) from Voucher where status = :status and lastUpdated = current_date()",[status:VoucherStatus.SOLD]).getAt(0)
    def validated = getAggregated(VoucherStatus.VALIDATED)
    def aggregatedModel = new VoucherStatusAggregatedReportModel(totalSoldValue: sold.getAt(0),
            sold: sold.getAt(1), totalValidatedValue: validated.getAt(0),
            validated: validated.getAt(1),
            totalValueValidatedToday:validatedToday.getAt(0),validatedToday:validatedToday.getAt(1),
            totalValueSoldToday:soldToday.getAt(0)?:0,soldToday:soldToday.getAt(1))

    
    def vaoucherSalesByGroup = []
    List soldSet = getListOfShopsAndSoldValues()
    List validatedSet = getListOfShopsAndValidValues()

    def soldMap = [:]
    def validatedMap = [:]
    soldSet.each {
      soldMap.put(it.getAt(2), it)
    }
    validatedSet.each {
      validatedMap.put(it.getAt(2).id, it)
    }
    soldSet.each {
      def validatedValue;
      def validatedCount;

      def shop = Shop.load(it.getAt(2));
      if (validatedMap.containsKey(shop.id)) {
        validatedValue = validatedMap.get(shop.id).getAt(0)
        validatedCount = validatedMap.get(shop.id).getAt(1)
        vaoucherSalesByGroup.add(new VoucherSaleByShop(totalSoldValue: it.getAt(0),
                sold: it.getAt(1), shop: shop, totalInvoiceValue: Purchase.getSumTotalValue(shop), totalValidatedValue: validatedValue, validated: validatedCount))
        validatedMap.remove(shop.id)
      } else {
        vaoucherSalesByGroup.add(new VoucherSaleByShop(totalSoldValue: it.getAt(0),
                sold: it.getAt(1), shop: shop, totalInvoiceValue: Purchase.getSumTotalValue(shop)))
      }
    }
    validatedMap.values().each {
      vaoucherSalesByGroup.add(new VoucherSaleByShop(totalValidatedValue: it.getAt(0),
              validated: it.getAt(1), shop: it.getAt(2)))
    }
    return new AggregatedReportModel(vocuherStatusReport: aggregatedModel, voucherSaleByShop: vaoucherSalesByGroup)
  }

  def updateVoucherRequestInvoiceRemarks(voucherRequestId,updatedRemarks){
     VoucherRequest.get(voucherRequestId).voucherInvoice.remarks = updatedRemarks;
  }

  private def getListOfShopsAndSoldValues() {
    return Voucher.executeQuery("select sum(v.value),count(*),v.purchase.soldAt.id from Voucher v group by v.purchase.soldAt")
  }

  private def getListOfShopsAndValidValues() {
    def criteria = Voucher.createCriteria();
    def resultSet = criteria.list {
      projections {
        sum('value', 'value')
        count('id', 'count')
        groupProperty('validatedAt')
      }
      and {
        eq('status', VoucherStatus.VALIDATED)
        isNotNull('validatedAt')
      }
      order('validatedAt')
    }
    return resultSet
  }

  private def getAggregated(status) {
    def criteria = Voucher.createCriteria()
    return criteria.get() {
      projections {
        sum('value', 'totalValue')
        count('id', 'count')
      }
      and {
        eq('status', status)
      }
    }
  }

  def getRandomAlpha() {
    RandomStringUtils.randomAlphabetic(10).toUpperCase()
  }
}
