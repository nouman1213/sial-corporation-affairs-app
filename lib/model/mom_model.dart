class MomModel {
  int? tid;
  int? fktid;
  String? agenda;
  String? fkmeeting;
  String? meeting;
  String? remarks;
  String? mdate;

  MomModel(
      {this.tid,
      this.fktid,
      this.agenda,
      this.fkmeeting,
      this.meeting,
      this.remarks,
      this.mdate});

  MomModel.fromJson(Map<String, dynamic> json) {
    tid = json['tid'];
    fktid = json['fktid'];
    agenda = json['agenda'];
    fkmeeting = json['fkmeeting'];
    meeting = json['meeting'];
    remarks = json['remarks'];
    mdate = json['mdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tid'] = this.tid;
    data['fktid'] = this.fktid;
    data['agenda'] = this.agenda;
    data['fkmeeting'] = this.fkmeeting;
    data['meeting'] = this.meeting;
    data['remarks'] = this.remarks;
    data['mdate'] = this.mdate;
    return data;
  }
}
