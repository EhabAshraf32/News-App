// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/cubit.dart';
import 'package:newsapp/controller/states.dart';
import 'package:newsapp/model/NewsModel.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Widgets/Widgets.dart';

class Dataserch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? NewsCubit.get(context).articles
        : NewsCubit.get(context).articles.where(
            (p) {
              return p.title.toLowerCase().contains(query.toLowerCase()) ||
                  p.description.toLowerCase().contains(query.toLowerCase());
            },
          ).toList();
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                launchUrlString(suggestionList[index].url);
                // Get.to(WebViewScreen(
                //     Url: data.articles[index].url));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 4, right: 4),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      height: MediaQuery.of(context).size.height / 4.8,
                      width: MediaQuery.of(context).size.width / 2.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              suggestionList[index].urlToImage.toString()),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(3, 0))
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // child: Image.network(
                      //   data.articles[index].urlToImage
                      //       .toString(),
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        TextWidget(
                          theme: Theme.of(context).textTheme.bodySmall,
                          context: context,
                          text: suggestionList[index].title,
                          // fontsize: 15,
                          // fontWeight:
                          //     FontWeight.bold
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextWidget(
                          theme: Theme.of(context).textTheme.displayLarge,
                          context: context,
                          text: suggestionList[index].description.toString(),
                          // fontsize: 15,
                          // fontWeight:
                          //     FontWeight.normal
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              suggestionList[index].publishedAt.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 230, 78, 111),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
        separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }
}
