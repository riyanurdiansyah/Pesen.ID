import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:pesen_id/service/firebase/analytics_service.dart';
import 'package:pesen_id/utils/app_const.dart';
import 'package:pesen_id/utils/app_text.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title: AppText.labelMontsW500("Menu", 16, Colors.black),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: ListView.separated(
          itemBuilder: (ctx, i) => ListTile(
            onTap: () {
              String _route = listSideMenu[i].route!.split("/")[1];
              FirebaseAnalyticsService()
                  .changePage('${_route.trimLeft()}_view');
            },
            leading: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Image.asset(
                  "assets/images/" + listSideMenu[i].img!,
                  width: 25,
                ),
              ),
            ),
            title: AppText.labelMontsW500(
              listSideMenu[i].title!,
              14,
              Colors.black,
            ),
          ),
          separatorBuilder: (ctx, i) => Container(
            height: 2,
            color: Colors.grey.shade200,
          ),
          itemCount: listSideMenu.length,
        ),
      ),
    );
  }
}
