import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:xpense_flutter_web/utils/colors.dart';
import 'package:xpense_flutter_web/utils/constants.dart';
import 'package:xpense_flutter_web/utils/styles.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileNavBar(),
      desktop: DeskTopNavBar(),
    );
  }
}

Widget MobileNavBar() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    height: 70,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Icon(Icons.menu), navLogo()],
    ),
  );
}

Widget DeskTopNavBar() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    height: 70,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        navLogo(),
        Row(
          children: [
            navButton('Why'),
            navButton('are'),
            navButton('you'),
            navButton('opening'),
            navButton('through'),
            navButton('laptop')
          ],
        ),
        Container(
          height: 45,
          child: ElevatedButton(
              style: borderedButtonStyle,
              onPressed: () {},
              child: Text(
                'Visit Us',
                style: TextStyle(color: AppColors.primary),
              )),
        )
      ],
    ),
  );
}

Widget navButton(String text) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
          onPressed: () {},
          child:
              Text(text, style: TextStyle(color: Colors.black, fontSize: 18))));
}

Widget navLogo() {
  return Container(
    width: 170,
    decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage(gdscColor), fit: BoxFit.contain)),
  );
}
