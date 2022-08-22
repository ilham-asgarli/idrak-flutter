// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> az_AZ = {
  "welcome": "Xoş gəlmisiniz!",
  "login": "Daxil olun",
  "username": "İstifadəçi adı",
  "password": "Şifrə",
  "mainEndDrawerItemTitles": {
    "0": "Tədris ili",
    "1": "Həftələr",
    "2": "Sinif"
  },
  "dateOfBirth": "Doğum tarixi",
  "documentSerial": "Vəsiqənin nömrəsi",
  "documentFin": "FIN",
  "contractConditions": "Müqavilənin şərtləri",
  "contract": {
    "contractNumber": "Müqavilənin nömrəsi",
    "contractType": {
      "info": "Müqavilənin növü"
    },
    "contractDate": "Müqavilənin tarixi",
    "expireDate": "Müqavilənin bitmə tarixi",
    "contractPaymentOrder": {
      "totalValue": "Müqavilənin dəyəri",
      "discount": "Endirim (%)",
      "totalAmount": "Müqavilənin məbləği",
      "paymentType": {
        "info": "Ödəniş qaydası"
      },
      "offerMonth": "Kredit müddəti (ay)",
      "monthlyPayment": "Aylıq ödəniş",
      "discountMonth": "Güzəşt müddəti (ay)",
      "loanPercent": "Kredit faizi (%)",
      "offerDate": "Kreditin başlanma tarixi",
      "offerEndDate": "Kreditin bitmə tarixi",
      "initialAmount": "İlkin ödəniş",
      "totalPaymentAmount": "Cəmi ödəniş",
      "totalDeptAmount": "Qalıq borc"
    },
    "contractPaymentOrderLine": {
      "line": "Nömrə",
      "lineDate": "Tarix",
      "amount": "Məbləğ",
      "discountPercent": "Güzəşt",
      "mustPay": "Ödənilməli",
      "debt": "Borc",
      "payments": {
        "lineAmount": "Məbləğ",
        "paymentDate": "Tarix"
      }
    }
  },
  "parent": "Valideyn",
  "student": "Şagird",
  "contractParent": {
    "fullName": "Valideyn",
    "documentSerial": "Seriya nömrəsi",
    "documentFin": "FIN kodu",
    "documentOrganisation": "Orqan kodu"
  },
  "contractStudent": {
    "fullName": "Şagird",
    "year": "Tədris ili",
    "documentSerial": "Seriya nömrəsi",
    "class": "Sinif",
    "organisationCode": "Orqan kodu",
    "documentFin": "FIN kodu"
  },
  "haveNoContract": "Aktiv müqaviləniz yoxdur.",
  "contractDetails": "Müqavilə detalları",
  "contractPayments": "Müqavilə üzrə ödənişlər",
  "payed": "Ödənilib",
  "mustPay": "Ödənməlidir",
  "contractInvoices": {
    "no": "No",
    "qaimeNo": "Qaimə nömrəsi",
    "amount": "Məbləğ",
    "currency": "Valyuta",
    "account": {
      "cash": "Kassa - Nağd",
      "bank": "Bank"
    },
    "date": "Tarix"
  },
  "haveNoPayment": "Ödəməniz yoxdur."
};
static const Map<String, Map<String,dynamic>> mapLocales = {"az_AZ": az_AZ};
}
