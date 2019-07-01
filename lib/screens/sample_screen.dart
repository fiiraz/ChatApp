import 'package:flutter/material.dart';
import 'package:simplefire/presenters/sample_presenter.dart';

class SampleScreen extends StatefulWidget {
  @override
  _SampleScreenState createState() => new _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  SamplePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = new SamplePresenter(this);
    presenter.prepareScreen();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return presenter.applicationScreen.widgetWithHud(
      Container(),
    );
  }

  fillData() {
    setState(() {
    });
  }
}
