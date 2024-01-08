import 'dart:convert';

import 'package:app/bloc/token/token_bloc.dart';
import 'package:app/bloc/token/token_state.dart';
import 'package:app/screen/dashboard/profile/profile_controller.dart';
import 'package:app/screen/dashboard/room/cards/form.dart';
import 'package:app/services/api/api.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/my_button.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:app/widgets/my_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDashboard extends StatelessWidget {
  const ProfileDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileModel profile = BlocProvider.of<TokenBloc>(context).state.profile!;
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            profile.address == null ||
                    profile.latitude == null ||
                    profile.longitude == null ||
                    profile.gallery!.isEmpty
                ? validationCard(
                    context: context,
                    bgColor: const Color.fromARGB(255, 255, 205, 202),
                    borderColor: kRed,
                    msg:
                        'Please fill all of your profile details before using further dasboard.',
                    text: 'Update Profle',
                  )
                : Container(),
            sizedBox12(),
            myFormCard(
              title: 'Personal Information:',
              ui: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: myTextFormField(
                            context: context,
                            prefixIcon: Icons.perm_identity,
                            labelText: profile.name ?? 'Full Name',
                            errorMessage: 'Enter full name',
                            form: GlobalKey(),
                            onValueChanged: (v) {
                              profile.name = v;
                            }),
                      ),
                      sizedBox12(),
                      Expanded(
                        child: myTextFormField(
                            context: context,
                            readOnly: true,
                            prefixIcon: Icons.email_outlined,
                            labelText: profile.email ?? 'Email',
                            errorMessage: 'Enter your email',
                            form: GlobalKey(),
                            onValueChanged: (v) {}),
                      ),
                    ],
                  ),
                  myTextFormField(
                      context: context,
                      prefixIcon: Icons.call_outlined,
                      readOnly: true,
                      labelText: profile.phone ?? 'Phone No.',
                      errorMessage: 'Enter your phone no.',
                      form: GlobalKey(),
                      onValueChanged: (v) {}),
                ],
              ),
            ),
            sizedBox16(),
            myFormCard(
              title: 'Hotel Information:',
              ui: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: myTextFormField(
                            context: context,
                            prefixIcon: Icons.location_on_outlined,
                            labelText: profile.latitude ?? 'Latitude',
                            errorMessage: 'Enter your latitude',
                            form: GlobalKey(),
                            onValueChanged: (v) {
                              profile.latitude = v;
                            }),
                      ),
                      sizedBox12(),
                      Expanded(
                        child: myTextFormField(
                            context: context,
                            prefixIcon: Icons.location_on_outlined,
                            labelText: profile.longitude ?? 'Longitude',
                            errorMessage: 'Enter your longitude',
                            form: GlobalKey(),
                            onValueChanged: (v) {
                              profile.longitude = v;
                            }),
                      ),
                    ],
                  ),
                  myTextFormField(
                      context: context,
                      prefixIcon: Icons.location_city_outlined,
                      labelText: profile.address ?? 'Address Name',
                      errorMessage: 'Enter your address',
                      form: GlobalKey(),
                      onValueChanged: (v) {}),
                ],
              ),
            ),
            sizedBox16(),
            myFormCard(
                title: 'Gallery:',
                ui: DottedBorder(
                  dashPattern: const [8, 10],
                  strokeWidth: 1,
                  color: kBlack,
                  strokeCap: StrokeCap.round,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(5),
                  child: Container(
                    height: maxHeight(context) / 4,
                    width: maxWidth(context),
                    decoration: BoxDecoration(
                      color: kWhite.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sizedBox16(),
                        const Icon(
                          Icons.file_upload,
                          size: 35,
                          color: kBlack,
                        ),
                        sizedBox12(),
                        Text(
                          'Image should not be more than 10 MB',
                          style: kStyle12,
                        ),
                        sizedBox12(),
                        Text(
                          'Browse',
                          style: kStyle12B,
                        ),
                        sizedBox16(),
                      ],
                    ),
                  ),
                )),
            sizedBox16(),
            myButton(
              context: context,
              width: maxWidth(context) / 6,
              height: 50.0,
              text: 'Update',
              bloc: profileDashboardController.updateProfileBtn,
              myTap: () async {
                profile.gallery!.add(
                    "https://hotelassociationnepal.org.np/public/storage/hotels/April2019/XgEjFNnuY3wYGF4V5TBb.jpg");
                profile.gallery!.add(
                    "https://hotelassociationnepal.org.np/public/storage/hotels/April2019/71hXN78cniG2i3loY5FF.jpg");
                profile.gallery!.add(
                    "https://hotelassociationnepal.org.np/public/storage/hotels/April2019/9V95Xge1WjyMIqqEEAe4.jpg");
                profile.gallery!.add(
                    "https://hotelassociationnepal.org.np/public/storage/hotels/April2019/GClpnRl1Lazyny1uTSHl.jpg");
                await API().postData(
                  context: context,
                  model: profile,
                  endpoint: getDotEnvValue('UPDATE_PROFILE'),
                  bloc: profileDashboardController.updateProfileBtn,
                  func: (resp) {
                    var test = json.decode(resp.toString());
                    List<dynamic> profileList = test['profile'];
                    ProfileModel profileModel =
                        ProfileModel.fromJson(profileList[0]);
                    BlocProvider.of<TokenBloc>(context).state.profile =
                        profileModel;
                  },
                );
              },
            ),
            sizedBox12(),
          ],
        ),
      ),
    );
  }

  Widget validationCard({context, text, msg, borderColor, bgColor}) {
    return Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        width: maxWidth(context),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          border: Border.all(color: borderColor, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline_outlined,
                    size: 17.0, color: borderColor),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    msg,
                    style: kStyle12,
                  ),
                ),
              ],
            ),
            sizedBox8(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  text,
                  style: kStyle14B.copyWith(
                    color: borderColor,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
