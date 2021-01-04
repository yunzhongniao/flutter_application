import 'package:flutter_application/constant/app_parameters.dart';
import 'package:flutter_application/model/coupon_entity.dart';
import 'package:flutter_application/service/mine_service.dart';
import 'package:flutter_application/utils/toast_util.dart';
import 'package:flutter_application/view_model/base_view_model.dart';
import 'package:flutter_application/view_model/page_state.dart';

class CouponViewModel extends BaseViewModel {
  MineService _mineService = MineService();
  CouponEntity _couponBean;
  bool _canLoadMore = false;
  List<CouponList> _coupons = List();

  CouponEntity get couponBean => _couponBean;

  List<CouponList> get coupons => _coupons;

  bool get canLoadMore => _canLoadMore;

  queryCoupon(int pageIndex, int limit) {
    var parameters = {
      AppParameters.PAGE: pageIndex,
      AppParameters.LIMIT: limit
    };
    _mineService.queryCoupon(parameters).then((response) {
      if (response.isSuccess) {
        _couponBean = response.data;
        if (pageIndex == 1) {
          _coupons.clear();
          _coupons = response.data.xList;
        } else {
          _coupons.addAll(response.data.xList);
        }
        _canLoadMore = coupons.length < _couponBean.total;
        pageState = _coupons.length == 0 ? PageState.empty : PageState.hasData;
        notifyListeners();
      } else {
        pageState = PageState.error;
        ToastUtil.showToast(response.message);
        notifyListeners();
      }
    });
  }
}
