import 'package:app/model/pop/navigator_pop_model.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_colors.dart';
import 'package:app/utils/my_current_location.dart';
import 'package:app/utils/my_focus_remover.dart';
import 'package:app/utils/my_navigations.dart';
import 'package:app/utils/my_textstyles.dart';
import 'package:app/widgets/map/my_map.dart';
import 'package:app/widgets/map/my_map_controller.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

Widget mapTextFormField({
  required context,
  ValueChanged<NavigatorPopModel>? onValueChanged,
  required form,
  required TextEditingController mapController,
}) {
  StateHandlerBloc errorColorBloc = StateHandlerBloc();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Location',
        style: kStyle14B,
      ),
      sizedBox16(),
      StreamBuilder<dynamic>(
          initialData: false,
          stream: errorColorBloc.stateStream,
          builder: (c, errorColorSnapshot) {
            return Form(
              key: form,
              child: TextFormField(
                readOnly: true,
                controller: mapController,
                cursorColor: kPrimary,
                style: kStyle12,
                onTap: () async {
                  await getAddressData(context, form, errorColorBloc,
                      onValueChanged!, mapController);
                  form.currentState?.validate();
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.location_on,
                    size: 18.0,
                    color: errorColorSnapshot.data == false ? kBlack : kRed,
                  ),
                  errorMaxLines: 2,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 16.0),
                  filled: true,
                  fillColor: kWhite.withOpacity(0.6),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                    borderSide: BorderSide(color: kTransparent, width: 0.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                    borderSide: BorderSide(color: kPrimary, width: 1.5),
                  ),
                  errorStyle: kStyle12.copyWith(color: kRed),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                    borderSide: BorderSide(color: kBlack, width: 1.5),
                  ),
                  hintText: mapController.text.isEmpty
                      ? 'Open Map'
                      : mapController.text,
                  hintStyle: kStyle12.copyWith(
                    color: errorColorSnapshot.data == false ? kBlack : kRed,
                  ),
                ),
                validator: (v) {
                  if (mapController.text.isEmpty) {
                    errorColorBloc.storeData(data: true);
                    return 'Select Address';
                  } else {
                    errorColorBloc.storeData(data: false);
                    return null;
                  }
                },
              ),
            );
          }),
      sizedBox16(),
    ],
  );
}

getAddressData(
    context,
    form,
    StateHandlerBloc errorColorBloc,
    ValueChanged<NavigatorPopModel> onValueChanged,
    TextEditingController mapController) async {
  NavigatorPopModel? currentLocationPop, newPop;
  currentLocationPop = await getCurrentLocation(context: context);
  if (currentLocationPop != null) {
    Navigator.pop(context);
    String addressName = await MapController()
        .getPlaceNameFromLatLng(context, currentLocationPop);
    newPop = await go(
        context: context,
        screen: MyMap(
          latitude: currentLocationPop.latitude!,
          longitude: currentLocationPop.longitude!,
          addressName: addressName,
        ));
    errorColorBloc.storeData(data: false);
    mapController.text = newPop!.name!;
    onValueChanged(
      NavigatorPopModel(
        latitude: newPop.latitude,
        longitude: newPop.longitude,
        name: newPop.name,
      ),
    );
    myFocusRemover(context);
  }
}
