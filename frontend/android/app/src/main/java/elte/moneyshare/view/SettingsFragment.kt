package elte.moneyshare.view

import android.arch.lifecycle.ViewModelProviders
import android.os.Bundle
import android.support.v4.app.Fragment
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import elte.moneyshare.R
import elte.moneyshare.SharedPreferences
import elte.moneyshare.entity.ChangePasswordData
import elte.moneyshare.entity.PasswordUpdate
import elte.moneyshare.manager.DialogManager
import elte.moneyshare.util.Action
import elte.moneyshare.util.convertErrorCodeToString
import elte.moneyshare.viewmodel.ProfileViewModel
import kotlinx.android.synthetic.main.fragment_settings.*

class SettingsFragment : Fragment() {

    private lateinit var viewModel: ProfileViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Retain this fragment across configuration changes.
        retainInstance = true
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_settings, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        viewModel = ViewModelProviders.of(this).get(ProfileViewModel::class.java)

        huButton.setOnClickListener {
            viewModel.updateLang("HU") { _, error ->
                handleUpdateLangResponse("HU", error)
            }
        }

        enButton.setOnClickListener {
            viewModel.updateLang("EN") { _, error ->
                handleUpdateLangResponse("EN", error)
            }
        }
    }

    private fun handleUpdateLangResponse(lang: String, error: String?) {
        if (error == null) {
            SharedPreferences.lang = lang
            (activity as MainActivity).updateLang(SharedPreferences.lang)
            (activity as MainActivity).refresh()
        } else {
            DialogManager.showInfoDialog(error, context)
        }
    }
}