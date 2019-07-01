import 'application_presenter.dart';

class SamplePresenter extends ApplicationPresenter {
  SamplePresenter(screen) : super(screen);

  fetchData() {
//    showIndicator();
//    api.fetchSamples().then((data) {
//      screen.fillData();
//      hideIndicator();
//    });
  }


  void prepareScreen() {
    fetchData();
  }
}