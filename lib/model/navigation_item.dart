import 'package:flutter/material.dart';
import 'package:workout_app/utils/custom_icons.dart';

class NavigationItem{

  IconData icon;
  String routeId;

  NavigationItem(this.icon, this.routeId);
}

List<NavigationItem> navItems = [
  NavigationItem(CustomIcons.list, 'list_id'),
  NavigationItem(CustomIcons.user_2, 'profile_id'),
];