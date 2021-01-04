class PlanEntity {
  List<PlanDetail> planList;
  PlanEntity(this.planList);

  PlanEntity.fromJson(Map<String, dynamic> json) {
    if (json['planList'] != null) {
      planList = new List<PlanDetail>();
      (json['planList'] as List).forEach((v) {
        planList.add(new PlanDetail.fromJson(v));
      });
    }
  }
}

class PlanDetail {
  String planName;
  String planCode;

  PlanDetail.fromJson(Map<String, dynamic> json) {
    planName = json['planName'];
    planCode = json['planCode'];
  }
}
