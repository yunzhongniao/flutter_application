import 'package:flutter/material.dart';
import 'package:flutter_application/constant/app_colors.dart';
import 'package:flutter_application/constant/app_dimens.dart';
import 'package:flutter_application/constant/app_images.dart';
import 'package:flutter_application/constant/app_strings.dart';
import 'package:flutter_application/constant/app_xiangrui_strings.dart';
import 'package:flutter_application/constant/text_style.dart';
import 'package:flutter_application/event/tab_select_event.dart';
import 'package:flutter_application/ui/widgets/divider_line.dart';
import 'package:flutter_application/ui/widgets/icon_text_arrow_widget.dart';
import 'package:flutter_application/utils/navigator_util.dart';
import 'package:flutter_application/utils/shared_preferences_util.dart';
import 'package:flutter_application/view_model/user_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TabMinePage extends StatefulWidget {
  @override
  _TabMinePageState createState() => _TabMinePageState();
}

class _TabMinePageState extends State<TabMinePage> {
  @override
  Widget build(BuildContext context) {
    return _contentWidget();
  }

  Widget _contentWidget() {
    return Consumer<UserViewModel>(
        builder: (BuildContext context, UserViewModel model, Widget child) {
      return Column(children: [
        Container(
            height: ScreenUtil().setHeight(AppDimens.DIMENS_300) +
                MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.COLOR_FFB24E, AppColors.COLOR_FF5722]),
                color: AppColors.COLOR_FF5722),
            child: Container(
                padding:
                    EdgeInsets.all(ScreenUtil().setHeight(AppDimens.DIMENS_30)),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(AppDimens.DIMENS_100)),
                child: Column(children: [
                  _headWidget(model),
                ]))),
        Container(
            child: Column(children: [
          _otherWidget(),
          _companyInfo(),
          Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(AppDimens.DIMENS_80))),
          _logoutWidget(),
        ]))
      ]);
    });
  }

  Widget _headWidget(UserViewModel model) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(AppDimens.DIMENS_180),
            height: ScreenUtil().setWidth(AppDimens.DIMENS_180),
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
            child: CircleAvatar(
              radius: ScreenUtil().setWidth(AppDimens.DIMENS_90),
              backgroundImage: NetworkImage(
                Provider.of<UserViewModel>(context).pictureUrl ??
                    AppStrings.DEFAULT_URL,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.userName ?? "未登录",
                  style: FMTextStyle.color_ffffff_size_42),
              Text(
                AppStrings.SUPER_VIP,
                style: FMTextStyle.color_ffffff_size_36,
              ),
            ],
          ),
        ]);
  }

  Widget _otherWidget() {
    return Container(
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppDimens.DIMENS_10))),
            child: Container(
              child: Column(
                children: [
                  IconTextArrowView(
                      AppImages.LOCATION,
                      AppXiangruiStrings.LOCATION,
                      () => NavigatorUtil.goAddress(context, 0)),
                  DividerLineView(),
                  IconTextArrowView(
                      AppImages.LOCATION,
                      AppXiangruiStrings.MY_ORDERS,
                      () => NavigatorUtil.goAddress(context, 0)),
                  DividerLineView(),
                  IconTextArrowView(
                      AppImages.FEEDBACK,
                      AppXiangruiStrings.SCORE,
                      () => NavigatorUtil.goFeedBack(context)),
                  DividerLineView(),
                  IconTextArrowView(
                      AppImages.ABOUT_US,
                      AppXiangruiStrings.ABOUT_US,
                      () => NavigatorUtil.goAboutUs(context)),
                  DividerLineView(),
                  IconTextArrowView(
                      AppImages.ABOUT_US,
                      AppXiangruiStrings.CLEAR_MEMORY,
                      () => NavigatorUtil.goAboutUs(context)),
                  DividerLineView(),
                  IconTextArrowView(
                      AppImages.ABOUT_US,
                      AppXiangruiStrings.FEED_BACK,
                      () => NavigatorUtil.goAboutUs(context)),
                ],
              ),
            )));
  }

  Widget _logoutWidget() {
    return SizedBox(
        width: double.infinity,
        height: ScreenUtil().setHeight(AppDimens.DIMENS_100),
        child: RaisedButton(
          color: AppColors.COLOR_FF5722,
          onPressed: () => _logout(),
          child:
              Text(AppStrings.LOGOUT, style: FMTextStyle.color_ffffff_size_42),
        ));
  }

  _logout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text(AppStrings.TIPS, style: FMTextStyle.color_333333_size_60),
            content: Text(AppStrings.CONFIRM_LOGOUT,
                style: FMTextStyle.color_333333_size_48),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppStrings.CANCEL,
                      style: FMTextStyle.color_999999_size_42)),
              FlatButton(
                  onPressed: () {
                    SharedPreferencesUtil.getInstance().clear().then((value) {
                      print(value);
                      if (value) {
                        Navigator.pop(context);
                        Provider.of<UserViewModel>(context, listen: false)
                            .refreshData();
                        tabSelectBus.fire(TabSelectEvent(0));
                      }
                    });
                  },
                  child: Text(AppStrings.CONFIRM,
                      style: FMTextStyle.color_ff5722_size_42)),
            ],
          );
        });
  }

  Widget _companyInfo() {
    return Container(
        child: Center(
            child: Column(
      children: [
        Text(AppXiangruiStrings.COMPANY_INFO),
        Text(AppXiangruiStrings.COMPANY_PHONE)
      ],
    )));
  }
}
