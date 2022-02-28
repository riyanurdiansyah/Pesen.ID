import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pesen_id/models/booking_m.dart';
import 'package:pesen_id/models/mitra_detail_m.dart';
import 'package:pesen_id/models/mitra_m.dart';
import 'package:get/get.dart';

class DetailC extends GetxController {
  var indexIndicator = 0.obs;
  final RxList<DateTime> _dates = <DateTime>[].obs;
  RxList<DateTime> get dates => _dates;
  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  Rx<DateTime> get selectedDate => _selectedDate;

  final RxList<BookingM> _listBooking = <BookingM>[].obs;
  RxList<BookingM> get listBooking => _listBooking;
  final RxList<BookingM> _listBookingTemp = <BookingM>[].obs;
  RxList<BookingM> get listBookingTemp => _listBookingTemp;
  final RxList<int> _listTime = <int>[].obs;
  RxList<int> get listTime => _listTime;

  final RxList<MitraM> _infoMitra = <MitraM>[].obs;
  RxList<MitraM> get infoMitra => _infoMitra;

  final RxList<MitraDetailM> _detailMitra = <MitraDetailM>[].obs;
  RxList<MitraDetailM> get detailMitra => _detailMitra;

  final Rx<int> _selectedTime = 00.obs;
  Rx<int> get selectedTime => _selectedTime;
  List<int> schedulePagi = List.generate(8, (index) => 8 + index * 1);
  List<int> scheduleSore = List.generate(9, (index) => 16 + index * 1);
  @override
  void onInit() {
    super.onInit();
    generateDate();
  }

  void swipeImage(int index) {
    indexIndicator.value = index;
  }

  void generateDate() {
    dates.value =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate.value = dates[0];
  }

  void onTapDate(DateTime date) {
    _selectedDate.value = date;
    _selectedTime.value = 00;
    _listBooking.value = _listBookingTemp
        .where((e) => DateTime.parse(e.date!).day == date.day)
        .toList();
  }

  void onTapTime(int time) {
    _selectedTime.value = time;
  }

  void saveLapangan(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    _listBookingTemp.clear();
    _listTime.clear();
    for (var data in docs) {
      _listBookingTemp.add(BookingM.fromJson(data.data()));
      _listTime.add(data.data()['time']);
    }
    _listBooking.value = _listBookingTemp;
    _listTime.sort((a, b) => a.compareTo(b));
    _listBooking.value = _listBookingTemp
        .where((e) => DateTime.parse(e.date!).day == _selectedDate.value.day)
        .toList();
  }

  saveInfoMitra(DocumentSnapshot<Map<String, dynamic>> data) {
    _infoMitra.clear();
    _infoMitra.add(MitraM.fromJson(data.data()!));
  }

  saveDetailMitra(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    _detailMitra.clear();
    for (var data in docs) {
      _detailMitra.add(MitraDetailM.fromJson(data.data()));
    }
  }
}
