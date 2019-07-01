import 'package:simplefire/models/company.dart';
import 'package:simplefire/models/company_third_party.dart';
import 'package:simplefire/models/review.dart';

import 'application_presenter.dart';

class ReviewsPresenter extends ApplicationPresenter {
  ReviewsPresenter(screen) : super(screen);
  int footerBarIndex = 1;
  List<CompanyThirdParty> companyThirdParties = List();
  List<Review> recentReviews = List();
  List<Review> searchedReviews = List();
  int recentReviewPage = 1;
  int searchReviewPage = 1;

  fetchData() {
    showIndicator();
    fetchAllPages().then((_) {
   //   screen.fillData();
      hideIndicator();
    });
  }



  Future fetchAllPages() async {
    Company company = await getCurrentCompany();
    companyThirdParties.clear();
    recentReviewPage = 1;
    companyThirdParties = await api.fetchCompanyThirdParties(company.id);
    await fetchRecentReviews();
    await searchAndFilter();
  }

  fetchRecentReviews() async {
    Company company = await getCurrentCompany();
    recentReviews.addAll(await api
        .fetchCompanyReviews(company.id, params: {"page": recentReviewPage, "per_page": 10}));
    print("api veri gidiyor");
    print(recentReviews.length);
    print("------------");
  }

  searchAndFilter({filter, searchText}) async {
    Company company = await getCurrentCompany();
    if(filter == null && searchText == null){
      searchedReviews.addAll(await api.fetchCompanyReviews(company.id, params: {
        "page": searchReviewPage,
        "per_page": 10,
      }));
    }
    else {
      api.fetchCompanyReviews(company.id, params: {
        "page": searchReviewPage,
        "per_page": 10,
           "search": searchText,
         "third_party_source_ids": filter,
      }).then((result){
        print("geldim2");
        searchedReviews.addAll(result);
      }).catchError((onError){
        print("geldim"+onError.toString());
      });

    }
  }

 /* searchAndFilter({filter, searchText}) async {
    Company company = await getCurrentCompany();
    if(filter == null && searchText == null){
      searchedReviews.addAll(await api.fetchCompanyReviews(company.id, params: {
        "page": searchReviewPage,
        "per_page": 10,
      }));
    }
    else {
      searchedReviews.addAll(await api.fetchCompanyReviews(company.id, params: {
        "page": searchReviewPage,
        "per_page": 10,
        "search": searchText,
        "third_party_source_ids": filter,
      }));
    }
    */
  void prepareScreen() {
    fetchData();
  }

  Future loadMoreRecents() async {
    print(recentReviewPage);
    recentReviewPage = recentReviewPage + 1;
    await fetchRecentReviews();
  }

  Future loadMoreSearch(filter, searchText) async {
    print(filter);
    print(searchReviewPage);
    searchReviewPage = searchReviewPage + 1;
    await searchAndFilter(filter:filter, searchText:searchText);
  }
  void resetSearchPages(){
    searchReviewPage = 1;
  }
}
