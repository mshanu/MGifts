package com.breigns.vms

class VoucherCreationRequestModel {
  Long shopId;
  Long clientId;
  List<VoucherSetModel> voucherList;
  Date validThru
  String remarks  
}
