package com.breigns.gift

class ClientVoucherSequence {
  Client client;
  Integer lastVoucherSequenceNumber

  static def nextSequence(Client client) {
    def clientVoucherSequnce = ClientVoucherSequence.findByClient(client)
    if (clientVoucherSequnce) {
      clientVoucherSequnce.lastVoucherSequenceNumber += 1
    } else {
      clientVoucherSequnce = new ClientVoucherSequence(client: client, lastVoucherSequenceNumber: 1).save()
    }
    clientVoucherSequnce.lastVoucherSequenceNumber
  }
}
