import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'commitee_details.dart';

class CommitteeeListScreen extends StatefulWidget {
  const CommitteeeListScreen({Key? key}) : super(key: key);

  @override
  State<CommitteeeListScreen> createState() => _CommitteeeListScreenState();
}

class _CommitteeeListScreenState extends State<CommitteeeListScreen> {
  List commiteeList = [];
  bool isLoading = false;

  fetchAgenda() async {
    // print("fetching...");
    isLoading = true;

    var request = await http.Request(
        'GET', Uri.parse('http://194.116.228.5:130/Api/CommitteType/GetAll/'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print('api hit commitee List');
      setState(() {
        isLoading = false;

        commiteeList = items;
        print(commiteeList);
      });
    } else {
      setState(() {
        isLoading = false;

        commiteeList = [];
      });
    }
  }

  //////////////////////////
  double screenHeight = 0;
  double screenWidth = 0;

  bool startAnimation = false;

  // List<String> texts = [
  //   "IT Audit Committee",
  //   "Budget Committee",
  //   "Apex Committee",
  // ];

  List<IconData> icons = [
    Icons.computer_outlined,
    Icons.savings,
    Icons.compare_arrows_outlined,
  ];

  @override
  void initState() {
    this.fetchAgenda();

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

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
      // backgroundColor: Color.fromARGB(255, 44, 119, 94),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(
              Theme.of(context).colorScheme.primary,
            )))
          : SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 28,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Theme.of(context).colorScheme.primary,
                        child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(1.5.h),
                            child: Text(
                              'Committee List',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: commiteeList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CommitteeDetailsScreen(
                                          name:
                                              '${commiteeList[index]['name'].toString()}',
                                          tid: int.parse(
                                              "${commiteeList[index]['pkcode']}"),
                                        )));
                          },
                          child: item(
                              index, commiteeList[index]['name'].toString()),
                        );
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
    );
  }

  Widget item(int index, name) {
    return AnimatedContainer(
      height: 55,
      width: screenWidth,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (index * 200)),
      transform:
          Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth / 22,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${index + 1}. ${name}",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            icons[index],
          ),
        ],
      ),
    );
  }
}
