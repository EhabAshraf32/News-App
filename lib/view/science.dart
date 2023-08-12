import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/controller/cubit.dart';
import 'package:newsapp/controller/states.dart';

import '../Widgets/Widgets.dart';

class Science extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            // appBar: appBar(context),
            body: FullBody(context, NewsCubit.get(context).getAllData()));
      },
    );
  }
}
