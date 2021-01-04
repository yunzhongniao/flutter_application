import 'package:flutter/material.dart';
import 'package:flutter_application/constant/app_colors.dart';
import 'package:flutter_application/constant/app_strings.dart';
import 'package:flutter_application/ui/page/home/tabhome/tab_home_brand.dart';
import 'package:flutter_application/ui/page/home/tabhome/tab_home_coupon.dart';
import 'package:flutter_application/ui/page/home/tabhome/tab_home_goods.dart';
import 'package:flutter_application/ui/page/home/tabhome/tab_home_goods_category.dart';
import 'package:flutter_application/ui/page/home/tabhome/tab_home_banner.dart';
import 'package:flutter_application/ui/page/home/tabhome/tab_home_group_by.dart';
import 'package:flutter_application/ui/page/home/tabhome/tab_home_orders.dart';
import 'package:flutter_application/ui/page/home/tabhome/tab_home_special.dart';
import 'package:flutter_application/ui/widgets/view_model_state_widget.dart';
import 'package:flutter_application/utils/navigator_util.dart';
import 'package:flutter_application/view_model/page_state.dart';
import 'package:flutter_application/view_model/tab_home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TabHomePage extends StatefulWidget {
  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage>
    with SingleTickerProviderStateMixin {
  TabHomeViewModel _model = TabHomeViewModel();
  VoidCallback callback;
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _onRefresh(); //获取首页数据
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold定义了一个 UI 框架，这个框架包含 头部导航栏，body，右下角浮动按钮，底部导航栏等。
    return Scaffold(
        //来定义顶部导航栏
        appBar: AppBar(
          title: Text(AppStrings.APP_NAME),
          centerTitle: true,
        ),
        // leading，这个参数用来定义导航栏左上角的组件，通常是一个图标按钮
        // title ，注意这个 title 是 Widget 类型
        // actions ，这个参数的类型是 Widget 数组，用来将一组 Widget
        // body Scaffold的主体部分
        body: ChangeNotifierProvider<TabHomeViewModel>(
          //ChangeNotifierProvider ,create返回的model 与 child关联
          create: (context) => _model,
          child: Consumer<TabHomeViewModel>(builder: (context, model, child) {
            _refreshController.refreshCompleted();
            // 全局配置RefreshConfiguration,配置子树下的所有SmartRefresher表现,一般存放于MaterialApp的根部,用法和ScrollConfiguration是类似的
            return RefreshConfiguration(
              child: SmartRefresher(
                  header: WaterDropMaterialHeader(
                    backgroundColor: AppColors.COLOR_FF5722,
                  ),
                  controller: _refreshController,
                  onRefresh: () => _onRefresh(),
                  child: initView(model)),
            );
          }),
        )
        // bottom
        );
  }

  _onRefresh() {
    _model.loadTabHomeData(); //获取首页数据
  }

  //appbar
  Widget appBarWidget() {
    return SliverAppBar(
        floating: true,
        pinned: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => NavigatorUtil.goSearchGoods(context),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(AppStrings.APP_NAME),
        ));
  }

  Widget initView(TabHomeViewModel tabHomeViewModel) {
    if (tabHomeViewModel.pageState == PageState.hasData) {
      return _dataView(tabHomeViewModel);
    }
    return ViewModelStateWidget.stateWidgetWithCallBack(
        tabHomeViewModel, _onRefresh);
  }

  //数据显示
  Widget _dataView(TabHomeViewModel tabHomeViewModel) {
    return SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            TabHomeBanner(_model.homeModelEntity.banner),
            TabHomeOrders(),
            TabHomeGoodsCategory(_model.homeModelEntity.channel),
            //TabHomeCoupon(_model.homeModelEntity.couponList, _model),
            //TabHomeGroupByWidget(_model.homeModelEntity.grouponList),
            TabHomeGoods(
                AppStrings.NEW_PRODUCTS, _model.homeModelEntity.newGoodsList),
            TabHomeGoods(
                AppStrings.HOT_SALE, _model.homeModelEntity.hotGoodsList),
            // TabHomeGoods(AppStrings.AT_HOME,
            //     _model.homeModelEntity.floorGoodsList[0].goodsList),
            // TabHomeGoods(AppStrings.KITCHEN,
            //     _model.homeModelEntity.floorGoodsList[1].goodsList),
            // TabHomeGoods(AppStrings.DIET,
            //     _model.homeModelEntity.floorGoodsList[2].goodsList),
            // TabHomeGoods(AppStrings.PARTS,
            //     _model.homeModelEntity.floorGoodsList[3].goodsList),
            // TabHomeSpecial(
            //     AppStrings.SPECIAL, _model.homeModelEntity.topicList),
            // TabHomeBrand(
            //     AppStrings.MANUFACTURING, _model.homeModelEntity.brandList)
          ],
        ));
  }
}
