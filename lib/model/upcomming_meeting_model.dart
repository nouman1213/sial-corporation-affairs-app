class UpComingMeetingModel {
  int? tid;
  String? tdate;
  String? refno;
  String? meeting;
  String? committe;
  String? rmks;
  String? fkmeeting;
  String? mdate;
  String? mvenue;
  String? fkcmt;

  UpComingMeetingModel(
      {this.tid,
      this.tdate,
      this.refno,
      this.meeting,
      this.committe,
      this.rmks,
      this.fkmeeting,
      this.mdate,
      this.mvenue,
      this.fkcmt});

  UpComingMeetingModel.fromJson(Map<String, dynamic> json) {
    tid = json['tid'];
    tdate = json['tdate'];
    refno = json['refno'];
    meeting = json['meeting'];
    committe = json['committe'];
    rmks = json['rmks'];
    fkmeeting = json['fkmeeting'];
    mdate = json['mdate'];
    mvenue = json['mvenue'];
    fkcmt = json['fkcmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tid'] = this.tid;
    data['tdate'] = this.tdate;
    data['refno'] = this.refno;
    data['meeting'] = this.meeting;
    data['committe'] = this.committe;
    data['rmks'] = this.rmks;
    data['fkmeeting'] = this.fkmeeting;
    data['mdate'] = this.mdate;
    data['mvenue'] = this.mvenue;
    data['fkcmt'] = this.fkcmt;
    return data;
  }
}
