// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/controller/states.dart';

import '../Widgets/Widgets.dart';
import '../controller/cubit.dart';

class Sports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            // appBar: appBar(context),
            body: FullBody(context, NewsCubit.get(context).getsportsData()));
      },
    );
  }
}
