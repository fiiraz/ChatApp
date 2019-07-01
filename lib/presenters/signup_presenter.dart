import 'package:simplefire/helpers/lists.dart';
import 'package:simplefire/models/company.dart';
import 'application_presenter.dart';
import 'package:flutter/material.dart';
import 'package:simplefire/models/business_type.dart';

class SignupPresenter extends ApplicationPresenter {
  SignupPresenter(screen) : super(screen);

  List<BusinessType> businessTypes;
  var businessTypeId;
  var addressState = states_list[0];

  Company company = Company();

  fetchData() {
    showIndicator();
//    api.fetchBusinessTypes().then((data) {
//      businessTypes = data;
//      screen.fillData();
//      hideIndicator();
//    });
    hideIndicator();
  }

  void loginButtonClicked() {
    Navigator.pushReplacementNamed(screen.context, '/login');
  }

  void signupButtonClicked() {
    if (screen.formKey.currentState.validate()) {
      screen.formKey.currentState.save(); // Save our form now.
      showIndicator();
      api.postCompany(company).then((company) {
        if (company.id != null) {
          popupNotification("notice", "The company registered succesfully. Please check your email to active your account", delayTime: 1);
          Navigator.pushReplacementNamed(screen.context, '/login');
        } else {
          showSnackBar("Registration process failed. Please check information entered", theme: "error");
        }
        hideIndicator();
      });
    } else {
      showSnackBar("Please fill all required fields", theme: "warning");
    }
  }

  void prepareScreen() {
    fetchData();
//    company.buildAddress();
//    company.address.state = addressState;
//    if (company.companyStaffs == null || company.companyStaffs.length == 0) {
//      company.buildCompanyStaff();
//    }
  }

  @override
  checkCurrentStaff(){
    // Do noting
  }
}