import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(120.0);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _selectedButton = 'Recetas';
  int _selectedIndex = 0;
  final List<String> _buttons = ['Recetas', 'Login', 'Registro'];

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
                            onPressed: () {
                              setState(() {
                                _selectedButton = _buttons[index];
                                _selectedIndex = index;
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: Text(
                              _buttons[index],
                              style: robotoSubtitleStyle.copyWith(
                                color: _selectedIndex == index ? WhiteColor : GreenColor,
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