package ro.cojocar.dan.recyclerview

import android.content.Intent
import android.os.Bundle
import android.view.MenuItem
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.NavUtils
import com.google.android.material.snackbar.Snackbar

import kotlinx.android.synthetic.main.activity_item_update.*
import ro.cojocar.dan.recyclerview.dummy.DummyContent

class ItemUpdateActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_item_update)
        setSupportActionBar(update_toolbar)




//        fab.setOnClickListener { view ->
//            Snackbar.make(view, "Replace with your own add action", Snackbar.LENGTH_LONG)
//                .setAction("Action", null).show()
//        }

        findViewById<TextView>(R.id.tailNumberTextUpdate).text =  "Tail number: "+ intent.getStringExtra(ItemDetailActivity.ARG_ITEM_ID)

        updateButton.setOnClickListener { _ ->

            DummyContent.updateItem(
                DummyContent.createAircraftItem(

                    intent.getStringExtra(ItemUpdateActivity.ARG_ITEM_ID),
                    findViewById<EditText>(R.id.aircraftTypeEditUpdate).text.toString(),
                    findViewById<EditText>(R.id.airlineEditUpdate).text.toString(),
                    findViewById<EditText>(R.id.flightCodeEditUpdate).text.toString(),
                    findViewById<EditText>(R.id.terminalEditUpdate).text.toString(),
                    findViewById<EditText>(R.id.gateEditUpdate).text.toString()
                )
            )
            NavUtils.navigateUpTo(this, Intent(this, ItemListActivity::class.java))

        }

//        NavUtils.navigateUpTo(this, Intent(this, ItemListActivity::class.java))


        // Show the Up button in the action bar.
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

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