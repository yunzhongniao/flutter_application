import 'package:flutter/cupertino.dart';
import 'package:flutter_application/ui/page/guide/guide_page.dart';
import 'package:flutter_application/ui/page/home/home_page.dart';
import 'package:flutter_application/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<UserViewModel>(context).isFirst
        ? GuidePage()
        : HomePage();
  }
}
