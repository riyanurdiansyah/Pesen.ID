import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pesen_id/models/lapangan_m.dart';
import 'package:pesen_id/models/mitra_m.dart';
import 'package:pesen_id/service/dashboard_service.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class DashboardC extends GetxController {
  final RxList<LapanganM> _listLapanganOne = <LapanganM>[].obs;
  RxList<LapanganM> get listLapanganOne => _listLapanganOne;
  final RxList<LapanganM> _listLapangan = <LapanganM>[].obs;
  RxList<LapanganM> get listLapangan => _listLapangan;
  List<int> _listCategoryOne = <int>[].obs;
  List<int> get listCategoryOne => _listCategoryOne.obs;
  List<int> _listCategory = <int>[].obs;
  List<int> get listCategory => _listCategory.obs;
  final myLocation = LatLng(-6.185941, 107.009121);

  final RxList<MitraM> _listMitra = <MitraM>[].obs;
  RxList<MitraM> get listMitra => _listMitra;

  Rx<double> minZoom = 5.0.obs;
  Rx<double> maxZoom = 20.0.obs;
  Rx<double> zoom = 14.0.obs;

  void saveLapangan(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    _listLapanganOne.clear();
    _listCategoryOne.clear();
    for (var data in docs) {
      _listLapanganOne.add(LapanganM.fromJson(data.data()));
      _listCategoryOne.add(data.data()['category']);
    }
    _listCategoryOne.shuffle();
    _listCategoryOne = _listCategoryOne.toSet().toList();
  }

  void saveAllLapangan(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    _listLapangan.clear();
    _listCategory.clear();
    for (var data in docs) {
      _listLapangan.add(LapanganM.fromJson(data.data()));
      _listCategory.add(data.data()['category']);
    }
    _listCategory.shuffle();
    _listCategory = _listCategory.toSet().toList();
    _listCategory.removeWhere((e) => e == 1);
  }

  void saveMitra(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    _listMitra.clear();
    for (var data in docs) {
      _listMitra.add(MitraM.fromJson(data.data()));
    }
  }

  Future<void> refreshPage() {
    DashboardService().streamMitra();
    DashboardService().streamLapangan();
    return Future.delayed(const Duration(seconds: 2));
  }

  void zoomOut() {
    zoom = zoom - 2;
    minZoom = minZoom - 5;
  }

  void zoomIn() {
    zoom = zoom + 2;
    maxZoom = maxZoom + 5;
  }
}
