import 'package:flutter_application/model/home_entity.dart';
import 'package:flutter_application/service/home_service.dart';
import 'package:flutter_application/view_model/base_view_model.dart';
import 'package:flutter_application/view_model/page_state.dart';

class TabHomeViewModel extends BaseViewModel {
  HomeService _homeService = HomeService();
  HomeEntity homeModelEntity;

  void loadTabHomeData() {
    _homeService.queryHomeData().then((response) {
      if (response.isSuccess) {
        homeModelEntity = response.data;
        pageState =
            homeModelEntity == null ? PageState.empty : PageState.hasData;
        notifyListeners();
      }
    }, onError: (errorMessage) {
      pageState = PageState.error;
      notifyListeners();
    });
  }
}
