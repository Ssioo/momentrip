class MainParams {
  String startDate;
  String endDate;

  MainParams({this.startDate, this.endDate});

  MainParams.fromJson(Map<String, dynamic> json) :
        startDate = json['startedAt'],
        endDate = json['endedAt'];

  Map<String, dynamic> toJson() => {
    'startedAt' : startDate,
    'endedAt' : endDate
  };
}