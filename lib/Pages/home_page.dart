import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/Pages/Agenda_Meeting.dart';
import 'package:flutter_catalog/Pages/Calender_upcoming.dart';
import 'package:flutter_catalog/Pages/Mintues_of_Meeting.dart';
import 'package:flutter_catalog/Pages/Upcoming_Meetings.dart';
import 'package:flutter_catalog/Pages/CommitteListScreen.dart';
import 'package:flutter_catalog/widgets/drawer.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Exit the app when back button is pressed
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        //home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            'SIAL Corporate Affairs',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? Container(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                      child: Column(
                        children: [
                          SizedBox(height: 2.h),
                          Expanded(
                            child: Container(
                              // color: Colors.yellow,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                          borderRadius:
                                              BorderRadius.circular(1.h)),
                                      padding: EdgeInsets.all(1.h),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                          SizedBox(width: 1.h),
                                          Text(
                                            'Search',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 1.h),

                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      child: TextButton(
                                        onPressed: () {
                                          Get.to(() => CalenderWidget(),
                                              transition: Transition
                                                  .leftToRightWithFade);
                                        },
                                        child: Container(
                                          height: 7.h,
                                          width: double.infinity,
                                          child: _selectedAgend(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              "Upcoming Meetings",
                                              "Calender Wise",
                                              context),
                                        ),
                                      ),
                                    ),
                                    // ),
                                    SizedBox(height: 1.h),

                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      child: TextButton(
                                        onPressed: () {
                                          Get.to(() => AgendaMeeting(),
                                              transition: Transition
                                                  .leftToRightWithFade);
                                        },
                                        child: Container(
                                          height: 7.h,
                                          width: double.infinity,
                                          child: _selectedAgend(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              "Total Meetings Over",
                                              " Year 2022",
                                              context),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Theme.of(context).colorScheme.onPrimary,
                              height: 4.h,
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 8,
                                // childAspectRatio: 1.20,
                                children: [
                                  Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Get.to(() => UpComingAgendaMeeting(),
                                            transition:
                                                Transition.leftToRightWithFade);
                                      },
                                      // padding: const EdgeInsets.all(8.0),
                                      child: _selectedExtras(
                                          'assets/images/DueAgenda.png',
                                          'Upcoming Meetings',
                                          Theme.of(context).colorScheme.error,
                                          context),
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Get.to(() => AgendaMeeting(),
                                            transition:
                                                Transition.leftToRightWithFade);
                                      },
                                      //padding: const EdgeInsets.all(8.0),
                                      child: _selectedExtras(
                                          'assets/images/agenda.png',
                                          'Agenda Meetings',
                                          Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          context),
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Get.to(() => MofMeeting(),
                                            transition:
                                                Transition.leftToRightWithFade);
                                      },
                                      child: _selectedExtras(
                                          'assets/images/Minutes-of-Meeting.png',
                                          'Minutes of Meeting',
                                          Theme.of(context)
                                              .colorScheme
                                              .surfaceTint,
                                          context),
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Get.to(() => CommitteeeListScreen(),
                                            transition:
                                                Transition.leftToRightWithFade);
                                      },
                                      child: _selectedExtras(
                                          'assets/images/Committee.png',
                                          'Committees',
                                          Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                      child: Column(
                        children: [
                          SizedBox(height: 1.h),
                          Expanded(
                            flex: 3,
                            child: Container(
                              // color: Colors.yellow,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                          SizedBox(width: 1.h),
                                          Text(
                                            'Search',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 1.h),

                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CalenderWidget()));
                                        },
                                        child: Container(
                                          height: 7.h,
                                          width: double.infinity,
                                          child: _selectedAgend(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              "Upcoming Meetings",
                                              "Calender Wise",
                                              context),
                                        ),
                                      ),
                                    ),
                                    // ),
                                    SizedBox(height: 0.h),

                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AgendaMeeting()));
                                        },
                                        child: Container(
                                          height: 7.h,
                                          width: double.infinity,
                                          child: _selectedAgend(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              "Total Meetings Over",
                                              " Year 2022",
                                              context),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              color: Theme.of(context).colorScheme.onPrimary,
                              height: 4.h,
                              child: GridView.count(
                                crossAxisCount: 4,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                                // childAspectRatio: 1.20,
                                children: [
                                  Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpComingAgendaMeeting()));
                                      },
                                      // padding: const EdgeInsets.all(8.0),
                                      child: _selectedExtras(
                                          'assets/images/DueAgenda.png',
                                          'Upcoming Meetings',
                                          Theme.of(context).colorScheme.error,
                                          context),
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AgendaMeeting()));
                                      },
                                      //padding: const EdgeInsets.all(8.0),
                                      child: _selectedExtras(
                                          'assets/images/agenda.png',
                                          'Agenda Meetings',
                                          Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          context),
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MofMeeting()));
                                      },
                                      child: _selectedExtras(
                                          'assets/images/Minutes-of-Meeting.png',
                                          'Minutes of Meeting',
                                          Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          context),
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommitteeeListScreen()));
                                      },
                                      child: _selectedExtras(
                                          'assets/images/Committee.png',
                                          'Committees',
                                          Theme.of(context)
                                              .colorScheme
                                              .surfaceTint,
                                          context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        }),

        // ),
        drawer: MyDrawer(),
        //)
      ),
    );
  }

  Widget _selectedAgend(Color color, String title, String subtitle, context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 3.w),

      //height: 100,
      //  width: 260,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(0.5.h),
      ),
      child: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10.sp,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _selectedExtras(String image, String name, Color color, context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(1.h),
          border: Border.all(
              color: Theme.of(context).colorScheme.onPrimary, width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 10.h,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(image)),
            ),
          ),
          SizedBox(height: 5),
          Text(
            name,
            style: TextStyle(
                fontSize: 13.sp,
                color: Theme.of(context).colorScheme.onPrimary),
          ),

          //Color(Colors.green),
        ],
      ),
    );
  }
}
