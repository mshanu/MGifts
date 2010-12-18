package com.breigns.vms.service

import org.apache.commons.lang.RandomStringUtils
import org.hibernate.SessionFactory
import com.breigns.vms.*

class AdminService {
  def springSecurityService
  SessionFactory sessionFactory
  def propertyInstanceMap = org.codehaus.groovy.grails.plugins.DomainClassGrailsPlugin.PROPERTY_INSTANCE_MAP

  def addNewClient(clientName, initials, address, city) {
    new Client(name: clientName, initials: initials, address: address, city: city).save()
  }

  def createVouchersForTheClient(VoucherCreationRequestModel voucherCreateRequest) {
    def client = Client.load(voucherCreateRequest.clientId)
    def loggedInUser = getLoggedInuser()
    def validThru = voucherCreateRequest.validThru
    def voucherRequest
    if (client) {
      voucherRequest = new VoucherRequest(client: client, createdBy: loggedInUser)
      def voucherList = voucherCreateRequest.voucherList
      int j = 0;
      for (def voucher: voucherList) {
        for (int i = 0; i < voucher.numberOfVouchers; i++) {
          def nextSequence = ClientVoucherSequence.nextSequence(client)
          def barCodeAlpha = getRandomAlpha();
          while (Voucher.findByBarcodeAlpha(barCodeAlpha)) {
            barCodeAlpha = getRandomAlpha();
          }
          def newVoucher = new Voucher(sequenceNumber: nextSequence,
                  barcodeAlpha: getRandomAlpha(), value: voucher.denomination, createdBy: loggedInUser,
                  status: VoucherStatus.CREATED, validThru: validThru, voucherRequest: voucherRequest)
          voucherRequest.addToVouchers(newVoucher)
          j++;
          if (j % 50 == 0) {
            voucherRequest.save()
            sessionFactory.getCurrentSession().flush();
            sessionFactory.getCurrentSession().clear();
            propertyInstanceMap.get().clear()
          }
        }

      }
      voucherRequest.save()
    }
    voucherRequest
  }

  private def getLoggedInuser() {
    return AppUser.findByUsername(springSecurityService.getPrincipal().username)
  }

  def getVouchersFor(Long clientId, VoucherStatus voucherStatus) {
    def client = Client.load(clientId)
    Voucher.findAllByClientAndStatus(client, voucherStatus, [sort: 'sequenceNumber', order: 'asc'])
  }

  def deleteVouchers(voucherIds) {
    Voucher.executeUpdate("delete from Voucher where id in (:voucherIds)", [voucherIds: voucherIds])
  }


  def getVoucherRequestsNotInvoiced(clientId) {
    def client = Client.load(clientId)
    VoucherRequest.findAllByClientAndIsInvoiced(client, false)
  }

  def updateBarcodeGenerated(voucherRequestId) {
    VoucherRequest.get(voucherRequestId).vouchers.each {
      it.status = VoucherStatus.BARCODE_GENERATED
      it.save()
    }
  }

  def deleteVoucherRequest(voucherRequestId) {
    VoucherRequest.load(voucherRequestId).delete()
  }


  def invoiceVoucherRequest(voucherRequestId, shopId, remarks) {
    def invoicedAt = Shop.load(shopId)
    def voucherRequest = VoucherRequest.load(voucherRequestId)
    def voucherInvoiceSeq = VoucherInvoiceSequence.nextSequence(invoicedAt)
    voucherRequest.isInvoiced = true
    voucherRequest.vouchers.each {
      it.status = VoucherStatus.INVOICED
    }
    voucherRequest.save()
    return new VoucherInvoice(invoicedAt: invoicedAt,
            voucherRequest: voucherRequest, remarks: remarks, invoiceNumber: voucherInvoiceSeq).save()
  }


  def createNewUser(firstName, lastName, userName, password, userRole, shop) {
    def role = Role.findByAuthority(userRole)
    def encodedPassword = springSecurityService.encodePassword(password)
    AppUser.createNewUser(firstName, lastName, userName, encodedPassword, userRole, shop)
  }

