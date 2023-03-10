import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'Agenda_Meeting_Dtl.dart';

class AgendaMeeting extends StatefulWidget {
  @override
  State<AgendaMeeting> createState() => _AgendaMeetingPageState();
}

class _AgendaMeetingPageState extends State<AgendaMeeting> {
  // const MyWidget({super.key});
  List Agenda = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchAgenda();
  }

  fetchAgenda() async {
    // print("fetching...");
    isLoading = true;
    var request = await http.Request(
        'GET', Uri.parse('http://194.116.228.5:130/Api/Caagenda/GetAll/'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print(items);
      setState(() {
        isLoading = false;
        Agenda = items;
      });
    } else {
      setState(() {
        isLoading = false;
        Agenda = [];
      });
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(
              Theme.of(context).colorScheme.primary,
            )))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Container(
                  // height: 700,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only()),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: Theme.of(context).colorScheme.primary,
                            child: Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(1.5.h),
                                child: Text(
                                  'Agenda Meeting',
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
                        getList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      // ),
      // drawer: MyDrawer(),
      //)
    );
  }

  Widget getList() {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: Agenda.length,
        itemBuilder: (context, index) {
          return getCard(Agenda[index]);
        },
      ),
    );
  }

  Widget getCard(index) {
    var agendaName = index['meeting'];
    int tid = index['tid'];
    var mdate = index['mdate'];
    DateTime dateTime = DateTime.parse(mdate);

    String formatdate = DateFormat.yMMMEd().format(dateTime);
    var venu = index['mvenue'];
    var committe = index['committe'];

    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      child: Padding(
        padding: EdgeInsets.all(0.2.h),
        child: ListTile(
          onTap: () {
            // Navigate to Next Details
            Get.to(() => AgendaMeetingDetail(tid: tid, agendaName: agendaName),
                transition: Transition.leftToRightWithFade);
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title
                  Text(
                    agendaName.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //Subtitle
                  Center(
                    child: Text.rich(TextSpan(
                        text: 'Date: ',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onTertiary,
                            fontSize: 10.sp),
                        children: <InlineSpan>[
                          TextSpan(
                            text: (formatdate),
                            style: TextStyle(
                                fontSize: 10.sp, color: Colors.grey.shade800),
                          ),
                          TextSpan(
                            text: '    Venue: ',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Theme.of(context).colorScheme.onTertiary,
                            ),
                          ),
                          TextSpan(
                            text: venu.toString(),
                            style: TextStyle(
                                fontSize: 10.sp, color: Colors.grey.shade800),
                          ),
                        ])),
                  ),
                  Center(
                    child: Text.rich(TextSpan(
                        text: 'Commite: ',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onTertiary,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          TextSpan(
                            text: committe.toString(),
                            style: TextStyle(
                                fontSize: 10.sp,
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
                          ),
                        ])),
                  ),
                  // Text('Commite')
                ],
              ),
              // Icon(Icons.more_horiz),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 201, 203, 242),
                    borderRadius: BorderRadius.circular(0.8.h)),
                child: Center(child: Icon(Icons.arrow_forward_ios)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
