import 'package:flutter_application/constant/app_parameters.dart';
import 'package:flutter_application/constant/app_strings.dart';
import 'package:flutter_application/service/mine_service.dart';
import 'package:flutter_application/utils/toast_util.dart';
import 'package:flutter_application/view_model/base_view_model.dart';

class FeedBackViewModel extends BaseViewModel {
  MineService _mineService = MineService();
  String _feedBackType = AppStrings.PLEASE_SELECT_FEEDBACK_TYPE;

  String get feedBackType => _feedBackType;

  setFeedBackType(String value) {
    _feedBackType = value;
    notifyListeners();
  }

  Future<bool> submitFeedBack(
      String feedBackType, String content, String phoneNumber) async {
    var parameters = {
      AppParameters.CONTENT: content,
      AppParameters.FEED_TYPE: feedBackType,
      AppParameters.HAS_PICTURE: "false",
      AppParameters.MOBILE: phoneNumber,
    };
    bool isSuccess;
    await _mineService.feedback(parameters).then((response) {
      isSuccess = response.isSuccess;
      if (!isSuccess) {
        ToastUtil.showToast(response.message);
      }
    });

    return isSuccess;
  }
}
