// ignore_for_file: invalid_required_positional_param

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../model/mom_model.dart';
import 'package:http/http.dart' as http;

import 'mom_dtl.dart';

class MofMeeting extends StatelessWidget {
  // const MyWidget({super.key});

  static Future<List<MomModel>> getMoMeeting() async {
    try {
      final response =
          await http.get(Uri.parse('http://194.116.228.5:130/Api/MOM/GetAll/'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        print('mom api hit...');
        return jsonList.map((json) => MomModel.fromJson(json)).toList();
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
        body: FutureBuilder<List<MomModel>>(
            future: getMoMeeting(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;

                return Container(
                  child: Container(
                    // height: 700,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        // color: Color.fromARGB(255, 77, 122, 100),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                      child: Column(
                        children: [
                          SizedBox(height: 1.h),
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              color: Theme.of(context).colorScheme.primary,
                              child: Container(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.all(1.5.h),
                                  child: Text(
                                    'Mintues of Meetings',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Meetings',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  // color: Colors.white,
                                ),
                              ),
                              Icon(
                                  // color: Colors.white,
                                  Icons.more_horiz)
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final mom = data[index];
                                var tid = mom.tid;
                                var agendaName = mom.meeting;

                                DateTime dateTime =
                                    DateTime.parse(mom.mdate.toString());

                                String formatdate =
                                    DateFormat.yMMMEd().format(dateTime);

                                return GestureDetector(
                                  onTap: () {
                                    // Navigate to Next Details
                                    Get.to(
                                        () => MintuesOfMeetingDetails(
                                              agendaName: agendaName!,
                                              tid: tid!,
                                            ),
                                        transition:
                                            Transition.leftToRightWithFade);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(1.h),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0.8.h, vertical: 0.8.h),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          borderRadius:
                                              BorderRadius.circular(0.8.h)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Icon(Icons.view_agenda),
                                              SizedBox(width: 1.w),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //Title
                                                  Text(
                                                    mom.meeting.toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11.sp,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimaryContainer,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  //Subtitle
                                                  Center(
                                                    child: Text.rich(TextSpan(
                                                        text: 'Date: ',
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onTertiary,
                                                          fontSize: 10.sp,
                                                        ),
                                                        children: <InlineSpan>[
                                                          TextSpan(
                                                            text:
                                                                '$formatdate  ',
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onPrimaryContainer,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: 'Agenda: ',
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onPrimaryContainer,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: mom.agenda
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimaryContainer),
                                                          ),
                                                        ])),
                                                  ),
                                                  Center(
                                                    child: Text.rich(TextSpan(
                                                        text: 'Remarks: ',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimaryContainer,
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        children: <InlineSpan>[
                                                          TextSpan(
                                                            text: mom.remarks,
                                                            style: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimaryContainer),
                                                          ),
                                                        ])),
                                                  ),
                                                  // Text('Commite')
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10.w),
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
                                          // Align(child: Icon(Icons.more_horiz)),
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
                  ),
                );
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Something went wrong'));
              } else {
                return Center(
                    child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).colorScheme.primary,
                  ),
                ));
              }
            }));
  }
}
