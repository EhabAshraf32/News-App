// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Widgets/Widgets.dart';
import 'package:newsapp/constants/Colors.dart';
import 'package:newsapp/controller/states.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controller/cubit.dart';
import '../model/NewsModel.dart';

class SearchScreen extends StatelessWidget {
  Future<dynamic> getdatacategory;
  SearchScreen({
    Key? key,
    required this.getdatacategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final newsCubit = NewsCubit.get(context);
        return Scaffold(
          body: GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 4, left: 4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.grey, blurRadius: 5, offset: Offset(0, 3))
                            // ],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20))),
                        width: double.infinity,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              onChanged: (value) {
                                NewsCubit.get(context).getSearchData(value);
                              },
                              validator: (txt) {
                                if (txt!.isEmpty) {
                                  return "search must not be empty";
                                }
                                return null;
                              },
                              autofocus: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: primarycolor,
                                  size: 28,
                                ),
                                label: TextWidget(
                                  theme: Theme.of(context).textTheme.bodyMedium,
                                  context: context,
                                  text: "search news here",
                                ),
                              ),
                            ))),
                    FutureBuilder(
                      future: getdatacategory,
                      builder: (context, AsyncSnapshot snapshot) {
                        //Articles data = snapshot.data;

                        if (snapshot.hasData) {
                          if (state is GetSearchStateSuccess) {
                            return NewsView(Articles(
                              status: "ok",
                              totalResults: newsCubit.search.length,
                              articles: newsCubit.search,
                            ));
                          } else {
                            return NewsView(snapshot.data!);
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: primarycolor,
                              backgroundColor: Colors.grey,
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
