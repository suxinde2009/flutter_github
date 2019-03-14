import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../common/widget_common.dart';
import '../../provide/home_provide.dart';
import 'package:provide/provide.dart';
import '../../generated/i18n.dart';

/*
 * @Date: 2019-03-13 16:12 
 * @Description 不常用的widget
 */

Widget bottomNavigationBar(BuildContext context) {
  return Provide<HomeProvide>(builder: (context, child, homeProvide) {
    return BottomNavigationBar(
      items: bottomNavigationBarItemData(context).map((data) {
        return BottomNavigationBarItem(icon: data[0], title: Text(data[1]));
      }).toList(),
      currentIndex: homeProvide.bottomCurrentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (position) {
        homeProvide.currentIndex(position);
      },
    );
  });
}

Widget loginContainer(BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        TextField(controller: TextEditingController(),),
        TextField(controller: TextEditingController(),),
        RaisedButton(
          onPressed: () {},
          child: Text(S.of(context).login),
        ),
      ],
    ),
  );
}
