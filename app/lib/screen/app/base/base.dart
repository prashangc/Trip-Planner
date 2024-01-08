import 'package:app/screen/app/base/base_controller.dart';
import 'package:app/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:sweet_nav_bar/sweet_nav_bar.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        initialData: 0,
        stream: appBaseController.baseBloc.stateStream,
        builder: (c, s) {
          return Scaffold(
            body: appBaseController.screens[s.data],
            bottomNavigationBar: SweetNavBar(
              currentIndex: 0,
              paddingBackgroundColor: backgroundColor,
              items: [
                SweetNavBarItem(
                  sweetBackground: kPrimary,
                  iconColors: [kWhite, kGrey],
                  sweetIcon: const Icon(Icons.home_outlined),
                  sweetLabel: 'Home',
                ),
                SweetNavBarItem(
                    iconColors: [kWhite, kGrey],
                    sweetIcon: const Icon(Icons.history),
                    sweetLabel: 'Booking'),
                SweetNavBarItem(
                    iconColors: [kWhite, kGrey],
                    sweetIcon: const Icon(Icons.favorite_border),
                    sweetLabel: 'Fav'),
                SweetNavBarItem(
                    iconColors: [kWhite, kGrey],
                    sweetIcon: const Icon(Icons.perm_identity),
                    sweetLabel: 'School'),
              ],
              onTap: (index) {
                appBaseController.baseBloc.storeData(data: index);
              },
            ),
          );
        });
  }
}