  def getVouchersNotValidatedOrSold(clientId, shopId, voucherInvoiceNumber) {
    def client = Client.load(clientId)
    def shop = Shop.load(shopId)
    Voucher.executeQuery("""from Voucher where client = :client and voucherInvoice.invoicedAt = :invoicedAt and
voucherInvoice.invoiceNumber = :invoiceNumber and  status not in (:status)""",
            [client: client, invoicedAt: shop, invoiceNumber: voucherInvoiceNumber, status: [VoucherStatus.VALIDATED, VoucherStatus.SOLD]])
  }

  def getVoucherInvoiceThatCanBeUpdated(clientId, invoicedAtId, invoiceNumber) {
    def shop = Shop.load(invoicedAtId)
    def voucherInvoice = VoucherInvoice.findByInvoicedAtAndInvoiceNumber(shop, invoiceNumber)
    if (voucherInvoice) {
      def criteria = Voucher.createCriteria()
      def result = criteria.get {
        projections {
          min('sequenceNumber', 'sequenceNumberStart')
          max('sequenceNumber', 'sequenceNumberEnd')
          count('id', 'count')
        }
        and {
          eq('voucherInvoice', voucherInvoice)
          'in'('status', [VoucherStatus.CREATED, VoucherStatus.BARCODE_GENERATED])
        }
      }
      new VoucherInvoiceModel(voucherInvoiceId: voucherInvoice.id, invoicedAt: shop, sequenceNumberStart: result.getAt(0),
              sequenceNumberEnd: result.getAt(1), client: Client.load(clientId), invoiceNumber: invoiceNumber, dateCreated: voucherInvoice.dateCreated)
    }
  }

  def updateVoucherInvoice(voucherInvoiceId, shopId) {
    def voucherInvoice = VoucherInvoice.load(voucherInvoiceId)
    def newShop = Shop.load(shopId)
    voucherInvoice.invoicedAt = newShop
    voucherInvoice.invoiceNumber = VoucherInvoiceSequence.nextSequence(newShop)
    voucherInvoice.save()

  }

  def createShop(shopName) {
    def shopCreated
    if (!Shop.findByName(shopName))
      shopCreated = new Shop(name: shopName).save()
    shopCreated
  }

  def getAggregatedReport() {
    def sold = getAggregated(VoucherStatus.SOLD)
    def validated = getAggregated(VoucherStatus.VALIDATED)
    def aggregatedModel = new VoucherStatusAggregatedReportModel(totalSoldValue: sold.getAt(0),
            sold: sold.getAt(1), totalValidatedValue: validated.getAt(0),
            validated: validated.getAt(1))

    def vaoucherSalesByGroup = []
    List soldSet = getListOfShopsAndSoldValues()
    List validatedSet = getListOfShopsAndValidValues()

    def soldMap = [:]
    def validatedMap = [:]
    soldSet.each {
      soldMap.put(it.getAt(2).id, it)
    }
    validatedSet.each {
      validatedMap.put(it.getAt(2).id, it)
    }
    soldSet.each {
      def validatedValue;
      def validatedCount;

      def shop = it.getAt(2);
      if (validatedMap.containsKey(shop.id)) {
        validatedValue = validatedMap.get(shop.id).getAt(0)
        validatedCount = validatedMap.get(shop.id).getAt(1)
        vaoucherSalesByGroup.add(new VoucherSaleByShop(totalSoldValue: it.getAt(0),
                sold: it.getAt(1), shop: shop, totalValidatedValue: validatedValue, validated: validatedCount))
        validatedMap.remove(shop.id)
      } else {
        vaoucherSalesByGroup.add(new VoucherSaleByShop(totalSoldValue: it.getAt(0),
                sold: it.getAt(1), shop: shop))
      }
    }
    validatedMap.values().each {
      vaoucherSalesByGroup.add(new VoucherSaleByShop(totalValidatedValue: it.getAt(0),
              validated: it.getAt(1), shop: it.getAt(2)))
    }
    return new AggregatedReportModel(vocuherStatusReport: aggregatedModel, voucherSaleByShop: vaoucherSalesByGroup)
  }

  private def getListOfShopsAndSoldValues() {
    def criteria = Voucher.createCriteria();
    def resultSet = criteria.list {
      projections {
        sum('value', 'value')
        count('id', 'count')
        groupProperty('soldAt')
      }
      and {
        eq('status', VoucherStatus.SOLD)
        isNotNull('soldAt')
      }
      order('soldAt')
    }
    return resultSet
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
