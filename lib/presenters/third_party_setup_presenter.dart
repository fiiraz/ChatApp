import 'package:flutter/material.dart';
import 'package:simplefire/api_routes.dart';
import 'package:simplefire/models/company_third_party.dart';
import 'package:simplefire/models/third_party_source.dart';
import 'package:url_launcher/url_launcher.dart';
import 'application_presenter.dart';

class ThirdPartySetupPresenter extends ApplicationPresenter {
  ThirdPartySetupPresenter(screen) : super(screen);
  List<ThirdPartySource> thirdPartySources = List();
  List<CompanyThirdParty> companyThirdParties = List();
  var currentStaff;

  fetchData() {
    showIndicator();
    getCurrentCompany().then((currentCompany) {
      api.fetchBusinessTypeThirdPartySources(currentCompany.businessTypeId).then((data) {
        thirdPartySources = data;
        getCurrentStaff().then((staff) {
          currentStaff = staff;
          api.fetchCompanyThirdParties(currentStaff.companyId).then((data2) {
            companyThirdParties = data2;
            screen.fillData();
            hideIndicator();
          });
        });
      });
    });
  }

  void prepareScreen() {
    fetchData();
  }

  void connectButtonClicked(source) async {
    await launch(
        ApiRoutes.webThirdPartyConnect(
            currentStaff.companyId, source.id, source.name),
        forceWebView: true);
    prepareScreen();
  }

  void finishButtonClicked() {
    setPrefence("is_setup_complete", "true").then((onValue) {
      Navigator.pushReplacementNamed(screen.context, '/home');
    });
  }

  var selectedCompanyThirdParty;
  void longpressButtonClicked(companyThirdParty) async {
    if (companyThirdParty != null) {
      selectedCompanyThirdParty = companyThirdParty;
      showDialogBox(this, "Provider will be disconnected?", "Disconnect");
    }
  }

  void dialogBoxSubmit(value) {
    showIndicator();
    api.deleteCompanyThirdParty(currentStaff.companyId, selectedCompanyThirdParty.id).then((onValue) {
      prepareScreen();
      hideIndicator();
    });
  }
}
