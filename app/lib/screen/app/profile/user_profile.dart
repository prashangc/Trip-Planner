import 'package:app/bloc/token/token_bloc.dart';
import 'package:app/bloc/token/token_state.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_cached_network_image.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProfilePage extends StatelessWidget {
  const AppProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimary,
        automaticallyImplyLeading: false,
        toolbarHeight: 0.0,
      ),
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: maxWidth(context),
        height: maxHeight(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myAppBar(),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: kPrimary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            )),
                        width: maxWidth(context),
                        height: 50.0,
                      ),
                      Expanded(
                        child: Container(
                          width: maxWidth(context),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 25.0,
                    bottom: 25.0,
                    left: 20.0,
                    right: 20.0,
                    child: Column(
                      children: [
                        profile(context),
                        sizedBox16(),
                        menu(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      color: kPrimary,
      child: Column(
        children: [
          sizedBox16(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '  Profile',
                style: kStyle18B.copyWith(
                  color: kWhite,
                  fontSize: 24.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: kWhite.withOpacity(0.4),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(24.0))),
                child: Row(
                  children: [
                    sizedBox2(),
                    Text(
                      'Settings',
                      style: kStyle12.copyWith(color: kWhite),
                    ),
                    sizedBox12(),
                    CircleAvatar(
                      radius: 14.0,
                      backgroundColor: kWhite.withOpacity(0.6),
                      child: const Icon(
                        Icons.settings,
                        size: 15.0,
                      ),
                    ),
                    sizedBox2(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget profile(context) {
    ProfileModel profileModel =
        BlocProvider.of<TokenBloc>(context).state.profile!;
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
        color: kWhite,
        boxShadow: [BoxShadow(color: kGrey, offset: Offset(3, 3))],
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myCachedNetworkImageCircle(
            myWidth: 60.0,
            myHeight: 60.0,
            myImage:
                'https://static1.cbrimages.com/wordpress/wp-content/uploads/2019/11/Kaneki-Ken-Featured-Image.jpg',
          ),
          sizedBox16(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileModel.name!,
                  style: kStyle14B,
                ),
                Text(
                  profileModel.email!,
                  style: kStyle12,
                ),
                Text(
                  profileModel.phone!,
                  style: kStyle12,
                ),
              ],
            ),
          ),
          sizedBox16(),
          Row(
            children: [
              Text(
                'Edit',
                style: kStyle14B.copyWith(color: kOrange),
              ),
              sizedBox8(),
              const Icon(
                Icons.edit,
                color: kOrange,
                size: 14.0,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget menu(context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(
          color: kWhite,
          boxShadow: [BoxShadow(color: kGrey, offset: Offset(3, 3))],
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                sizedBox8(),
                myCard(
                  context: context,
                  title: 'Verify Phone',
                  subtitle: 'Verify your phone number',
                  icon: Icons.call_outlined,
                  myTap: () {},
                ),
                myCard(
                  context: context,
                  title: 'Verify Email',
                  icon: Icons.email_outlined,
                  subtitle: 'Verify your email address',
                  myTap: () {},
                ),
                myCard(
                  context: context,
                  title: 'Password and Security',
                  subtitle: 'Change your security preferences',
                  icon: Icons.security_outlined,
                  myTap: () {},
                ),
                myCard(
                  context: context,
                  myTap: () {},
                  title: 'Biometrics',
                  subtitle: 'Enable biometric login',
                  icon: Icons.fingerprint_rounded,
                  action: Switch(
                    value: true,
                    onChanged: (v) {},
                    activeColor: kPrimary,
                    inactiveThumbColor: kWhite,
                    inactiveTrackColor: backgroundColor,
                    activeTrackColor: backgroundColor,
                  ),
                ),
                myCard(
                  context: context,
                  title: 'Language',
                  myTap: () {},
                  subtitle: 'Change application language',
                  icon: Icons.language_sharp,
                  action: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                      border: Border.all(color: kGrey),
                    ),
                    child: Row(
                      children: [
                        sizedBox8(),
                        const Text(
                          'Eng',
                        ),
                        sizedBox8(),
                        const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ),
                myCard(
                  myTap: () {},
                  context: context,
                  title: 'Notifications',
                  subtitle: 'Get notified with your preferences',
                  icon: Icons.notifications_outlined,
                  showDivider: false,
                  action: Switch(
                    value: true,
                    onChanged: (v) {},
                    activeColor: kPrimary,
                    inactiveThumbColor: kWhite,
                    inactiveTrackColor: backgroundColor,
                    activeTrackColor: backgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myCard({
    required context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Function myTap,
    bool? showDivider,
    Widget? action,
  }) {
    return Container(
      width: maxWidth(context),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () {
          myTap();
        },
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.0,
              color: kPrimary,
            ),
            sizedBox24(),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBox12(),
                          Text(
                            title,
                            style: kStyle14B.copyWith(),
                          ),
                          sizedBox8(),
                          Text(
                            subtitle,
                            style: kStyle12.copyWith(),
                          ),
                          sizedBox12(),
                        ],
                      ),
                      action ??
                          const Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 24.0,
                            ),
                          )
                    ],
                  ),
                  sizedBox8(),
                  Container(
                    color: kGrey,
                    height: showDivider != null ? 0.0 : 1.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
