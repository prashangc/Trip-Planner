import 'package:app/screen/dashboard/home/cards/checkout_card.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

class HomePageDashboard extends StatelessWidget {
  const HomePageDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth(context),
      child: Column(
        children: [
          Row(
            children: [
              checkoutCard(
                color: myPurple,
                icon: Icons.login_outlined,
                total: 24,
                title: 'Check Ins Today',
              ),
              sizedBox16(),
              checkoutCard(
                color: myYellow,
                icon: Icons.logout_outlined,
                total: 22,
                title: 'Check Outs Today',
              ),
              sizedBox16(),
              checkoutCard(
                color: myRed,
                icon: Icons.perm_identity_outlined,
                total: 1456,
                title: 'Total Visits',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
