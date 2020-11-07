package ro.cojocar.dan.recyclerview

import android.content.Intent
import android.os.Bundle
import android.view.MenuItem
import android.widget.Button
import android.widget.EditText
import android.widget.LinearLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.NavUtils
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_item_add.*
import kotlinx.android.synthetic.main.activity_item_add.fab
import kotlinx.android.synthetic.main.activity_item_list.*
import ro.cojocar.dan.recyclerview.dummy.DummyContent

//import kotlinx.android.synthetic.main.activity_item_detail.*
//import kotlinx.android.synthetic.main.activity_item_detail.fab

class ItemAddActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_item_add)
        setSupportActionBar(add_toolbar)


//        val layout = findViewById<LinearLayout>(R.id.lnr_main)
//        val btn = Button(this)
//        btn.setId(123)
//        btn.setText("Welcome to WI FI World")
//        layout.addView(btn)


        fab.setOnClickListener { view ->
            Snackbar.make(view, "Replace with your own add action", Snackbar.LENGTH_LONG)
                .setAction("Action", null).show()
        }

        addButton.setOnClickListener { _ ->
            //val item = view.tag as DummyContent.Aircraft
//            val intent = Intent(view.context, ItemAddActivity::class.java).apply {
//                //putExtra(ItemAddFragment.ARG_ITEM_ID, item.tailNumber)
//            }
//            view.context.startActivity(intent)
            val text = findViewById<EditText>(R.id.tailNumberEdit)
            val value = text.text.toString()
            DummyContent.addItem(
                DummyContent.createAircraftItem(

                    findViewById<EditText>(R.id.tailNumberEdit).text.toString(),
                    findViewById<EditText>(R.id.aircraftTypeEdit).text.toString(),
                    findViewById<EditText>(R.id.airlineEdit).text.toString(),
                    findViewById<EditText>(R.id.flightCodeEdit).text.toString(),
                    findViewById<EditText>(R.id.terminalEdit).text.toString(),
                    findViewById<EditText>(R.id.gateEdit).text.toString()
                )
            )
            NavUtils.navigateUpTo(this, Intent(this, ItemListActivity::class.java))

        }

//        NavUtils.navigateUpTo(this, Intent(this, ItemListActivity::class.java))


        // Show the Up button in the action bar.
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        if (savedInstanceState == null) {
            // Create the add fragment and add it to the activity
            // using a fragment transaction.
//            val fragment = ItemAddFragment().apply {
//                arguments = Bundle().apply {
////                    putString(
////                        //ItemAddFragment.ARG_ITEM_ID,"G-AAIN"
////                        "1","G-AAIN"
//////                        ItemAddFragment.ARG_ITEM_ID,
//////                        intent.getStringExtra(ItemAddFragment.ARG_ITEM_ID)
////                    )
//                }
//            }

            supportFragmentManager.beginTransaction()
                .add(R.id.item_add_container_layout, ItemAddFragment())
                .commit()
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
}
