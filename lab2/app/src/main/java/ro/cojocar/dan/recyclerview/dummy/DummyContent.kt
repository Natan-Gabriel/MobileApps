package ro.cojocar.dan.recyclerview.dummy

import java.util.*

object DummyContent {

  val ITEMS: MutableList<Aircraft> = ArrayList()

  val ITEM_MAP: MutableMap<String, Aircraft> = HashMap()

  private const val COUNT = 25

  init {

    addItem(createAircraftItem("G-AAIN","Airbus A320","British Airways","BA0751","Terminal 4","D04"))
    addItem(createAircraftItem("G-AWIN","Airbus A380","Air France","AF0051","Terminal 4","D05"))
    addItem(createAircraftItem("G-TYIN","Airbus A330","British Airways","BA0701","Terminal 2","B04"))
    addItem(createAircraftItem("G-TRIN","Airbus A350","Wizz Air","W60251","Terminal 5","E04"))
    addItem(createAircraftItem("G-AAEE","Airbus A310","American Airlines","AA0791","Terminal 3","C04"))
    addItem(createAircraftItem("A-AHGF","Airbus A340","KLM","KL0051","Terminal 4","D06"))
    // Add some sample items.
//    for (i in 1..COUNT) {
//      addItem(createAircraftItem())
//    }
  }

  fun addItem(item: Aircraft) {
    ITEMS.add(item)
    ITEM_MAP[item.tailNumber] = item
  }

  fun createAircraftItem(tailNumber: String,aircraftType:String,airline:String,flightCode:String,terminal:String,gate:String): Aircraft {
    return Aircraft(tailNumber,aircraftType,airline,flightCode,terminal,gate)
  }


  private fun createDummyItem(position: Int): DummyItem {
    return DummyItem(position.toString(), "Item $position", makeDetails(position))
  }

  private fun makeDetails(position: Int): String {
    val builder = StringBuilder()
    builder.append("Details about Item: ").append(position)
    for (i in 0 until position) {
      builder.append("\nMore details information here.")
    }
    return builder.toString()
  }

  data class Aircraft(val tailNumber: String,val aircraftType:String,val airline:String,val flightCode:String,val terminal:String,val gate:String) {
    override fun toString(): String = flightCode + airline
  }

  data class DummyItem(val id: String, val content: String, val details: String) {
    override fun toString(): String = content
  }
}
