import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pesen_id/controllers/dashboard_c.dart';
import 'package:pesen_id/routes/routes_name.dart';
import 'package:pesen_id/utils/app_text.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DashLapanganCard extends StatelessWidget {
  const DashLapanganCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dashboardC = Get.find<DashboardC>();
    return Column(
      children: List.generate(
        1,
        (i) => Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.labelMontsW500(
                    _dashboardC.listCategoryOne[0] == 1
                        ? "Futsal"
                        : _dashboardC.listCategoryOne[0] == 2
                            ? "Badminton"
                            : "Others",
                    16,
                    Colors.black,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: AppText.labelMontsW500(
                      "Lihat semua",
                      12,
                      Colors.blue.shade400,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: Get.size.width,
                height: Get.size.height / 4,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    _dashboardC.listLapanganOne
                        .where((e) => e.category == 1)
                        .toList()
                        .length,
                    (index) {
                      final _data = _dashboardC.listLapanganOne
                          .where((e) => e.category == 1)
                          .toList()[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutesName.detail,
                            arguments: [
                              _data,
                            ],
                          );
                        },
                        child: SizedBox(
                          width: Get.size.width / 1.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  semanticContainer: true,
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Hero(
                                    tag: _data.image![0],
                                    child: SizedBox(
                                      width: Get.size.width / 1.6,
                                      child: Image.network(
                                        _data.image![0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AppText.labelMontsBold(
                                            _data.name!,
                                            16,
                                            Colors.grey.shade500,
                                          ),
                                          AppText.labelMonts(
                                            "Lapangan ${_data.lapangan!}",
                                            12,
                                            Colors.grey.shade400,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        CupertinoIcons.star_circle,
                                        size: 18,
                                        color: Colors.yellow,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      AppText.labelMontsW500(
                                        "${_data.rating!}",
                                        12,
                                        Colors.grey.shade600,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashAllLapanganCard extends StatelessWidget {
  const DashAllLapanganCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dashboardC = Get.find<DashboardC>();
    return SizedBox(
      width: Get.width,
      height: (Get.height / 3) * _dashboardC.listCategory.length,
      child: Column(
        children: List.generate(
          _dashboardC.listCategory.length,
          (i) => Expanded(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.labelMontsW500(
                        _dashboardC.listCategory[i] == 1
                            ? "Futsal"
                            : _dashboardC.listCategory[i] == 2
                                ? "Badminton"
                                : "Others",
                        16,
                        Colors.black,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: AppText.labelMontsW500(
                          "Lihat semua",
                          12,
                          Colors.blue.shade400,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: Get.size.width,
                    height: Get.size.height / 4,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        _dashboardC.listLapangan
                            .where((e) =>
                                e.category == _dashboardC.listCategory[i])
                            .toList()
                            .length,
                        (index) {
                          final _data = _dashboardC.listLapangan
                              .where((e) =>
                                  e.category == _dashboardC.listCategory[i])
                              .toList()[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                AppRoutesName.detail,
                                arguments: [
                                  _data,
                                ],
                              );
                            },
                            child: SizedBox(
                              width: Get.size.width / 1.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.white,
                                      semanticContainer: true,
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Hero(
                                        tag: _data.image![0],
                                        child: SizedBox(
                                          width: Get.size.width / 1.6,
                                          child: Image.network(
                                            _data.image![0],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppText.labelMontsBold(
                                                _data.name!,
                                                16,
                                                Colors.grey.shade500,
                                              ),
                                              AppText.labelMonts(
                                                "Lapangan ${_data.lapangan!}",
                                                12,
                                                Colors.grey.shade400,
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            CupertinoIcons.star_circle,
                                            size: 18,
                                            color: Colors.yellow,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          AppText.labelMontsW500(
                                            "${_data.rating!}",
                                            12,
                                            Colors.grey.shade600,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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

class ShimmerDashLapanganCard extends StatelessWidget {
  const ShimmerDashLapanganCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height / 3,
      child: ListView(
        children: List.generate(
          1,
          (i) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 125,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                width: Get.size.width,
                height: Get.size.height / 4,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView(
                    children: List.generate(
                      5,
                      (index) => Card(
                        elevation: 2,
                        color: Colors.white,
                        semanticContainer: true,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          width: Get.size.width / 1.6,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
