import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class MintuesOfMeetingDetails extends StatefulWidget {
  const MintuesOfMeetingDetails(
      {super.key, required this.tid, required this.agendaName});
  final int tid;
  final String agendaName;
  @override
  State<MintuesOfMeetingDetails> createState() =>
      _MintuesOfMeetingDetails(tid: this.tid, agendaName: this.agendaName);
}

class _MintuesOfMeetingDetails extends State<MintuesOfMeetingDetails> {
  int tid;
  String agendaName;
  _MintuesOfMeetingDetails({required this.tid, required this.agendaName});
  @override
  List Agendadtl = [];
  bool isLoading = false;

  void initState() {
    super.initState();
    this.fetchMOMDetails();
  }

  fetchMOMDetails() async {
    // print("fetching...");
    isLoading = true;

    var request = await http.Request('GET',
        Uri.parse('http://194.116.228.5:130/Api/MOMDtl/GetById?tid=$tid'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print('hit mom details api');
      setState(() {
        isLoading = false;

        Agendadtl = items;
        print(Agendadtl);
      });
    } else {
      setState(() {
        isLoading = false;

        Agendadtl = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          : Column(
              children: [
                Container(
                  child: Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 151, 151, 156),
                          borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(30),
                              // topRight: Radius.circular(30),
                              )),
                      child: Column(
                        children: [
                          Container(
                            height: 20.h,
                            width: double.infinity,
                            child: Image.asset("assets/images/agenda.jpg",
                                fit: BoxFit.cover),
                          ),
                          SizedBox(height: 1.h),
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              color: Theme.of(context).colorScheme.primary,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  agendaName.toString() + " Detail",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Expanded(child: getList()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
      // drawer: MyDrawer(),
    );
  }

  Widget getList() {
    return ListView.builder(
      itemCount: Agendadtl.length,
      itemBuilder: (context, index) {
        return getCard(Agendadtl[index]);
      },
    );
  }

  Widget getCard(index) {
    // var agendaName = index['meeting'];
    int tid = index['tid'];
    var n = index["adtl"];
    var trno = index["trno"];
    var rmks = index["rmks"];
    var rcmnd = index["rcmnd"];
    var asgnto = index["asgnto"];

    return Card(
      color: Color.fromRGBO(217, 218, 253, 1),
      child: Padding(
        padding: EdgeInsets.all(0.4.h),
        child: ListTile(
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Remarks: $rmks",
                style: TextStyle(
                    fontSize: 10.sp,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
              Text(
                "Recommendation: $rcmnd",
                style: TextStyle(
                    fontSize: 10.sp,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
              Text(
                "Asign To: ${asgnto}",
                style: TextStyle(
                    fontSize: 10.sp,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
            ],
          ),
          title: Text(
            n.toString(),
            style: TextStyle(
                fontSize: 10.sp,
                color: Theme.of(context).colorScheme.onTertiary),
          ),
          trailing: Text(
            trno.toString(),
            style: TextStyle(
                fontSize: 10.sp,
                color: Theme.of(context).colorScheme.onTertiary),
          ),
        ),
      ),
    );
  }
}
