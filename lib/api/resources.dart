import 'dart:async';
import 'dart:convert';
import 'package:simplefire/models/company_third_party.dart';
import 'package:simplefire/models/review.dart';
import 'package:simplefire/models/third_party_source.dart';
import 'package:simplefire/utils/network_util.dart';
import 'package:simplefire/api_routes.dart';
import 'package:simplefire/models/current_staff.dart';
import 'package:simplefire/models/company_staff.dart';
import 'package:simplefire/models/address.dart';
import 'package:simplefire/models/business_type.dart';
import 'package:simplefire/models/company.dart';

class ApiResources {
  final NetworkUtil _netUtil = new NetworkUtil();
  final JsonEncoder _encoder = new JsonEncoder();
  final JsonDecoder _decoder = new JsonDecoder();

  Future<List<CompanyStaff>> fetchCompanyStaffs() {
    // TODO: Change here! Not implemented!
    return _netUtil.get(ApiRoutes.companyStaffs());
  }

  Future<List<Review>> fetchCompanyReviews(companyId, {params}) {
    return _netUtil.get(ApiRoutes.companyReviews(companyId), params: params).then((data) {
      if (data != null)
        return reviewsFromJson(data);
      else
        return new List<Review>();
    });
  }


  Future<Review> fetchCompanyReview(companyId, id, {params}) {
    return _netUtil.get(ApiRoutes.companyReview(companyId, id), params: params).then((data) {
      if (data != null)
        return Review.fromJson(data);
      else
        return new Review();
    });
  }

  Future<Company> fetchCompany(id, {params}) {
    return _netUtil.get(ApiRoutes.company(id), params: params).then((data) {
      if (data != null)
        return Company.fromJson(data);
      else
        return new Company();
    });
  }

  Future<Address> fetchCompanyAddress(id, {params}) {
    return _netUtil.get(ApiRoutes.companyAddress(id), params: params).then((data) {
      if (data != null)
        return Address.fromJson(data);
      else
        return new Address();
    });
  }

  Future<List<BusinessType>> fetchBusinessTypes({params}) {
    return _netUtil.get(ApiRoutes.businessTypes(), params: params).then((data) {
      if (data != null)
        return businessTypesFromJson(data);
      else
        return new List<BusinessType>();
    });
  }

  Future<BusinessType> fetchBusinessType(id, {params}) {
    return _netUtil.get(ApiRoutes.businessType(id)).then((data) {
      if (data != null)
        return BusinessType.fromJson(data);
      else
        return new BusinessType();
    });
  }

  Future<List<ThirdPartySource>> fetchBusinessTypeThirdPartySources(businessTypeId, {params}) {
    return _netUtil.get(ApiRoutes.businessTypeThirdPartySources(businessTypeId), params: params).then((data) {
      if (data != null)
        return thirdPartiesSourcesFromJson(data);
      else
        return new List<ThirdPartySource>();
    });
  }

  Future<ThirdPartySource> fetchBusinessThirdPartySource(businessTypeId, id, {params}) {
    return _netUtil.get(ApiRoutes.businessTypeThirdPartySource(businessTypeId, id), params: params).then((data) {
      if (data != null)
        return ThirdPartySource.fromJson(data);
      else
        return new ThirdPartySource();
    });
  }

  Future<List<ThirdPartySource>> fetchThirdPartySources({params}) {
    return _netUtil.get(ApiRoutes.thirdPartySources(), params: params).then((data) {
      if (data != null)
        return thirdPartiesSourcesFromJson(data);
      else
        return new List<ThirdPartySource>();
    });
  }

  Future<ThirdPartySource> fetchThirdPartySource(id, {params}) {
    return _netUtil.get(ApiRoutes.thirdPartySource(id), params: params).then((data) {
      if (data != null)
        return ThirdPartySource.fromJson(data);
      else
        return new ThirdPartySource();
    });
  }

  Future<List<CompanyThirdParty>> fetchCompanyThirdParties(companyId, {params}) {
    return _netUtil
        .get(ApiRoutes.companyCompanyThirdParties(companyId), params: params)
        .then((data) {
      if (data != null)
        return companyThirdPartiesFromJson(data);
      else
        return new List<CompanyThirdParty>();
    });
  }

  Future<CompanyThirdParty> fetchCompanyThirdParty(companyId, id, {params}) {
    return _netUtil
        .get(ApiRoutes.companyCompanyThirdParty(companyId, id), params: params)
        .then((data) {
      if (data != null)
        return CompanyThirdParty.fromJson(data);
      else
        return new CompanyThirdParty();
    });
  }

  Future<bool> deleteCompanyThirdParty(companyId, id, {params}) {
    return _netUtil
        .delete(ApiRoutes.companyCompanyThirdParty(companyId, id), params: params)
        .then((data) {
      return data;
    });
  }

  Future<Company> postCompany(Company company, {params}) {
    return _netUtil
        .post(ApiRoutes.companyCreate(), company.toJsonCreate(), params: params)
        .then((data) {
      if (data != null)
        return Company.fromJson(data);
      else
        return new Company();
    });
  }

  Future<bool> logout() {
    return _netUtil
        .delete(ApiRoutes.logout())
        .then((data) {
      return true;
    });
  }

  // Login Only
  Future<CurrentStaff> login(String email, String password) {
    var loginCredentials =
    _encoder.convert({"email": email, "password": password});
    var headers = {"Content-Type": "application/json"};
    return _netUtil
        .postRaw(ApiRoutes.login(), loginCredentials, headers)
        .then((dynamic response) {
      final String resBody = response.body;
      final int statusCode = response.statusCode;
      var headers = response.headers;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        return new CurrentStaff();
      } else {
        var staffJson = _decoder.convert(resBody);
        if (staffJson == null || headers["access-token"] == null) {
          return new CurrentStaff();
        } else {
          CurrentStaff currentStaff = CurrentStaff.fromJson(staffJson["data"]);
          currentStaff.accessToken = headers["access-token"];
          currentStaff.client = headers["client"];
          return currentStaff;
        }
      }
    });
  }
}
