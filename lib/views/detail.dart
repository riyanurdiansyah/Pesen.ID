import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pesen_id/controllers/detail_c.dart';
import 'package:pesen_id/models/lapangan_m.dart';
import 'package:pesen_id/service/detail_service.dart';
import 'package:pesen_id/utils/app_const.dart';
import 'package:pesen_id/utils/app_dateext.dart';
import 'package:pesen_id/utils/app_dialog.dart';
import 'package:pesen_id/utils/app_text.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LapanganM _lapanganM = Get.arguments[0];
    final _detailC = Get.find<DetailC>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: _lapanganM.image![0],
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 8),
                        width: Get.width / 1.0,
                        height: 225,
                        color: Colors.white,
                        child: CarouselSlider.builder(
                          itemCount: _lapanganM.image!.length,
                          options: CarouselOptions(
                            autoPlay: false,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: false,
                            reverse: false,
                            height: Get.height / 2,
                            aspectRatio: 1.0,
                            viewportFraction: 1.0,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (i, reaseon) =>
                                _detailC.swipeImage(i),
                          ),
                          itemBuilder: (context, index, currIndex) {
                            final image = _lapanganM.image![index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                elevation: 2,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.network(
                                  image!,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      width: Get.width,
                      height: 225,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.only(bottom: 15),
                          width: MediaQuery.of(context).size.width,
                          child: AnimatedSmoothIndicator(
                            activeIndex: _detailC.indexIndicator.value,
                            count: _lapanganM.image!.length,
                            effect: WormEffect(
                              dotWidth: 10,
                              dotHeight: 10,
                              dotColor: Colors.grey.shade500,
                              activeDotColor: Colors.grey.shade100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.labelMontsW500(
                                _lapanganM.name!, 18, Colors.black),
                            AppText.labelMontsW500(
                                "Lapangan ${_lapanganM.lapangan!}",
                                14,
                                Colors.grey),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.blue),
                            ),
                            onPressed: () {
                              AppDialog.btmDialog(_lapanganM);
                            },
                            child: Row(
                              children: [
                                AppText.labelMontsBold(
                                  "+",
                                  14,
                                  Colors.blue.shade600,
                                ),
                                AppText.labelMontsW500(
                                  "Info",
                                  14,
                                  Colors.blue.shade600,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade300,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Obx(
                () => Container(
                  height: Get.height / 10,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _detailC.dates.length,
                    itemBuilder: (_, index) => Container(
                      width: Get.width / 6.2,
                      margin: EdgeInsets.only(
                          left: (index == 0) ? 2 : 0,
                          right: (index < _detailC.dates.length - 1) ? 10 : 0),
                      child: InkWell(
                        onTap: () => _detailC.onTapDate(_detailC.dates[index]),
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: _detailC.selectedDate.value ==
                                      _detailC.dates[index]
                                  ? Colors.blue
                                  : Colors.transparent,
                              border: Border.all(
                                color: _detailC.selectedDate.value ==
                                        _detailC.dates[index]
                                    ? Colors.transparent
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (_detailC.selectedDate.value ==
                                        _detailC.dates[index])
                                    ? AppText.labelMontsW500(
                                        _detailC.dates[index].shortDayName,
                                        14,
                                        Colors.white)
                                    : AppText.labelMontsW500(
                                        _detailC.dates[index].shortDayName,
                                        14,
                                        Colors.black54),
                                const SizedBox(
                                  height: 6,
                                ),
                                (_detailC.selectedDate.value ==
                                        _detailC.dates[index])
                                    ? AppText.labelMontsW500(
                                        "${_detailC.dates[index].day}",
                                        14,
                                        Colors.white)
                                    : AppText.labelMontsW500(
                                        "${_detailC.dates[index].day}",
                                        14,
                                        Colors.black54)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: DetailService().streamBooking(_lapanganM.id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _detailC.saveLapangan(snapshot.data!.docs);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText.labelMontsW500(
                                  "Pagi ~ Siang",
                                  12,
                                  Colors.black,
                                ),
                                AppText.labelMontsW500(
                                  currencyFormatter.format(_detailC
                                                  .selectedDate.value.weekday ==
                                              DateTime.saturday ||
                                          _detailC.selectedDate.value.weekday ==
                                              DateTime.sunday
                                      ? _lapanganM.price! + _lapanganM.weekend!
                                      : _lapanganM.price!),
                                  14,
                                  Colors.grey.shade500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Wrap(
                            children: List.generate(
                              _detailC.schedulePagi.length,
                              (i) => Obx(
                                () => Container(
                                  width: Get.width / 6,
                                  height: 35,
                                  margin: const EdgeInsets.only(
                                      left: 3, right: 3, top: 6),
                                  child: InkWell(
                                    onTap: _detailC.listBooking.any((e) =>
                                            e.time == _detailC.schedulePagi[i])
                                        ? null
                                        : () => _detailC.onTapTime(
                                            _detailC.schedulePagi[i]),
                                    child: Obx(
                                      () => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: _detailC.listBooking.any((e) =>
                                                  e.time ==
                                                  _detailC.schedulePagi[i])
                                              ? Colors.grey.shade400
                                              : _detailC.schedulePagi[i] ==
                                                      _detailC
                                                          .selectedTime.value
                                                  ? Colors.blue.shade400
                                                  : Colors.transparent,
                                          border: Border.all(
                                            color: _detailC.schedulePagi[i] ==
                                                    _detailC.selectedTime.value
                                                ? Colors.blue
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Center(
                                          child: AppText.labelMontsW500(
                                            "${_detailC.schedulePagi[i]}:00",
                                            14,
                                            _detailC.listBooking.any((e) =>
                                                    e.time ==
                                                    _detailC.schedulePagi[i])
                                                ? Colors.white
                                                : _detailC.schedulePagi[i] ==
                                                        _detailC
                                                            .selectedTime.value
                                                    ? Colors.white
                                                    : Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText.labelMontsW500(
                                  "Sore ~ Malem",
                                  12,
                                  Colors.black,
                                ),
                                AppText.labelMontsW500(
                                  currencyFormatter.format(
                                    _detailC.selectedDate.value.weekday ==
                                                DateTime.saturday ||
                                            _detailC.selectedDate.value
                                                    .weekday ==
                                                DateTime.sunday
                                        ? _lapanganM.price! +
                                            _lapanganM.weekend! +
                                            _lapanganM.night!
                                        : _lapanganM.price! + _lapanganM.night!,
                                  ),
                                  14,
                                  Colors.grey.shade500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Wrap(
                            children: List.generate(
                              _detailC.schedulePagi.length,
                              (i) => Obx(
                                () => Container(
                                  width: Get.width / 6,
                                  height: 35,
                                  margin: const EdgeInsets.only(
                                      left: 3, right: 3, top: 6),
                                  child: InkWell(
                                    onTap: _detailC.listBooking.any((e) =>
                                            e.time == _detailC.scheduleSore[i])
                                        ? null
                                        : () => _detailC.onTapTime(
                                            _detailC.scheduleSore[i]),
                                    child: Obx(
                                      () => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: _detailC.listBooking.any((e) =>
                                                  e.time ==
                                                  _detailC.scheduleSore[i])
                                              ? Colors.grey.shade400
                                              : _detailC.scheduleSore[i] ==
                                                      _detailC
                                                          .selectedTime.value
                                                  ? Colors.blue.shade400
                                                  : Colors.transparent,
                                          border: Border.all(
                                            color: _detailC.scheduleSore[i] ==
                                                    _detailC.selectedTime.value
                                                ? Colors.blue
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Center(
                                          child: AppText.labelMontsW500(
                                            "${_detailC.scheduleSore[i]}:00",
                                            14,
                                            _detailC.listBooking.any((e) =>
                                                    e.time ==
                                                    _detailC.scheduleSore[i])
                                                ? Colors.white
                                                : _detailC.scheduleSore[i] ==
                                                        _detailC
                                                            .selectedTime.value
                                                    ? Colors.white
                                                    : Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 120,
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: AppText.labelMontsW500(
                        snapshot.error.toString(),
                        16,
                        Colors.grey,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 60,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), // HERE
                      ),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: AppText.labelMontsW500(
                      "Pesan Sekarang",
                      16,
                      Colors.white,
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
