class Clouds {
  Clouds({
    required    this.all,});

  Clouds.fromJson(dynamic json) {
    all = json['all'];
  }
 late int all;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['all'] = all;
    return map;
  }

}