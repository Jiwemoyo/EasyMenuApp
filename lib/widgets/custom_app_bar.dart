// lib/widgets/custom_app_bar.dart
import 'package:easy_menu_app/screens/home_screen.dart';
import 'package:easy_menu_app/screens/login_screen.dart';
import 'package:easy_menu_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/custom_route_transition.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String currentPage;

  CustomAppBar({Key? key, required this.currentPage}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(120.0);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String _selectedButton;
  late int _selectedIndex;
  final List<String> _buttons = ['Recetas', 'Login', 'Registro'];

  @override
  void initState() {
    super.initState();
    _selectedButton = widget.currentPage;
    _selectedIndex = _buttons.indexOf(_selectedButton);
  }

// lib/widgets/custom_app_bar.dart

// ...

  void _navigateToScreen(BuildContext context, int index) {
    if (_buttons[index] != _selectedButton) {
      Widget nextPage;
      String routeName;

      switch (index) {
        case 0:
          nextPage = HomeScreen();
          routeName = '/';
          break;
        case 1:
          nextPage = LoginScreen();
          routeName = '/login';
          break;
        case 2:
          nextPage = RegisterScreen();
          routeName = '/register';
          break;
        default:
          return;
      }

      Navigator.pushReplacement(
        context,
        CustomRouteTransition(page: nextPage, routeName: routeName),
      );

      setState(() {
        _selectedButton = _buttons[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [GreenColor, WhiteColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu_book, color: WhiteColor),
                SizedBox(width: 8),
                Text(
                  'Easy Menu',
                  style: pacificoTitleStyle.copyWith(color: WhiteColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final buttonWidth = constraints.maxWidth / 3;
                return Stack(
                  children: [
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      left: _selectedIndex * buttonWidth,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: buttonWidth,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [GreenColor, GreenColor.withOpacity(0.7)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(_buttons.length, (index) {
                        return SizedBox(
                          width: buttonWidth,
                          child: TextButton(
                            onPressed: () => _navigateToScreen(context, index),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: Text(
                              _buttons[index],
                              style: robotoSubtitleStyle.copyWith(
                                color: _selectedIndex == index
                                    ? WhiteColor
                                    : GreenColor,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
