import 'package:flutter_application/constant/app_parameters.dart';
import 'package:flutter_application/model/goods_entity.dart';
import 'package:flutter_application/model/project_selection_detail_entity.dart';
import 'package:flutter_application/service/project_selection_service.dart';
import 'package:flutter_application/utils/toast_util.dart';
import 'package:flutter_application/view_model/base_view_model.dart';
import 'package:flutter_application/view_model/page_state.dart';

class ProjectSelectionViewModel extends BaseViewModel {
  ProjectSelectionService _projectSelectionService = ProjectSelectionService();
  ProjectSelectionDetailTopic _projectSelectionDetailTopic;
  List<GoodsEntity> _goods = List();
  List<ProjectSelectionDetailTopic> _relatedProjectSelectionDetailTopics =
      List();

  ProjectSelectionDetailTopic get projectSelectionDetailTopic =>
      _projectSelectionDetailTopic;

  List<ProjectSelectionDetailTopic> get relatedProjectSelectionDetailTopics =>
      _relatedProjectSelectionDetailTopics;

  List<GoodsEntity> get goods => _goods;

  queryDetail(int id) {
    var parameters = {AppParameters.ID: id};
    _projectSelectionService
        .projectSelectionDetail(parameters)
        .then((response) {
      if (response.isSuccess) {
        _projectSelectionDetailTopic = response.data.topic;
        _goods = response.data.goods;
        pageState = PageState.hasData;
        queryRelatedGoods(parameters);
      } else {
        ToastUtil.showToast(response.message);
      }
    });
  }

  queryRelatedGoods(var parameters) {
    _projectSelectionService
        .projectSelectionRecommend(parameters)
        .then((response) {
      if (response.isSuccess) {
        _relatedProjectSelectionDetailTopics = response.data.xList;
        notifyListeners();
      } else {
        ToastUtil.showToast(response.message);
      }
    });
  }
}
