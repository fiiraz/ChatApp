import 'package:flutter/material.dart';
import 'application_presenter.dart';
import 'package:simplefire/models/address.dart';

class HomePresenter extends ApplicationPresenter {
  HomePresenter(screen) : super(screen);

  BuildContext context;
  Address address;

  fetchData() {
    showIndicator();
    getCurrentCompany().then((currentCompany) {
      api.fetchCompanyAddress(currentCompany.addressId).then((onValue){
        address = onValue;
        hideIndicator();
      });
    });
  }

  void onButton1Clicked() {}

  void prepareScreen() {
//    fetchData();
  }
}