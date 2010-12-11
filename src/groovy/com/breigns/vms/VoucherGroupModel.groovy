package com.breigns.vms

class VoucherGroupModel {
  Integer sequenceStart;
  Integer sequenceEnd;
  Integer count;
  Double value;
  Client client;
  VoucherStatus status;
  AppUser createdBy;

  def getSequenceRange() {
    if (sequenceStart != sequenceEnd)
      client.initials + sequenceStart + "-" + client.initials + sequenceEnd
    else
      client.initials + sequenceStart
  }
}
