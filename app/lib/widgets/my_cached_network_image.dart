import 'package:app/utils/my_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget myCachedNetworkImage({
  required double myWidth,
  required double myHeight,
  required String myImage,
  required BorderRadiusGeometry borderRadius,
}) {
  return CachedNetworkImage(
      width: myWidth,
      height: myHeight,
      imageUrl: myImage,
      imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                alignment: FractionalOffset.topCenter,
              ),
            ),
          ),
      placeholder: (context, url) => const Center(
              child: Padding(
            padding: EdgeInsets.all(5.0),
            child: CircularProgressIndicator(
              color: kPrimary,
              strokeWidth: 1.5,
              backgroundColor: kWhite,
            ),
          )),
      errorWidget: (context, url, error) => Image.asset(
            'assets/app/logo.png',
          ));
}

Widget myCachedNetworkImageCircle({
  required double myWidth,
  required double myHeight,
  required String myImage,
}) {
  return CachedNetworkImage(
    width: myWidth,
    height: myHeight,
    imageUrl: myImage,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kWhite,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
        ),
      ),
    ),
    placeholder: (context, url) => const Center(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(
        color: kPrimary,
        strokeWidth: 1.5,
        backgroundColor: kWhite,
      ),
    )),
    errorWidget: (context, url, error) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: kWhite,
      ),
      child: Image.asset('assets/mobile/logo.png'),
    ),
  );
}
