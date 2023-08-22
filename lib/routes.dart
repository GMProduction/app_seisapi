
import 'package:app_kasir_sei_sapi/page/Login.dart';
import 'package:app_kasir_sei_sapi/page/base.dart';
import 'package:app_kasir_sei_sapi/page/detailPage.dart';
import 'package:app_kasir_sei_sapi/page/homePage.dart';
import 'package:app_kasir_sei_sapi/page/keranjangPage.dart';
import 'package:app_kasir_sei_sapi/page/splashScreen.dart';
import 'package:app_kasir_sei_sapi/page/suksesPesan.dart';
import 'package:app_kasir_sei_sapi/page/welcomePage.dart';
import 'package:provider/provider.dart';


import 'genosLib/bloc/baseBloc.dart';


class GenProvider {
  static var providers = [
    ChangeNotifierProvider<BaseBloc>.value(value: BaseBloc()),

  ];

  static routes(context) {
    return {
//           '/': (context) {
//        return Base();
//      },

      '/': (context) {
        return SplashScreen();
      },


      'welcome': (context) {
        return WelcomePage();
      },

      'home': (context) {
        return Base();
      },

      'detail': (context) {
        return DetailPage();
      },

      'keranjang': (context) {
        return KeranjangPage();
      },

      'login': (context) {
        return LoginPage();
      },

      'suksesPesan': (context) {
        return SuksesPesanPage();
      },
    };
  }
}
