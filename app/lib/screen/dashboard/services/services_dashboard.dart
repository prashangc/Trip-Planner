import 'package:app/screen/dashboard/main/model/side_nav_model.dart';
import 'package:app/screen/dashboard/services/cards/add_services.dart';
import 'package:app/screen/dashboard/services/cards/my_services.dart';
import 'package:app/widgets/my_sizes.dart';
import 'package:flutter/material.dart';

class ServicesDashboard extends StatelessWidget {
  const ServicesDashboard({super.key});

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
                  stream: serviceTabBarBloc.stateStream,
                  builder: (c, s) {
                    return s.data == 0
                        ? myServices(context)
                        : addServices(context);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
