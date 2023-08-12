// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:newsapp/constants/Colors.dart';
import 'package:newsapp/controller/cubit.dart';
import 'package:newsapp/controller/states.dart';
import 'package:newsapp/model/NewsModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newsapp/view/searchScreen.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Widgets/Widgets.dart';
import 'SearchDelegate.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            // appBar: appBar(context),
            body: FullBody(context, NewsCubit.get(context).getBusinessData()));
      },
    );
  }
}
