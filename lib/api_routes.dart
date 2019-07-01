import 'dart:io' show Platform;

class ApiRoutes {

//  static String BASE_DOMAIN(){
//    if (Platform.isAndroid) {
//      return "http://10.0.2.2:3000/";
//    } else if (Platform.isIOS) {
//      return "http://lvh.me:3000/";
//    }
//  }

  static String BASE_DOMAIN(){
      return "http://simplefire.net/";
  }

  static final BASE_URL = BASE_DOMAIN() + "api/v1/";

  static String login() {
    return BASE_URL + "staff_auth/sign_in.json";
  }

  static String logout() {
    return BASE_URL + "staff_auth/sign_out.json";
  }

  static String companyStaffs() {
    return BASE_URL + "TODO HERE!!!";
  }

  static String companyAddress(id) {
    return BASE_URL + "addresses/$id.json";
  }

  static String businessTypes() {
    return BASE_URL + "business_types.json";
  }

  static String businessType(id) {
    return BASE_URL + "business_types/$id.json";
  }

  static String businessTypeThirdPartySources(businessTypeId) {
    return BASE_URL + "business_types/$businessTypeId/third_party_sources.json";
  }

  static String businessTypeThirdPartySource(businessTypeId, id) {
    return BASE_URL + "business_types/$businessTypeId/third_party_sources/$id.json";
  }

  static String company(id) {
    return BASE_URL + "companies/$id.json";
  }

  static String companyCreate() {
    return BASE_URL + "companies.json";
  }

  static String companyCompanyStaffs(id) {
    return BASE_URL + "companies/$id/company_staffs.json";
  }

  static String companyCompanyStaff(companyId, id) {
    return BASE_URL + "companies/$companyId/company_staffs/$id.json";
  }

  static String thirdPartySources() {
    return BASE_URL + "third_party_sources.json";
  }

  static String thirdPartySource(id) {
    return BASE_URL + "third_party_sources/$id.json";
  }

  static String companyCompanyThirdParties(companyId) {
    return BASE_URL + "companies/$companyId/company_third_parties.json";
  }

  static String companyCompanyThirdParty(companyId, id) {
    return BASE_URL + "companies/$companyId/company_third_parties/$id.json";
  }

  static String companyReviews(companyId) {
    return BASE_URL + "companies/$companyId/reviews.json";
  }

  static String companyReview(companyId, id) {
    return BASE_URL + "companies/$companyId/reviews/$id.json";
  }

  /// Web Access Routes
  static String webThirdPartyConnect(companyId, thirdPartySourceId, provider) {
    return BASE_DOMAIN() +
        "services/third_party_connection/$companyId/$thirdPartySourceId/$provider";
  }
}
