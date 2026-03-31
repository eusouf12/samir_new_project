import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_nav_bar/inf_navbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/calender_controller.dart';

class CalenderScreen extends StatelessWidget {
  CalenderScreen({super.key});
  final CalenderController calenderController = Get.put(CalenderController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      calenderController.getCalendar();
    });
    return CustomGradient(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: 30,),
              Obx(() {
                if (calenderController.isCalendarLoading.value) {
                  return Center(child: CustomLoader(color: AppColors.primary2,));
                }

                return TableCalendar(
                  calendarStyle: CalendarStyle(
                    cellMargin: EdgeInsets.only(top: 12),
                    markersMaxCount: 0,
                    markerSize: 0,
                    markerMargin: EdgeInsets.zero,
                    markerDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    defaultTextStyle: TextStyle(color: AppColors.black),

                    todayDecoration: BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                    ),

                    todayTextStyle: TextStyle(color: AppColors.white),

                    selectedDecoration: BoxDecoration(
                      color: AppColors.primary2,
                      shape: BoxShape.circle,
                    ),
                  ),
                  locale: "en_US",
                  rowHeight: 90,
                  headerStyle: HeaderStyle(
                    headerMargin: EdgeInsets.only(bottom: 20),
                    titleTextStyle: TextStyle(
                        color: AppColors.primary2,
                        fontSize: 24.w,
                        fontWeight: FontWeight.w700
                    ),
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primary2,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primary2,
                    ),
                  ),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(calenderController.selectedDate.value, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    calenderController.changeDate(selectedDay);

                    final normalized =
                    DateTime(selectedDay.year, selectedDay.month, selectedDay.day);

                    final events =
                    calenderController.eventMap[normalized];

                    if (events != null && events.isNotEmpty) {
                      // UPDATE MODE
                      calenderController.setUpdateData(events.first);
                      _openCalendarForm(context, isUpdate: true, id: events.first.id);
                    } else {
                      // CREATE MODE
                      calenderController.clearUpdateFields();
                      _openCalendarForm(context, isUpdate: false);
                    }
                  },
                  focusedDay: calenderController.selectedDate.value ?? DateTime.now(),
                  //firstDay: DateTime.now(),
                  firstDay: DateTime(2020),
                  lastDay: DateTime(DateTime.now().year + 5),
                  eventLoader: (day) {
                    final normalizedDay = DateTime(day.year, day.month, day.day);
                    return calenderController.eventMap[normalizedDay] ?? [];
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {return const SizedBox.shrink();}
                      return null;
                    },
                    todayBuilder: (context, day, focusedDay) {

                      final normalized = DateTime(day.year, day.month, day.day);

                      final events = calenderController.eventMap[normalized];

                      final hasEvent = events != null && events.isNotEmpty;

                      return _buildDateBox(day, hasEvent, true, events: events,);
                    },
                   //other day
                    defaultBuilder: (context, day, focusedDay) {
                      final normalizedDay = DateTime(day.year, day.month, day.day);
                      final events = calenderController.eventMap[normalizedDay];
                      final hasEvent = events != null && events.isNotEmpty;

                      return _buildDateBox(day, hasEvent, false, events: events);
                    },
                  ),
                );
              },
              )
            ],
          ),
          bottomNavigationBar: InfNavbar(currentIndex: 1),
        ),
      ),
    );
  }
  Widget _buildDateBox(DateTime day, bool hasEvent, bool isToday, {List? events}) {
    return Container(
      margin: const EdgeInsets.only(top:5,left: 1,right: 1),
      decoration: BoxDecoration(
        color: isToday ? AppColors.green : (hasEvent ? AppColors.primary2 : Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(text: "${day.day}",textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,fontSize: 14, color: (hasEvent || isToday) ? Colors.white : AppColors.black,fontWeight: FontWeight.w700),
          if (hasEvent && events != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: CustomText(text: events.first.city ?? "",textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,fontSize: 9, color: Colors.white,fontWeight: FontWeight.w500)
            ),
        ],
      ),
    );
  }


  void _openCalendarForm(BuildContext context, {required bool isUpdate, String? id}) {

    final controller = Get.find<CalenderController>();

    OutlineInputBorder _border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 1.5),
    );

    InputDecoration _decoration(String label) {
      return InputDecoration(
        labelText: label,
        focusedBorder: _border(AppColors.primary2),
        enabledBorder: _border(Colors.grey.shade300),
        border: _border(Colors.grey.shade300),
      );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Obx(() => Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(isUpdate ? "Update Schedule" : "Create Schedule", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  const SizedBox(height: 20),

                  // START DATE
                  TextField(
                    controller: controller.startDateController,
                    decoration: _decoration("Start Date (yyyy-MM-dd)"),
                  ),

                  const SizedBox(height: 12),

                  // END DATE
                  TextField(
                    controller: controller.endDateController,
                    decoration: _decoration("End Date (yyyy-MM-dd)"),
                  ),

                  const SizedBox(height: 12),

                  // START TIME
                  TextField(
                    controller: controller.startTimeController,
                    decoration: _decoration("Start Time"),
                  ),

                  const SizedBox(height: 12),

                  // END TIME
                  TextField(
                    controller: controller.endTimeController,
                    decoration: _decoration("End Time"),
                  ),

                  const SizedBox(height: 12),

                  // COUNTRY
                  TextField(
                    controller: controller.countryController,
                    decoration: _decoration("Country"),
                  ),

                  const SizedBox(height: 12),

                  // CITY
                  TextField(
                    controller: controller.cityController,
                    decoration: _decoration("City"),
                  ),

                  const SizedBox(height: 12),

                  if (!isUpdate)
                    TextField(
                      controller: controller.fullAddressController,
                      decoration: _decoration("Full Address"),
                    ),

                  const SizedBox(height: 20),

                  controller.isCreateCalendarLoading.value ||
                      controller.isUpdateCalendarLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(onTap: ()async{
                          if (isUpdate) {
                      await controller.updateCalendar(id: id!);
                    }
                           else {
                      await controller.createCalendar(
                        startDate: controller.startDateController.text.isEmpty
                            ? controller.formattedSelectedDate
                            : controller.startDateController.text,
                        endDate: controller.endDateController.text,
                        startTime: controller.startTimeController.text,
                        endTime: controller.endTimeController.text,
                        country: controller.countryController.text,
                        city: controller.cityController.text,
                        fullAddress:
                        controller.fullAddressController.text,
                      );
                    }
                         },
                          fillColor: AppColors.primary2,
                           textColor: AppColors.white,
                          fontSize: 14,
                          title: isUpdate ? "Update" : "Create",
                       ),
                  const SizedBox(height: 20),
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
