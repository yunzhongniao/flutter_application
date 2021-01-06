import 'package:flutter/material.dart';
import 'package:flutter_application/constant/app_colors.dart';
import 'package:flutter_application/constant/app_strings.dart';
import 'package:flutter_application/event/tab_select_event.dart';
import 'package:flutter_application/ui/page/home/tab_cart_page.dart';
import 'package:flutter_application/ui/page/home/tab_category_page.dart';
import 'package:flutter_application/xiangrui/page/mine/tab_mine_page.dart';
import 'package:flutter_application/ui/page/home/tabhome/tab_home_page.dart';
import 'package:flutter_application/ui/page/plan/tab_plan_page.dart';
import 'package:flutter_application/utils/shared_preferences_util.dart';
import 'package:flutter_application/utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _list = List();

  @override
  void initState() {
    super.initState();
    SharedPreferencesUtil.getInstance().setBool(AppStrings.IS_FIRST, false);
    tabSelectBus.on<TabSelectEvent>().listen((event) {
      setState(() {
        TabSelectEvent tabSelectEvent = event;
        _selectedIndex = tabSelectEvent.selectIndex;
      });
    });
    _list
      ..add(TabHomePage())
      ..add(TabCategoryPage())
      ..add(TabCartPage())
      ..add(TabPlanPage())
      ..add(TabMinePage());
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      SharedPreferencesUtil.getInstance()
          .getString(AppStrings.TOKEN)
          .then((value) {
        if (value == null) {
          NavigatorUtil.goLogin(context);
          return;
        }
        _changeIndex(index);
      });
    } else {
      //防止点击当前BottomNavigationBarItem rebuild
      _changeIndex(index);
    }
  }

  _changeIndex(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.HOME,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: AppStrings.FABRIC,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_preferences_rounded),
            label: AppStrings.FITTING_ROOM,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.next_plan_outlined),
            label: AppStrings.PLAN,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppStrings.MINE,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.COLOR_FF5722,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
