class NotificationMD {
  int? idN;
  String? textN;
  int? readStatus;
  String? created;
  int? userId;

  NotificationMD(
      {this.idN, this.textN, this.readStatus, this.created, this.userId});

  NotificationMD.fromJson(Map<String, dynamic> json) {
    idN = json['id_n'];
    textN = json['text_n'];
    readStatus = json['read_status'];
    created = json['created'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_n'] = idN;
    data['text_n'] = textN;
    data['read_status'] = readStatus;
    data['created'] = created;
    data['user_id'] = userId;
    return data;
  }
}
