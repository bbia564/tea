class RecordModel {
  int? id;
  String? title;
  String? comment;
  String? image;
  String? time;
  int? record;

  RecordModel({this.id, this.title, this.comment, this.image, this.time});

  RecordModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    comment = json['comment'];
    image = json['image'];
    time = json["time"];
    record = json["record"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['comment'] = comment;
    data['image'] = image;
    data['time'] = time;
    data['record'] = record;

    return data;
  }
}
