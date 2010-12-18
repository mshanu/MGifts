package com.breigns.vms.utility

import java.text.SimpleDateFormat

class VMSDateUtils {
  def simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy")

  def getDateFromString(dateAsString) {
    simpleDateFormat.parse(dateAsString)
  }
  def getDateAsString(date){
    simpleDateFormat.format(date)
  }
}
