import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesen_id/controllers/dashboard_c.dart';
import 'package:pesen_id/routes/routes_name.dart';
import 'package:pesen_id/service/dashboard_service.dart';
import 'package:pesen_id/utils/app_const.dart';
import 'package:pesen_id/utils/app_dialog.dart';
import 'package:pesen_id/views/dynamic_stream_builder.dart';
import 'package:pesen_id/utils/app_text.dart';
import 'package:pesen_id/views/dashboard/dash_lapangan_card.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dashboardC = Get.find<DashboardC>();
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _dashboardC.refreshPage,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/man.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.labelMontsW500(
                            "Anonime",
                            16,
                            Colors.black,
                          ),
                          AppText.labelMonts(
                            "Babelan, Bekasi Utara",
                            14,
                            Colors.grey,
                          )
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutesName.search),
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutesName.menu),
                        child: Icon(
                          CupertinoIcons.square_grid_2x2_fill,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 30,
                    width: Get.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        listCategory.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade200,
                              ),
                              child: AppText.labelMontsW500(
                                listCategory[index].categoryName!,
                                12,
                                Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: DashboardService().streamLapangan(),
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isEmpty) {
                          return const SizedBox();
                        } else {
                          _dashboardC.saveLapangan(snapshot.data!.docs);
                          return const DashLapanganCard();
                        }
                      } else if (snapshot.hasError) {
                        return DynamicError(
                            errorMsg: snapshot.error.toString());
                      } else {
                        return const ShimmerDashLapanganCard();
                      }
                    },
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: DashboardService().streamMitra(),
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        _dashboardC.saveMitra(snapshot.data!.docs);
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText.labelMontsW500(
                                  "Disekitar Anda",
                                  16,
                                  Colors.black,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: AppText.labelMontsW500(
                                    "Telusuri",
                                    12,
                                    Colors.blue.shade400,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: Get.width,
                              height: Get.height / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Obx(
                                    () => FlutterMap(
                                      options: MapOptions(
                                        minZoom: _dashboardC.minZoom.value,
                                        maxZoom: _dashboardC.maxZoom.value,
                                        zoom: _dashboardC.zoom.value,
                                        center: _dashboardC.myLocation,
                                      ),
                                      nonRotatedLayers: [
                                        TileLayerOptions(
                                          urlTemplate: mapBoxUrl,
                                          additionalOptions: {
                                            'access_token': mapBoxToken,
                                            'id': mapBoxStyle,
                                          },
                                        ),
                                        MarkerLayerOptions(
                                          markers: List.generate(
                                            _dashboardC.listMitra.length,
                                            (index) => Marker(
                                              width: 30,
                                              height: 30,
                                              point: LatLng(
                                                _dashboardC
                                                    .listMitra[index].lat!,
                                                _dashboardC
                                                    .listMitra[index].long!,
                                              ),
                                              builder: (_) => GestureDetector(
                                                onTap: () =>
                                                    AppDialog.bottomSheetMitra(
                                                  _dashboardC.listMitra[index],
                                                ),
                                                child: Image.asset(
                                                  _dashboardC.listMitra[index]
                                                              .category ==
                                                          1
                                                      ? "assets/images/pin-futsal.png"
                                                      : _dashboardC
                                                                  .listMitra[
                                                                      index]
                                                                  .category ==
                                                              2
                                                          ? "assets/images/pin-badminton.png"
                                                          : _dashboardC
                                                                      .listMitra[
                                                                          index]
                                                                      .category ==
                                                                  3
                                                              ? "assets/images/pin-bola.png"
                                                              : _dashboardC
                                                                          .listMitra[
                                                                              index]
                                                                          .category ==
                                                                      4
                                                                  ? "assets/images/pin-volly.png"
                                                                  : _dashboardC
                                                                              .listMitra[index]
                                                                              .category ==
                                                                          5
                                                                      ? "assets/images/pin-basket.png"
                                                                      : "assets/images/pin-others.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        MarkerLayerOptions(
                                          markers: [
                                            Marker(
                                              width: 30,
                                              height: 30,
                                              point: _dashboardC.myLocation,
                                              builder: (_) => GestureDetector(
                                                onTap: () =>
                                                    Get.defaultDialog(),
                                                child: Image.asset(
                                                  "assets/images/pin.png",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          25,
                                        ),
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      width: 100,
                                      height: 30,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () =>
                                                  _dashboardC.zoomOut(),
                                              child: const Icon(
                                                Icons.remove_rounded,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 2,
                                            height: 28,
                                            color: Colors.grey.shade300,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () => _dashboardC.zoomIn(),
                                              child: const Icon(
                                                Icons.add_rounded,
                                                size: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.horizontal,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AppText.labelMonts(
                                      "Futsal",
                                      12,
                                      Colors.grey,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF51C4EF),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AppText.labelMonts(
                                      "Badminton",
                                      12,
                                      Colors.grey,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF51EFAB),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AppText.labelMonts(
                                      "Sepak Bola",
                                      12,
                                      Colors.grey,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE4EF51),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AppText.labelMonts(
                                      "Volley",
                                      12,
                                      Colors.grey,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFF02CE),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AppText.labelMonts(
                                      "Basket",
                                      12,
                                      Colors.grey,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFBEBFC0),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AppText.labelMonts(
                                      "Others",
                                      12,
                                      Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 1,
                    color: Colors.white,
                    semanticContainer: true,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      width: Get.width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.labelMontsW500(
                                "Ga punya lawan?",
                                16,
                                Colors.black,
                              ),
                              AppText.labelMontsW500(
                                "Cari sparingan disini..!",
                                14,
                                Colors.grey.shade400,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: AppText.labelMontsBold(
                                "Cari",
                                12,
                                Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: DashboardService().streamLapangan(),
                      builder: (ctx, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isEmpty) {
                            return const SizedBox();
                          } else {
                            _dashboardC.saveAllLapangan(snapshot.data!.docs);
                            return const DashAllLapanganCard();
                          }
                        } else if (snapshot.hasError) {
                          return DynamicError(
                              errorMsg: snapshot.error.toString());
                        } else {
                          return const ShimmerDashLapanganCard();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
