import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter_catalog/Pages/Calender_upcoming.dart';
//import 'package:flutter_catalog/Pages/Calender_upcoming.dart';
import 'package:flutter_catalog/widgets/drawer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../model/upcomming_meeting_model.dart';
import 'Agenda_Meeting_Dtl.dart';

class UpComingAgendaMeeting extends StatelessWidget {
  // const MyWidget({super.key});

  static Future<List<UpComingMeetingModel>> getAgendaMeetings() async {
    try {
      final response = await http
          .get(Uri.parse('http://194.116.228.5:130/Api/UPComAgenda/GetAll/'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        print('api hit####');
        return jsonList
            .map((json) => UpComingMeetingModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 28, 44, 92),
      // drawer: MyDrawer(),

      // backgroundColor: Color.fromARGB(255, 28, 44, 92),
      //home: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('SIAL Corporate Affairs'),
      ),

      body: FutureBuilder<List<UpComingMeetingModel>>(
        future: getAgendaMeetings(),
        builder: (context, AsyncSnapshot<List<UpComingMeetingModel>> snapshot) {
          if (snapshot.hasData) {
            final agenda = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                // height: 700,
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 190, 48, 38),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        // topLeft: Radius.circular(30),
                        // topRight: Radius.circular(30),
                        )),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                  child: Column(
                    children: [
                      // SizedBox(height: 1.h),
                      // Image.asset("assets/images/Committee.png",
                      //     fit: BoxFit.cover),
                      // SizedBox(height: 15),
                      // Container(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top: 10, left: 10),
                      //     child: Text(
                      //       'Upcoming Agenda Meeting',
                      //       style: TextStyle(
                      //           fontSize: 25,
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.w600),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Theme.of(context).colorScheme.primary,
                          child: Container(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: Text(
                                'Upcoming Agenda Meeting',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Meetings',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary,
                                    ),
                                  ),
                                  Icon(
                                    Icons.more_horiz,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Expanded(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: agenda!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final upcomingAgenda = agenda[index];
                                  final dateFormat = DateFormat('dd-MMM-yyyy');

                                  final dateString =
                                      upcomingAgenda.mdate.toString();
                                  final date = DateTime.parse(dateString);
                                  final formattedDate = dateFormat.format(date);
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => AgendaMeetingDetail(
                                            agendaName: upcomingAgenda.meeting
                                                .toString(),
                                            tid: int.parse(
                                                upcomingAgenda.tid.toString()),
                                          ));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(1.h),
                                      child: Container(
                                        padding: EdgeInsets.all(1.h),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                // Icon(Icons.view_agenda),
                                                // SizedBox(
                                                //   width: 5.w,
                                                // ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    //Title
                                                    Text(
                                                      upcomingAgenda.meeting
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10.sp,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                      ),
                                                    ),
                                                    SizedBox(height: 3),
                                                    //Subtitle
                                                    Center(
                                                      child: Text.rich(TextSpan(
                                                          text: 'Date: ',
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary,
                                                            fontSize: 10.sp,
                                                          ),
                                                          children: <
                                                              InlineSpan>[
                                                            TextSpan(
                                                              text:
                                                                  "$formattedDate   ",
                                                              style: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: 'Venue: ',
                                                              style: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: upcomingAgenda
                                                                  .mvenue
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary,
                                                              ),
                                                            ),
                                                          ])),
                                                    ),
                                                    Center(
                                                      child: Text.rich(TextSpan(
                                                          text: 'Commite: ',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          children: <
                                                              InlineSpan>[
                                                            TextSpan(
                                                              text: upcomingAgenda
                                                                  .committe
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary,
                                                              ),
                                                            ),
                                                          ])),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 201, 203, 242),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.8.h)),
                                              child: Center(
                                                  child: Icon(
                                                      Icons.arrow_forward_ios)),
                                            )
                                            // Icon(Icons.more_horiz),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Something went wrong'));
          } else {
            return Center(
                child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                Color.fromARGB(255, 28, 44, 92),
              ),
            ));
          }
        },
      ),
    );
  }

  // void _navigateToNextScreen(BuildContext context) {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => AnnualMeeting()));
  // }

  // Widget _selectedAgend(@required Color color, @required String title,
  //     @required String subtitle) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 5.0),
  //     padding: EdgeInsets.only(
  //       left: 10,
  //       right: 5,
  //     ),
  //     // height: 100,
  //     //  width: 260,
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(15.0),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           title,
  //           style: TextStyle(
  //             fontSize: 18,
  //             color: Colors.white,
  //           ),
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Text(
  //           subtitle,
  //           style: TextStyle(
  //             fontSize: 14,
  //             color: Colors.white70,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _selectedExtras(
  //   @required String image,
  //   @required String name,
  //   @required Color color,
  // ) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: color,
  //         borderRadius: BorderRadius.circular(10.0),
  //         border: Border.all(color: Colors.grey, width: 2)),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           height: 80,
  //           decoration: BoxDecoration(
  //             image: DecorationImage(image: AssetImage(image)),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         Text(
  //           name,
  //           style: TextStyle(fontSize: 17, color: Colors.white),
  //         ),

  //         //Color(Colors.green),
  //       ],
  //     ),
  //   );
  // }

  // void _navigateToNext(BuildContext context) {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => CalenderWidget()));
  // }
}
