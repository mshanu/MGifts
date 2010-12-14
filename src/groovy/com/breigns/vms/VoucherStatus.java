package com.breigns.vms;

import java.util.Arrays;
import java.util.List;

public enum VoucherStatus {

    CREATED("Created") ,BARCODE_GENERATED("Barcode Generated"),VALIDATED("Voucher Validated"),SOLD("SOLD");
    String description;
    VoucherStatus(String description) {
        this.description = description;
    }

    static List<VoucherStatus> getStatusesToTrack() {
        return Arrays.asList(BARCODE_GENERATED, SOLD);
    }
}
