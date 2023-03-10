import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CommitteeDetailsScreen extends StatefulWidget {
  CommitteeDetailsScreen({super.key, required this.tid, required this.name});
  int? tid;
  String? name;

  @override
  State<CommitteeDetailsScreen> createState() => _CommitteeDetailsScreenState();
}

class _CommitteeDetailsScreenState extends State<CommitteeDetailsScreen> {
  var committeeType = {};
  bool isLoading = false;

  var committeeMember = [];

  //// committeeMember api
  fetchCommitteMember() async {
    // print("fetching...");
    isLoading = true;
    var request = await http.Request(
        'GET',
        Uri.parse(
            'http://194.116.228.5:130/Api/ComMem/GetById?pkcode=${widget.tid}'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print('hit committee member api ');
      setState(() {
        isLoading = false;
        committeeMember = items;
        print(committeeMember);
      });
    } else {
      setState(() {
        isLoading = false;
        committeeMember = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchCommitteMember();
  }

/////////////////////////////
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
                                  '${widget.name}',
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
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: committeeMember.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Theme.of(context).colorScheme.tertiary,
                                child: Padding(
                                  padding: EdgeInsets.all(0.2.h),
                                  child: ListTile(
                                    title: Text(
                                      "${committeeMember[index]['shname']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    trailing: Text(
                                      "${committeeMember[index]['folno']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 9.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
