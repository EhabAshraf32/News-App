// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors, must_be_immutable, prefer_typing_uninitialized_variables
// ignore_for_file: prefer_const_constructors,, unused_local_variable
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:newsapp/Widgets/Widgets.dart';
import 'package:newsapp/constants/Colors.dart';
import 'package:newsapp/controller/cubit.dart';
import 'package:newsapp/controller/states.dart';
import 'package:newsapp/helper/cash_helper.dart';
import 'controller/blockObserve.dart';
import 'layout/bottomNaviBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  //DioHelper.init();
  var isDark = CashHelper.getData(key: "isDark");
  runApp(MyApp(isDark));

  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  var isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..changeThemeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return GetMaterialApp(
              darkTheme: ThemeData(
                textTheme: TextTheme(
                  bodyLarge: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                  bodyMedium: TextStyle(
                      color: primarycolor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  bodySmall: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  displayLarge: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                appBarTheme: AppBarTheme(
                    titleTextStyle: TextStyle(color: Colors.white),
                    iconTheme: IconThemeData(color: Colors.white),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color(0xFF202d3f),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: Color(0xFF202d3f),
                    elevation: 5),
                scaffoldBackgroundColor: Color(0xFF171e27),
                primaryColor: Colors.orange,
                primarySwatch: materialOrange,
              ),
              themeMode: NewsCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              locale: NewsCubit.get(context).loc == false
                  ? Locale("en")
                  : Locale("ar"),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  textTheme: TextTheme(
                    bodyLarge: TextStyle(
                        color: primarycolor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                    bodyMedium: TextStyle(
                        color: primarycolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    bodySmall: TextStyle(
                        color: primarycolor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    displayLarge: TextStyle(
                        color: Color.fromARGB(255, 124, 112, 112),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      // backgroundColor: Colors.transparent,
                      // selectedItemColor: primarycolor,
                      // unselectedItemColor: Colors.grey,
                      // selectedIconTheme: IconThemeData(color: primarycolor)

                      ),
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(color: primarycolor),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0)),
              debugShowCheckedModeBanner: false,
              home: BotttomNavigationBar());
        },
      ),
    );
  }
}
