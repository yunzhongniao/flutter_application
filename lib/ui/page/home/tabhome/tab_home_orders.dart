import 'package:flutter/material.dart';
import 'package:flutter_application/constant/app_colors.dart';
import 'package:flutter_application/constant/app_dimens.dart';
import 'package:flutter_application/constant/text_style.dart';
import 'package:flutter_application/model/home_entity.dart';
import 'package:flutter_application/ui/widgets/cached_image.dart';
import 'package:flutter_application/utils/navigator_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabHomeOrders extends StatelessWidget {
  List<HomeModelOrder> _homeModelOrder;

  TabHomeOrders();

  _goCategoryView(BuildContext context, HomeModelOrder order) {
    print("${order.id}");
    NavigatorUtil.goHomeCategoryGoodsPage(context, order.name, order.id);
  }

  @override
  Widget build(BuildContext context) {
    _homeModelOrder = List();
    var first = HomeModelOrder(name: "name", id: 1, iconUrl: "http://asdf");
    _homeModelOrder.add(first);
    var second = HomeModelOrder(name: "name", id: 2, iconUrl: "http://asdf");
    _homeModelOrder.add(second);
    return Container(
        // EdgeInsets 四个基本方向上的一组不变的偏移量。
        padding: EdgeInsets.only(bottom: 8),
        color: AppColors.COLOR_FFFFFF,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          //禁止滚动
          shrinkWrap: true,
          itemCount: _homeModelOrder.length,
          itemBuilder: (BuildContext context, int index) {
            //  return _getGridViewItem(categoryList[index]);
            return _getGridViewItem(context, _homeModelOrder[index]);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.9,
              //单个子Widget的水平最大宽度
              crossAxisCount: 2),
        ));
  }

  Widget _getGridViewItem(BuildContext context, HomeModelOrder order) {
    return Center(
      // InkWell组件在用户点击时出现“水波纹”效果
      child: InkWell(
        onTap: () => _goCategoryView(context, order),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.local_mall,
              color: Colors.red[500],
              size: 64,
            ),
            Text(
              order.name,
              style: FMTextStyle.color_333333_size_42,
            )
          ],
        ),
      ),
    );
  }
}
