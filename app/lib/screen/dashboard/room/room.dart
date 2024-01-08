import 'package:app/screen/dashboard/main/model/side_nav_model.dart';
import 'package:app/screen/dashboard/room/cards/add_room.dart';
import 'package:app/screen/dashboard/room/cards/my_room.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

class RoomDashboard extends StatelessWidget {
  const RoomDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth(context),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: StreamBuilder<dynamic>(
                  initialData: 0,
                  stream: roomTabBarBloc.stateStream,
                  builder: (c, s) {
                    return s.data == 0 ? myRoom(context) : addRoom(context);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
