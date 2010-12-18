package com.breigns.vms.utility

import java.text.SimpleDateFormat

class DateUtils {
  def simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy")

  def getDateFromString(dateAsString) {
    simpleDateFormat.parse(dateAsString)
  }
}
