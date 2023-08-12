// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/constants/Colors.dart';
import 'package:newsapp/controller/cubit.dart';
import 'package:newsapp/model/NewsModel.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../view/searchScreen.dart';

AppBar appBar(context) {
  return AppBar(
    title: TextWidget(
        context: context,
        text: "News App",
        theme: Theme.of(context).textTheme.bodyLarge
        // fontsize: 26,
        // fontWeight: FontWeight.bold
        ),
    //backgroundColor: Colors.white,
    //elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 3),
        child: IconButton(
          onPressed: () {
            NewsCubit.get(context).changlanguage();
          },
          icon: Icon(
            Icons.language,
            //color: primarycolor,
            size: 28,
          ),
        ),
      ),
      IconButton(
        onPressed: () {
          NewsCubit.get(context).changeThemeMode();
        },
        icon: NewsCubit.get(context).isDark
            ? Icon(
                Icons.dark_mode,
                //color: primarycolor,
                size: 28,
              )
            : Icon(
                Icons.light_mode,
                //color: primarycolor,
                size: 28,
              ),
      ),
    ],
  );
}

Text TextWidget(
    {context,
    required String text,
    required var theme,
    int MaXLines = 4,
    TextOverflow textOverFlow = TextOverflow.visible
    // required double fontsize,
    // required FontWeight fontWeight,
    }) {
  return Text(
    maxLines: MaXLines,
    overflow: textOverFlow,
    text,
    style: theme
    //  TextStyle(
    //     color: primarycolor,
    //     fontSize: fontsize,
    //     overflow: TextOverflow.ellipsis,
    //     fontWeight: fontWeight,
    //     wordSpacing: 2)
    ,
  );
}

ListView NewsView(Articles data) {
  return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: data.articles.length,
      itemBuilder: (context, index) => InkWell(
            onTap: () {
              launchUrlString(data.articles[index].url);
              // Get.to(WebViewScreen(
              //     Url: data.articles[index].url));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 4, right: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    height: MediaQuery.of(context).size.height / 4.8,
                    width: MediaQuery.of(context).size.width / 2.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            data.articles[index].urlToImage.toString()),
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: primarycolor,
                      //       spreadRadius: 2,
                      //       blurRadius: 5,
                      //       offset: Offset(-1, 0))
                      // ],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    // child: Image.network(
                    //   data.articles[index].urlToImage
                    //       .toString(),
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                  Spacer(),
                  Container(
                    width: 150,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          theme: Theme.of(context).textTheme.bodySmall,
                          context: context,
                          textOverFlow: TextOverflow.fade,
                          text: data.articles[index].title,
                          // fontsize: 15,
                          // fontWeight:
                          //     FontWeight.bold
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                          theme: Theme.of(context).textTheme.displayLarge,
                          context: context,
                          MaXLines: 2,
                          textOverFlow: TextOverflow.ellipsis,
                          text: data.articles[index].description.toString(),
                          // fontsize: 15,
                          // fontWeight:
                          //     FontWeight.normal
                        ),
                        Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              data.articles[index].publishedAt.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
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
          ),
      separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 4, right: 20, top: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ));
}

MaterialColor materialOrange = MaterialColor(
  0xFFEF6C00, // this is the primary color, it is set to the value of orange[800]
  <int, Color>{
    50: Color(0xFFFFF3E0),
    100: Color(0xFFFFE0B2),
    200: Color(0xFFFFCC80),
    300: Color(0xFFFFB74D),
    400: Color(0xFFFFA726),
    500: Color(0xFFF57C00),
    600: Color(0xFFF57C00),
    700: Color(0xFFF57C00),
    800: Color(0xFFEF6C00),
    900: Color(0xFFE65100),
  },
);

Padding FullBody(BuildContext context, Future<dynamic> getdata) {
  return Padding(
      //TODO:You need to adding padding right by :20
      // padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  context: context,
                  text: "Search", //AppLocalizations.of(context)!.search,
                  theme: Theme.of(context).textTheme.bodyLarge
                  // fontsize: 26,
                  // fontWeight: FontWeight.bold
                  ),
              SizedBox(
                height: 6,
              ),
              TextWidget(
                  context: context,
                  text: "your daily news",
                  theme: Theme.of(context).textTheme.bodyLarge
                  // fontsize: 26,
                  // fontWeight: FontWeight.bold
                  ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  // NewsCubit.get(context).getAllData();
                  Get.to(SearchScreen(getdatacategory: getdata));
                  // showSearch(context: context, delegate: Dataserch());
                },
                child: Container(
                    margin: EdgeInsets.only(right: 4, left: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: primarycolor,
                            size: 28,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          TextWidget(
                            theme: Theme.of(context).textTheme.bodyMedium,
                            context: context,
                            text: "search news here",
                            // fontsize: 18,
                            // fontWeight: FontWeight.bold
                          )
                        ],
                      ),
                    )),
              ),
              FutureBuilder(
                future: getdata,
                builder: (context, AsyncSnapshot snapshot) {
                  Articles data = snapshot.data;
                  if (snapshot.hasData) {
                    return NewsView(data);
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
          )));
}
