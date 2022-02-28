import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pesen_id/controllers/detail_c.dart';
import 'package:pesen_id/models/lapangan_m.dart';
import 'package:pesen_id/models/mitra_m.dart';
import 'package:pesen_id/service/detail_service.dart';
import 'package:pesen_id/utils/app_text.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

class AppDialog {
  static btmDialog(
    LapanganM _lapangan,
  ) {
    final _detailC = Get.find<DetailC>();
    return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: DetailService().fetchMitraByID(_lapangan.idMitra!),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              _detailC.saveInfoMitra(snapshot.data!);
              return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: DetailService().fetchDetailMitra(_lapangan.idMitra!),
                builder: (ctx, snapshot2) {
                  if (snapshot2.hasData) {
                    _detailC.saveDetailMitra(snapshot2.data!.docs);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 100,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
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
                                border: Border.all(color: Colors.grey.shade400),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _detailC.infoMitra[0].image!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                AppText.labelMontsW500(
                                  _detailC.infoMitra[0].name!,
                                  16,
                                  Colors.black,
                                ),
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: const RotationTransition(
                                turns: AlwaysStoppedAnimation(60 / 360),
                                child: Icon(
                                  CupertinoIcons.location_north_fill,
                                ),
                              ),
                            )
                          ],
                        ),
                        if (_detailC.detailMitra.isNotEmpty)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.labelMonts(
                                    "Fasilitas", 14, Colors.grey),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: ListView(
                                    children: List.generate(
                                      _detailC.detailMitra[0].fasilitas!.length,
                                      (i) => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AppText.labelMonts("${i + 1}.", 12,
                                              Colors.grey.shade400),
                                          AppText.labelMonts(
                                            _detailC
                                                .detailMitra[0].fasilitas![i],
                                            12,
                                            Colors.grey.shade400,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  } else if (snapshot2.hasError) {
                    return Center(
                        child: AppText.labelMontsW500(
                            snapshot2.error.toString(), 16, Colors.grey));
                  } else {
                    return Platform.isAndroid
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Center(
                            child: CupertinoActivityIndicator(),
                          );
                  }
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      persistent: false,
      enableDrag: true,
      enterBottomSheetDuration: const Duration(
        milliseconds: 400,
      ),
      isDismissible: true,
      backgroundColor: Colors.transparent,
    );
  }

  static bottomSheetMitra(MitraM mitra) {
    return Get.bottomSheet(
      Container(
        height: Get.height / 2.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
      ),
    );
  }
}
