import 'application_presenter.dart';

class DetailsPresenter extends ApplicationPresenter {
  DetailsPresenter(screen) : super(screen);

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