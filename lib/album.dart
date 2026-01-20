class Album {
int? id;
String? title;
String? url;
String? thumbnailUrl;

Album({this.id, this.title, this.url, this.thumbnailUrl});

Album.fromJson(Map<String, dynamic> json) {
id = json['id'];
title = json['title'];
url = json['url'];
thumbnailUrl = json['thumbnailUrl'];
}
}