import 'package:flutter/material.dart';
import 'package:simplefire/screens/layouts/application_layout.dart';
import 'package:simplefire/screens/layouts/loading_indicator.dart';

class ApplicationScreen {
  State screen;

  ApplicationScreen(State state) {
    this.screen = state;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  int currentIndex;

  widgetWithHud(widget, {appBar, footBar, topTabBar, floatingActionButton, refreshButton, backButton}) {
    ApplicationLayout applicationLayout = ApplicationLayout(screen);
    var appBarValue = appBar;
    var footBarValue = footBar;
    var refreshButtonValue = refreshButton;
    var backButtonValue = backButton;

    if (appBar == false) {
      appBarValue = null;
    } else if (appBar == null) {
      if(refreshButtonValue == false){
        if(backButtonValue == false){
          appBarValue = applicationLayout.applicationBar(topTabBar: topTabBar, refreshButton: false, backButton: false);
        } else if (backButtonValue == null){
          appBarValue = applicationLayout.applicationBar(topTabBar: topTabBar, refreshButton: false, backButton: true);
        }

      } else if (refreshButtonValue == null){
        appBarValue = applicationLayout.applicationBar(topTabBar: topTabBar, refreshButton: true, backButton: false);
      }
    }

    if (footBar == false) {
      footBarValue = null;
    } else if (footBar == null) {
      footBarValue = applicationLayout.footerBar();
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: appBarValue,
      bottomNavigationBar: footBarValue,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: widget,
            ),
            Positioned(
              child: _loadingIndicator(),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
  refreshState(bool isIt) {
    screen.setState(() {
      isLoading = isIt;
    });
  }

  _loadingIndicator() {
    if (isLoading) {
      return indicatorWidget(screen.context);
    } else {
      return Container();
    }
  }
}
