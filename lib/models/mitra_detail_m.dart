class MitraDetailM {
  MitraDetailM({
    this.rules,
    this.fasilitas,
  });

  List<dynamic>? rules;
  List<dynamic>? fasilitas;

  factory MitraDetailM.fromJson(Map<String, dynamic> json) => MitraDetailM(
        rules: json["rules"],
        fasilitas: json["fasilitas"],
      );
}
