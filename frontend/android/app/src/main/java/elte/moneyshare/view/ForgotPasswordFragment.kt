package elte.moneyshare.view

import android.arch.lifecycle.ViewModelProviders
import android.os.Bundle
import android.support.v4.app.Fragment
import android.text.Editable
import android.text.TextWatcher
import android.util.Patterns
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import elte.moneyshare.R
import elte.moneyshare.manager.DialogManager
import elte.moneyshare.util.Action
import elte.moneyshare.util.convertErrorCodeToString
import elte.moneyshare.viewmodel.ForgotPasswordViewModel
import kotlinx.android.synthetic.main.fragment_login.*

class ForgotPasswordFragment : Fragment() {

    private lateinit var viewModel: ForgotPasswordViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_forgot_password, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        viewModel = ViewModelProviders.of(this).get(ForgotPasswordViewModel::class.java)

        forgottenPasswordButton.setOnClickListener {
            val email = emailEditText.text.toString()
            var emailValid = Patterns.EMAIL_ADDRESS.matcher(email).matches()
            if(!emailValid)
            {
                emailEditText.error = context?.getString(R.string.email_not_correct)
            } else {
                emailEditText.error = null
                viewModel.putForgotPassword(emailEditText.text.toString()) { _, error ->
                    emailEditText.text.clear()
                    forgottenPasswordButton.isEnabled = false
                    if(error == null) {
                        DialogManager.showInfoDialog(getString(R.string.email_sent), context)
                    } else {
                        DialogManager.showInfoDialog(error.convertErrorCodeToString(Action.PROFILE_RESET,context), context)
                    }
                }
                emailEditText.text.clear()
                forgottenPasswordButton.isEnabled = false
            }
        }
    }
}