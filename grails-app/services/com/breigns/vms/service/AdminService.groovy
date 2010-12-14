package com.breigns.vms.service

import com.breigns.vms.Client
import com.breigns.vms.Voucher
import com.breigns.vms.ClientVoucherSequence
import org.apache.commons.lang.RandomStringUtils
import com.breigns.vms.AppUser
import com.breigns.vms.VoucherStatus

import com.breigns.vms.VoucherGroupModel
import org.hibernate.SessionFactory
import com.breigns.vms.Role
import com.breigns.vms.Shop
import com.breigns.vms.VoucherCreationRequestModel
import com.breigns.vms.VoucherInvoiceSequence
import com.breigns.vms.VoucherInvoice

class AdminService {
  def springSecurityService
  SessionFactory sessionFactory

  def addNewClient(clientName, initials, address, city) {
    new Client(name: clientName, initials: initials, address: address, city: city).save()
  }

  def createVouchersForTheClient(VoucherCreationRequestModel voucherCreateRequest) {
    def client = Client.load(voucherCreateRequest.clientId)
    def loggedInUser = AppUser.findByUsername(springSecurityService.getPrincipal().username)
    def shop = Shop.load(voucherCreateRequest.shopId)
    def voucherInvoiceNumber = VoucherInvoiceSequence.nextSequence(shop)
    def voucherInvoice = new VoucherInvoice(invoicedAt: shop,invoiceNumber: voucherInvoiceNumber).save()
    if (client) {
      def voucherList = voucherCreateRequest.voucherList
      int j = 0;
      for (def voucher: voucherList) {
        for (int i = 0; i < voucher.numberOfVouchers; i++) {
          def nextSequence = ClientVoucherSequence.nextSequence(client)
          def barCodeAlpha = getRandomAlpha();
          while (Voucher.findByBarcodeAlpha(barCodeAlpha)) {
            barCodeAlpha = getRandomAlpha();
          }
          client.addToVouchers(new Voucher(sequenceNumber: nextSequence,
                  barcodeAlpha: getRandomAlpha(), value: voucher.denomination, createdBy: loggedInUser,
                  status: VoucherStatus.CREATED, voucherInvoice:voucherInvoice))

        }
        if (j % 50 == 0)
          sessionFactory.getCurrentSession().flush();
        j++;
      }

    }
    voucherInvoice.invoiceNumber
  }

  def getVouchersFor(Long clientId, VoucherStatus voucherStatus) {
    def client = Client.load(clientId)
    Voucher.findAllByClientAndStatus(client, voucherStatus, [sort: 'sequenceNumber', order: 'asc'])
  }

  def deleteVouchers(voucherIds) {
    Voucher.executeUpdate("delete from Voucher where id in (:voucherIds)",[voucherIds:voucherIds])
  }

  def getVouchersForSequence(clientId, sequenceStart, sequenceEnd) {
    Voucher.findAllByClientAndSequenceNumberBetween(Client.load(clientId), sequenceStart,
            sequenceEnd, [sort: 'sequenceNumber', order: 'asc'])
  }


  def getVouchersCreatedGroupedByValue(clientId) {
    def client = Client.get(clientId)
    def criteria = Voucher.createCriteria()
    def voucherGroupList = criteria.list {
      projections {
        min('sequenceNumber', 'sequenceNumberStart')
        max('sequenceNumber', 'sequenceNumberEnd')
        count('id', 'count')
        groupProperty("value", "value")
        groupProperty("createdBy", "createdBy")
      }
      and {
        eq('client', client)
        eq('status', VoucherStatus.CREATED)
      }
    }
    voucherGroupList.collect {
      new VoucherGroupModel(sequenceStart: it.getAt(0),
              sequenceEnd: it.getAt(1),
              count: it.getAt(2),
              value: it.getAt(3),
              status: VoucherStatus.CREATED,
              client: client,
              createdBy: it.getAt(4)
      )
    }
  }

  def updateStatusForRangeOfSequence(clientId, sequenceStart, sequenceEnd, voucherStatus) {
    /*Voucher.findAllByClientAndSequenceNumberBetween(Client.load(clientId),sequenceStart,sequenceEnd).each{
      it.status = VoucherStatus.BARCODE_GENERATED
    }*/
    Voucher.executeUpdate("update Voucher set status = :status where client = :client and sequenceNumber between :sequenceStart and :sequenceEnd",
            [status: voucherStatus, client: Client.load(clientId), sequenceStart: sequenceStart, sequenceEnd: sequenceEnd])
//    sessionFactory.getCurrentSession().flush();
  }

  def createNewUser(firstName, lastName, userName, password, userRole, shop) {
    def role = Role.findByAuthority(userRole)
    def encodedPassword = springSecurityService.encodePassword(password)
    AppUser.createNewUser(firstName, lastName, userName, encodedPassword, userRole, shop)
  }

  def getVouchersToDelete(clientId, shopId, voucherInvoiceNumber) {
    def client = Client.load(clientId)
    def shop = Shop.load(shopId)
    Voucher.executeQuery("""from Voucher where client = :client and voucherInvoice.invoicedAt = :invoicedAt and
voucherInvoice.invoiceNumber = :invoiceNumber and  status not in (:status)""",
            [client: client, invoicedAt: shop, invoiceNumber: voucherInvoiceNumber, status: [VoucherStatus.VALIDATED, VoucherStatus.SOLD]])
  }

  def createShop(shopName) {
    def shopCreated
    if (!Shop.findByName(shopName))
      shopCreated = new Shop(name: shopName).save()
    shopCreated
  }

  def getRandomAlpha() {
    RandomStringUtils.randomAlphabetic(10).toUpperCase()
  }
}
