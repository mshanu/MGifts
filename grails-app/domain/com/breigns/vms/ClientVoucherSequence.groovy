package com.breigns.vms

class ClientVoucherSequence {
  Client client;
  Integer lastVoucherSequenceNumber

  static def lastVouhcerSequenceForClient(Client client) {
    def clientVoucherSequnce = ClientVoucherSequence.findByClient(client)
    if (clientVoucherSequnce) {
      clientVoucherSequnce.lastVoucherSequenceNumber
    } else {
      clientVoucherSequnce = new ClientVoucherSequence(client: client, lastVoucherSequenceNumber: 1).save()
    }
    clientVoucherSequnce.lastVoucherSequenceNumber
  }

  static def updateLastSequence(Client client, updatedLastVoucherSequence) {
    def clientVoucherSequence = ClientVoucherSequence.findByClient(client)
    if (clientVoucherSequence) {
      clientVoucherSequence.lastVoucherSequenceNumber = updatedLastVoucherSequence
      clientVoucherSequence.save()
    }
  }
}
