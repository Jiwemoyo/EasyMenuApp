// lib/utils/custom_route_transition.dart
import 'package:flutter/material.dart';

class CustomRouteTransition extends PageRouteBuilder {
  final Widget page;
  final String routeName;

  CustomRouteTransition({required this.page, required this.routeName})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          settings: RouteSettings(name: routeName),
        );
}