package ro.cojocar.dan.recyclerview

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_item_detail.*
import kotlinx.android.synthetic.main.activity_item_list.*
import kotlinx.android.synthetic.main.activity_item_list.fab
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
    recyclerView.adapter = SimpleItemRecyclerViewAdapter(DummyContent.ITEMS)
  }

  class SimpleItemRecyclerViewAdapter(
      private val values: List<DummyContent.Aircraft>
  ) : RecyclerView.Adapter<SimpleItemRecyclerViewAdapter.ViewHolder>() {

    private val onClickListener: View.OnClickListener

    init {
      onClickListener = View.OnClickListener { v ->

        val item = v.tag as DummyContent.Aircraft
        val intent = Intent(v.context, ItemDetailActivity::class.java).apply {
          putExtra(ItemDetailFragment.ARG_ITEM_ID, item.tailNumber)
        }
        Log.i("tagitemlistact",";;;"+item+";;;"+intent+";;;"+ItemDetailFragment.ARG_ITEM_ID+";;;"+item.tailNumber)
        v.context.startActivity(intent)
      }


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

      with(holder.itemView) {
        tag = item
        setOnClickListener(onClickListener)
      }
    }

    override fun getItemCount() = values.size

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
      val idView: TextView = view.id_text
      val terminal: TextView = view.terminal
      val gate: TextView = view.gate
    }
  }
}
