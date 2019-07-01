import 'package:simplefire/models/company.dart';
import 'application_presenter.dart';
import 'package:flutter/material.dart';
import 'package:simplefire/models/current_staff.dart';

class LoginPresenter extends ApplicationPresenter {
  CurrentStaff currentStaff = CurrentStaff();

  LoginPresenter(screen) : super(screen);

  postCredentials(email, password) {
    api
        .login(email, password)
        .then((currentStaff) => loginResult(currentStaff));
  }

  void loginButtonClicked() {
    showIndicator();

    screen.formKey.currentState.save();
    postCredentials(currentStaff.email, currentStaff.password);
  }

  loginResult(CurrentStaff currentStaff) async {
    if (currentStaff.id != null) {
      await currentStaff.login();
      Company company = await api.fetchCompany(currentStaff.companyId);
      if (company.id != null) {
        await company.saveCurrentCompany();
        Navigator.pushReplacementNamed(screen.context, '/home');
      } else {
        await CurrentStaff.logout();
        showSnackBar("Account unaccessible! Try again in several minutes.",
            theme: "error");
      }
    }
    hideIndicator();
  }

  signupButtonClicked() {
    Navigator.pushNamed(screen.context, '/signup');
  }

  @override
  checkCurrentStaff() {
    // Do noting
  }
}