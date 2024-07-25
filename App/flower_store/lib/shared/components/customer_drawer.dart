import 'package:flower_store/constants/colors.dart';
import 'package:flutter/material.dart';

Drawer customDrawer({
  DrawerHeader? drawerHeader
}) {
  return Drawer(
    backgroundColor: tdBGColor,
    child: ListView(
      children: <Widget>[
        drawerHeader ?? customDrawerHeader(),
      ],
    ),
  );
}

DrawerHeader customDrawerHeader() {
 return const DrawerHeader(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: horizontalDividerColor
        )
      )
    ),
    child: Column(
      children: [],
    )
  );
}