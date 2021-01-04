import 'package:flutter_application/constant/app_parameters.dart';
import 'package:flutter_application/model/brand_detail_entity.dart';
import 'package:flutter_application/service/brand_detail_service.dart';
import 'package:flutter_application/utils/toast_util.dart';
import 'package:flutter_application/view_model/base_view_model.dart';
import 'package:flutter_application/view_model/page_state.dart';

class BrandDetailViewModel extends BaseViewModel {
  BrandDetailService _brandDetailService = BrandDetailService();
  BrandDetailEntity _brandDetialEntity;

  BrandDetailEntity get brandDetialEntity => _brandDetialEntity;

  queryBrandDetail(int id) {
    var parmeters = {AppParameters.ID: id};
    _brandDetailService.queryBrandDetail(parmeters).then((response) {
      if (response.isSuccess) {
        _brandDetialEntity = response.data;
        pageState = PageState.hasData;
        notifyListeners();
      } else {
        ToastUtil.showToast(response.message);
      }
    });
  }
}
