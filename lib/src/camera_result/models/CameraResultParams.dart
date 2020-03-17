class CameraResultParams {
  int categoryIdx;
  String thumbnail;
  String videoUrl;
  String videoText;
  String address;
  double lat;
  double lng;
  int days;
  String tripImgUrl;
  String country;
  String city;


  CameraResultParams({this.categoryIdx, this.thumbnail, this.videoUrl,
      this.videoText, this.address, this.lat, this.lng, this.days,
      this.tripImgUrl, this.country, this.city});

  CameraResultParams.fromJson(Map<String, dynamic> json)
      : categoryIdx = json['categoryIdx'],
        thumbnail = json['thumnail'],
        videoUrl = json['videoLink'],
        videoText = json['videoText'],
        address = json['address'],
        lat = json['latitude'],
        lng = json['longitude'],
        days = json['days'],
        tripImgUrl = json['tripImg'],
        country = json['country'],
        city = json['city'];

  Map<String, dynamic> toJson() => {
    'categoryIdx' : categoryIdx,
    'thumnail' : thumbnail,
    'videoLink' : videoUrl,
    'videoText' : videoText,
    'address' : address,
    'latitude' : lat,
    'longitude' : lng,
    'days' : days,
    'tripImg' : tripImgUrl,
    'country' : country,
    'city' : city
  };
}
