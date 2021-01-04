import 'package:flutter_application/model/plan_entity.dart';
import 'package:flutter_application/view_model/base_view_model.dart';

class TabPlanViewModel extends BaseViewModel {
  PlanEntity planEntity;

  void loadTabHomeData() {
    List<PlanDetail> planList = List();
    planEntity = PlanEntity(planList);
    notifyListeners();
  }
}
