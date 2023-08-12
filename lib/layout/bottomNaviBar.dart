// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Widgets/Widgets.dart';
import 'package:newsapp/constants/Colors.dart';
import 'package:newsapp/controller/states.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controller/cubit.dart';

class BotttomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: appBar(context),
          bottomNavigationBar: SalomonBottomBar(
              backgroundColor: Colors.transparent,
              curve: Curves.easeInOutQuart,
              currentIndex: NewsCubit.get(context).selectedindex,
              onTap: (index) {
                NewsCubit.get(context).ChangeIndex(index);
              },
              items: [
                SalomonBottomBarItem(
                    unselectedColor: Colors.blueGrey,
                    selectedColor: Colors.orangeAccent,
                    icon: Icon(Icons.business),
                    title: Text("Business")),
                SalomonBottomBarItem(
                    selectedColor: Colors.orangeAccent,
                    unselectedColor: Colors.blueGrey,
                    icon: Icon(Icons.sports),
                    title: Text("Sports")),
                SalomonBottomBarItem(
                    selectedColor: Colors.orangeAccent,
                    unselectedColor: Colors.blueGrey,
                    icon: Icon(Icons.science),
                    title: Text("Science")),
              ]),
          body: NewsCubit.get(context)
              .pages[NewsCubit.get(context).selectedindex], //,
        );
      },
    );
  }
}
