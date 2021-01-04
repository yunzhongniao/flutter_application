import 'package:flutter_application/constant/app_strings.dart';
import 'package:flutter_application/constant/app_urls.dart';
import 'package:flutter_application/model/plan_entity.dart';
import 'package:flutter_application/model/json_result.dart';
import 'package:flutter_application/utils/http_util.dart';

class PlanService {
  Future<JsonResult<PlanEntity>> queryHomeData() async {
    JsonResult<PlanEntity> jsonResult = JsonResult<PlanEntity>();
    try {
      var response = await HttpUtil.instance.get(AppUrls.PLAN_URL);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        PlanEntity planEntity = PlanEntity.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = planEntity;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message = response[AppStrings.ERR_MSG] != null
            ? response[AppStrings.ERR_MSG]
            : AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }
}
