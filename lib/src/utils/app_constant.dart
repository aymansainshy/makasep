import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../utils/custom_page_transition.dart';
import '../lang/app_locelazation.dart';

class AppColors {
  static const Color primaryColor = Color.fromRGBO(119, 129, 155, 1);
  static const Color scondryColor = Color.fromRGBO(30, 46, 89, 1);
}

ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Cairo',
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    },
  ),
  //.copyWith(
  //  pageTransitionsTheme: const PageTransitionsTheme(
  //    builders: <TargetPlatform, PageTransitionsBuilder>{
  //      TargetPlatform.android: ZoomPageTransitionsBuilder(),
  //      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
  //    },
  //  ),
);

String translate(String text, BuildContext context) {
  return AppLocalizations.of(context).translate(text);
}

String realEstateType(int reatEstateTypeId) {
  switch (reatEstateTypeId) {
    case 1:
      return "شقة";
      break;
    case 2:
      return "عرض - مزارع";
      break;
    case 3:
      return "منزل";
      break;
    case 4:
      return "ارض";
      break;
    default:
      return "منزل";
  }
}

String realEstatePrimaryType(String reatEstatePrimaryId) {
  switch (reatEstatePrimaryId) {
    case "1":
      return "للبيع";
      break;
    case "2":
      return "للبيع";
      break;
    case "3":
      return "للبيع";
      break;
    case "4":
      return "للاستثمار";
      break;
    case "5":
      return "للايجار";
      break;
    case "6":
      return "تقبيل خلو طرف";
      break;
    case "7":
      return "البناء ومقاولات";
      break;
    case "8":
      return " مواقع مهمة";
      break;
    case "7":
      return " للبيع";
      break;
    default:
      return "للبيع";
  }
}

Widget sleekCircularSlider(
    BuildContext context, double size, Color color1, Color color2) {
  return SleekCircularSlider(
    initialValue: 20,
    max: 100,
    onChange: (v) {},
    appearance: CircularSliderAppearance(
      spinnerMode: true,
      infoProperties: InfoProperties(),
      angleRange: 360,
      startAngle: 90,
      size: size,
      customColors: CustomSliderColors(
        hideShadow: true,
        dotColor: Colors.transparent,
        progressBarColors: [color1, color2],
        trackColor: Colors.transparent,
      ),
      customWidths: CustomSliderWidths(
        progressBarWidth: 4.0,
        trackWidth: 3.0,
      ),
    ),
  );
}

String dioErrorType(DioError errorType) {
  switch (errorType.type) {
    case DioErrorType.DEFAULT:
      return "يوجد خطأ الرجا الرجاء التأكد من خدمة الانترنت والمحاولة لاحقا";
      break;
    case DioErrorType.RECEIVE_TIMEOUT:
      return "عفوا انتهت مهلة الاتصال الرجاء المحاولة مرة اخرى";
      break;
    case DioErrorType.CONNECT_TIMEOUT:
      return "عفوا انتهت مهلة الاتصال الرجاء المحاولة مرة اخرى";
      break;
    case DioErrorType.RESPONSE:
      return "يوجد خطأ الرجا الرجاء التأكد من خدمة الانترنت والمحاولة لاحقا";
      break;
    case DioErrorType.CANCEL:
      return "يوجد خطأ الرجا الرجاء التأكد من خدمة الانترنت والمحاولة لاحقا";
      break;
    default:
      return "يوجد خطأ الرجا الرجاء التأكد من خدمة الانترنت والمحاولة لاحقا";
  }
}
