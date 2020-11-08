package ro.cojocar.dan.recyclerview

import android.app.AlertDialog
import android.app.Dialog
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.Window
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.activity_item_list.*
import kotlinx.android.synthetic.main.item_list.*
import kotlinx.android.synthetic.main.item_list_content.view.*
import ro.cojocar.dan.recyclerview.dummy.DummyContent


class ItemListActivity : AppCompatActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_item_list)

    setSupportActionBar(toolbar)
//    toolbar.title = title

    fab.setOnClickListener { view ->
      //val item = view.tag as DummyContent.Aircraft
      val intent = Intent(view.context, ItemAddActivity::class.java).apply {
        //putExtra(ItemAddFragment.ARG_ITEM_ID, item.tailNumber)
      }
      view.context.startActivity(intent)
    }

    setupRecyclerView(item_list)


  }

  private fun setupRecyclerView(recyclerView: RecyclerView) {
    recyclerView.adapter = SimpleItemRecyclerViewAdapter(DummyContent.ITEMS,this)
  }






  class SimpleItemRecyclerViewAdapter (
      private val values: List<DummyContent.Aircraft>,private val context: Context
  ) : RecyclerView.Adapter<SimpleItemRecyclerViewAdapter.ViewHolder>() {

    private val onClickListener: View.OnClickListener
    private val onClickListenerDelete: View.OnClickListener

//    private var mCorkyListener: View.OnClickListener? = object : View.OnClickListener() {
//    override fun onClick(v: View?) {
//      // do something when the button is clicked
//    }
//  }


    init {
        onClickListener = View.OnClickListener { v ->
          val item = v.tag as DummyContent.Aircraft
          val intent = Intent(v.context, ItemDetailActivity::class.java).apply {
            putExtra(ItemDetailActivity.ARG_ITEM_ID, item.tailNumber)
          }
          Log.i("tagitemlistact",";;;"+item+";;;"+intent+";;;"+ItemDetailFragment.ARG_ITEM_ID+";;;"+item.tailNumber)
          v.context.startActivity(intent)

        }

        onClickListenerDelete = View.OnClickListener { v ->

//          val item = v.tag as DummyContent.Aircraft
//          val intent = Intent(v.context, ItemDetailActivity::class.java).apply {
//            putExtra(ItemDetailActivity.ARG_ITEM_ID, item.tailNumber)
//          }
//          Log.i("tagitemlistact",";;;"+item+";;;"+intent+";;;"+ItemDetailFragment.ARG_ITEM_ID+";;;"+item.tailNumber)
//          v.context.startActivity(intent)
//          showDialog("Are you sure you want to delete this item?")

//
//          (R.id.btn_yes).setOnClickListener { view ->
//                  //val item = view.tag as DummyContent.Aircraft
//                  val intent = Intent(view.context, ItemAddActivity::class.java).apply {
//                      //putExtra(ItemAddFragment.ARG_ITEM_ID, item.tailNumber)
//                  }
//                  view.context.startActivity(intent)
//              }

          val alert = AlertDialog.Builder(context)
          alert.setTitle("Alert!")
          alert.setMessage("Are you sure you want to delete this item?")

          alert.setNegativeButton(
              "NO"
          ) { dialog, whichButton ->

          }
          alert.setPositiveButton(
              "YES"
          ) { dialog, whichButton ->
              val item = v.tag as DummyContent.Aircraft
              Log.i("tagitemlistact",item.toString())
              DummyContent.deleteItem(item)
          }
          alert.show()
//        val item = v.tag as DummyContent.Aircraft
//        Log.i("tagitemlistact",item.toString())
//        DummyContent.deleteItem(item)

      }


    }

    private fun showDialog(title: String) {
      val dialog = Dialog(context)
      dialog.requestWindowFeature(Window.FEATURE_NO_TITLE)
      dialog.setCancelable(false)
      dialog.setContentView(R.layout.custom_dialog)
      val body = dialog.findViewById(R.id.tvBody) as TextView
      body.text = title
      val yesBtn = dialog.findViewById(R.id.btn_yes) as Button
      val noBtn = dialog.findViewById(R.id.btn_yes) as TextView
      yesBtn.setOnClickListener {
        dialog.dismiss()

      }
      noBtn.setOnClickListener { dialog.dismiss() }
      dialog.show()

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
      val view = LayoutInflater.from(parent.context)
          .inflate(R.layout.item_list_content, parent, false)
      return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
      val item = values[position]
      holder.idView.text = item.flightCode
      holder.terminal.text = item.terminal
      holder.gate.text = item.gate
      var value=0;


      with(holder.itemView) {

        tag = item
        setOnClickListener(onClickListener)
      }
      with(holder.button) {
        tag = item
        setOnClickListener(onClickListenerDelete)
      }



//      holder.button.setOnClickListener { view ->
//
////        val builder =
////          AlertDialog.Builder(this)
////        builder.setTitle("Modify Customer Details")
//        AlertDialog.Builder(getActivity())
//          .setTitle("Delete entry")
//          .setMessage("Are you sure you want to delete this entry?") // Specifying a listener allows you to take an action before dismissing the dialog.
//          // The dialog is automatically dismissed when a dialog button is clicked.
//          .setPositiveButton(android.R.string.yes,
//            DialogInterface.OnClickListener { dialog, which ->
//              // Continue with delete operation
//            }) // A null listener allows the button to dismiss the dialog and take no further action.
//          .setNegativeButton(android.R.string.no, null)
//          .setIcon(android.R.drawable.ic_dialog_alert)
//          .show()
//
//        }

    }

    override fun getItemCount() = values.size

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
      val idView: TextView = view.id_text
      val terminal: TextView = view.terminal
      val gate: TextView = view.gate
      val button: Button =view.deleteButton

    }
  }
}
