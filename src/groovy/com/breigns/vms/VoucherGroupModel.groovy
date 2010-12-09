package com.breigns.vms

class VoucherGroupModel {
  Integer sequenceStart;
  Integer sequenceEnd;
  Integer count;
  Double value;
  String clientInitials;
  Long clientId;
  String clientName;
  VoucherStatus status;

  def getSequenceRange() {
    if (sequenceStart != sequenceEnd)
      clientInitials + sequenceStart + "-" + clientInitials + sequenceEnd
    else
      clientInitials + sequenceStart
  }
}
