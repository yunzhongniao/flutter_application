import 'package:flutter/material.dart';
import 'package:flutter_application/constant/app_colors.dart';
import 'package:flutter_application/constant/app_strings.dart';
import 'package:flutter_application/view_model/tab_plan_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TabPlanPage extends StatefulWidget {
  @override
  _TabPlanPageState createState() => _TabPlanPageState();
}

class _TabPlanPageState extends State<TabPlanPage>
    with SingleTickerProviderStateMixin {
  TabPlanViewModel _model = TabPlanViewModel();
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
        body: ChangeNotifierProvider<TabPlanViewModel>(
          //ChangeNotifierProvider ,create返回的model 与 child关联
          create: (context) => _model,
          child: Consumer<TabPlanViewModel>(builder: (context, model, child) {
            _refreshController.refreshCompleted();
            // 全局配置RefreshConfiguration,配置子树下的所有SmartRefresher表现,一般存放于MaterialApp的根部,用法和ScrollConfiguration是类似的
            return RefreshConfiguration(
              child: SmartRefresher(
                  header: WaterDropMaterialHeader(
                    backgroundColor: AppColors.COLOR_FF5722,
                  ),
                  controller: _refreshController,
                  onRefresh: () => _onRefresh(),
                  child: _dataView(model)),
            );
          }),
        )
        // bottom
        );
  }

  _onRefresh() {
    _model.loadTabHomeData(); //获取首页数据
  }

  //数据显示
  Widget _dataView(TabPlanViewModel tabPlanViewModel) {
    return SingleChildScrollView(
        //滚动方向，默认是垂直方向
        scrollDirection: Axis.vertical,
        // 此属性接受一个ScrollPhysics类型的对象，它决定可以滚动如何响应用户操作，
        // 比如用户滑动完抬起手指后，继续执行动画，或者滑动到边界时，如何显示。
        //Flutter SDK包含两个ScrollPhysics的子类。1.ClampingScrollPhysics：Android下微光效果，
        // 2.BouncingScrollPhysics：iOS下弹性效果
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Image.asset(
              'images/no_data.png',
              width: 600,
              height: 200,
              fit: BoxFit.cover,
            ),
            _textView(),
            _buttonView(),
            _contentView()
          ],
        ));
  }

  Widget _buttonView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(
              Icons.call_end_rounded,
              size: 40,
              color: Colors.blue[500],
            ),
            Container(
                child: Text(
              "Call",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.blue[500]),
            ))
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.airline_seat_flat,
              size: 40,
              color: Colors.blue[500],
            ),
            Container(
              child: Text(
                "Plan",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue[500]),
              ),
            )
          ],
        ),
        Column(
          children: [
            Icon(Icons.share_rounded, size: 40, color: Colors.blue[500]),
            Container(
              child: Text(
                "share",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue[500]),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _textView() {
    return Container(
        padding: EdgeInsets.all(12),
        child: Row(children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Oeschinen Lake Campground",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              Text("Kandersteg, Switzerland",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey))
            ],
          )),
          Icon(Icons.star, size: 20, color: Colors.red[500]),
          Text("41",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ]));
  }

  Widget _contentView() {
    return Container(
        padding: EdgeInsets.all(12),
        child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.'
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
          style: TextStyle(
            fontSize: 20,
          ),
          softWrap: true,
        ));
  }
}
