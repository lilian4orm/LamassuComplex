class QrGenerate {
  bool? error;
  String? results;
  String? contentUrl;

  QrGenerate({this.error, this.results, this.contentUrl});

  QrGenerate.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    results = json['results'];
    contentUrl = json['content_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['results'] = this.results;
    data['content_url'] = this.contentUrl;
    return data;
  }
}