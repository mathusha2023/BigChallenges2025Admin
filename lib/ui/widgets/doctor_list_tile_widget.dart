import 'package:bc_admin/data/doctor_list_model.dart';
import 'package:bc_admin/ui/router/extra_data_model.dart';
import 'package:bc_admin/ui/widgets/doctor_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorListTileWidget extends StatelessWidget {
  const DoctorListTileWidget({super.key, required this.doctor});

  final DoctorListModel doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(
          "/doctors_list/doctors/${doctor.id}",
          extra: ExtraDataModel(doctor: doctor),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                DoctorIconWidget(
                  width: 80,
                  height: 94,
                  image: "assets/images/doctor_icon.png",
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      spacing: 3,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth:
                                MediaQuery.of(context).size.width -
                                80 -
                                16 -
                                20,
                          ),
                          child: Text(
                            doctor.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Text(
                          doctor.gender == 1 ? "Женщина" : "Мужчина",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Text(
                          "${doctor.age} лет",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
