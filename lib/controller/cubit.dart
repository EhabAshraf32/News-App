// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_brace_in_string_interps, avoid_print, prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/states.dart';
import 'package:newsapp/helper/cash_helper.dart';
import 'package:newsapp/model/NewsModel.dart';
import 'package:newsapp/view/Business.dart';
import 'package:newsapp/view/science.dart';
import 'package:http/http.dart' as http;

import '../view/sport.dart';

class NewsCubit extends Cubit<NewsStates> {
  final String ss =
      "https://newsapi.org/v2/everything?q=Apple&apiKey=09c1bf8764234c88ad8994e577b459e0";
  final String sk = "6ea12d258e614372bfb6f9881afd9cf0";
  NewsCubit() : super(NewsInitialStates());
  static NewsCubit get(context) => BlocProvider.of(context);
  List<Article> articles = [];

  List<Widget> pages = [Business(), Sports(), Science()];
  int selectedindex = 0;

  void ChangeIndex(index) {
    selectedindex = index;
    emit(BottomNaviState());
  }

  var result;
  List list = [];
  getData(String cat) async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=eg&category=${cat}&apiKey=e11fc469226b4c669acaeb361d2a01df");
    http.Response response = await http.get(url);
    result = json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        // list.addAll(result);
        // print(list);
        // return result;

        return Articles.fromJson(jsonDecode(response.body));
      } catch (e) {
        Get.snackbar("error", e.toString());
      }
      emit(GetScienceDataState());
    }
  }

  getAllData() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=6ffb5955a25044f08e64ace555647301");
    http.Response response = await http.get(url);
    result = json.decode(response.body);
    print(result);
    if (response.statusCode == 200) {
      try {
        // list.addAll(result);
        // print(list);
        //return result;

        return Articles.fromJson(jsonDecode(response.body));
      } catch (e) {
        Get.snackbar("error", e.toString());
        //Get.showSnackbar(GetSnackBar());
      }
    }
    emit(GetScienceDataState());
  }

  getsportsData() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=6ffb5955a25044f08e64ace555647301");
    http.Response response = await http.get(url);
    result = json.decode(response.body);
    print(result);
    if (response.statusCode == 200) {
      try {
        // list.addAll(result);
        // print(list);
        //return result;

        return Articles.fromJson(jsonDecode(response.body));
      } catch (e) {
        Get.snackbar("error", e.toString());
        //Get.showSnackbar(GetSnackBar());
      }
    }
    emit(GetSportsDataState());
  }

  getBusinessData() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6ffb5955a25044f08e64ace555647301");
    http.Response response = await http.get(url);
    result = json.decode(response.body);
    print(result);
    if (response.statusCode == 200) {
      try {
        // list.addAll(result);
        // print(list);
        //return result;

        return Articles.fromJson(jsonDecode(response.body));
      } catch (e) {
        Get.snackbar("error", e.toString());
        //Get.showSnackbar(GetSnackBar());
      }
    }
    emit(GetBusinessDataState());
  }

  List<Article> search = [];
  getSearchData(String value) async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&q=${value}&apiKey=6ffb5955a25044f08e64ace555647301");
    http.Response response = await http.get(url);
    result = json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        search = List<Article>.from(
            result["articles"].map((x) => Article.fromJson(x)));
        emit(GetSearchStateSuccess());
        // return Articles.fromJson(
        //     result); // Return the Articles object from the search result
      } catch (e) {
        Get.snackbar("error", e.toString());
        emit(GetSearchStateError());
        //return Articles(status: "error", totalResults: 0, articles: []);
      }
    } else {
      // Handle error scenarios
      emit(GetSearchStateError());
      //return Articles(status: "error", totalResults: 0, articles: []);
    }
  }

  var localee = Locale(Platform.localeName.substring(0, 2));
  bool loc = false;

  changeloc() {
    loc = !loc;
    emit(ChangelanguageState());
  }

  changlanguage() {
    if (localee == Locale("ar")) {
      localee = Locale("en");
    } else {
      localee = Locale("ar");
    }
    emit(ChangelanguageState());
    print(localee);
  }

  bool isDark = false;
  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeThemeModeState());
    } else {
      isDark = !isDark;
      CashHelper.putData(key: "isDark", value: isDark)
          .then((value) => emit(ChangeThemeModeState()));
    }
  }
}
