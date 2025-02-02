package ro.cojocar.dan.recyclerview

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.MenuItem
import android.view.View
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.NavUtils
import com.google.android.material.snackbar.Snackbar
//import kotlinx.android.synthetic.main.activity_item_add.*
import kotlinx.android.synthetic.main.activity_item_detail.*
import kotlinx.android.synthetic.main.activity_item_detail.fab
import kotlinx.android.synthetic.main.activity_item_list.*
import kotlinx.android.synthetic.main.item_detail.view.*
import ro.cojocar.dan.recyclerview.dummy.DummyContent

class ItemDetailActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_item_detail)
        setSupportActionBar(detail_toolbar)

        fab.setOnClickListener { view ->
            Snackbar.make(view, "Replace with your own add action", Snackbar.LENGTH_LONG)
                .setAction("Action", null).show()
        }

        this.toolbar_layout?.title = DummyContent.ITEM_MAP[intent.getStringExtra(ARG_ITEM_ID)]?.tailNumber



        findViewById<TextView>(R.id.item_detail).text = "Flight code: "+DummyContent.ITEM_MAP[intent.getStringExtra(ARG_ITEM_ID)]?.flightCode+"\n"+
                "Airline: "+ DummyContent.ITEM_MAP[intent.getStringExtra(ARG_ITEM_ID)]?.airline+"\n" +
                "Aircraft type: "+DummyContent.ITEM_MAP[intent.getStringExtra(ARG_ITEM_ID)]?.aircraftType+"\n"+
                "Terminal: "+DummyContent.ITEM_MAP[intent.getStringExtra(ARG_ITEM_ID)]?.terminal+"\n"+
                "Gate: "+DummyContent.ITEM_MAP[intent.getStringExtra(ARG_ITEM_ID)]?.gate+"\n"


        // Show the Up button in the action bar.
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

        updateButtonInDetail.setOnClickListener { v ->

//            val item = v.tag as DummyContent.Aircraft
            val intent = Intent(v.context, ItemUpdateActivity::class.java).apply {
                putExtra(ItemUpdateActivity.ARG_ITEM_ID, intent.getStringExtra(ARG_ITEM_ID))
            }
//            Log.i("tagitemlistact",";;;"+item+";;;"+intent+";;;"+ItemDetailFragment.ARG_ITEM_ID+";;;"+item.tailNumber)
            v.context.startActivity(intent)
        }

    }

    override fun onOptionsItemSelected(item: MenuItem) =
        when (item.itemId) {
            android.R.id.home -> {
                // This ID represents the Home or Up button. In the case of this
                // activity, the Up button is shown. Use NavUtils to allow users
                // to navigate up one level in the application structure. For
                // more details, see the Navigation pattern on Android Design:
                //
                // http://developer.android.com/design/patterns/navigation.html#up-vs-back

                NavUtils.navigateUpTo(this, Intent(this, ItemListActivity::class.java))
                true
            }
            else -> super.onOptionsItemSelected(item)
        }

    companion object {
        const val ARG_ITEM_ID = "item_id"
    }
}
