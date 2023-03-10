import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/Pages/About_sial.dart';
import 'package:flutter_catalog/Pages/Agenda_Meeting.dart';
import 'package:flutter_catalog/Pages/Calender_upcoming.dart';
import 'package:flutter_catalog/Pages/Mintues_of_Meeting.dart';
import 'package:flutter_catalog/Pages/home_page.dart';
import 'package:flutter_catalog/Pages/setting.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void logout() {
    // Remove the stored CNIC and Folio number
    final _box = GetStorage();
    _box.remove('cnic');
    _box.remove('folio');

    // Navigate to the login screen
    Get.offAllNamed(MyRoutes.LoginRout);
  }

  @override
  Widget build(BuildContext context) {
    // void _profile() {
    //   Navigator.popAndPushNamed(context, "/https://www.sial.com.pk/");
    // }

    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 51, 80, 165),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                currentAccountPictureSize: Size.square(80),
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 28, 44, 92)),
                margin: EdgeInsets.zero,
                accountName: Text(
                  "Saleem Akhter",
                  style: TextStyle(fontSize: 10.sp),
                ),
                accountEmail: Text(
                  "it@sial.com.pk",
                  style: TextStyle(fontSize: 10.sp),
                ),
                // currentAccountPicture: Image.network(imageUrl),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 51, 80, 165),
                  // radius: 20,
                  backgroundImage: AssetImage("assets/images/user.png"),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                textScaleFactor: 1.1,
                style: TextStyle(color: Colors.white, fontSize: 11.sp),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                Get.to(() => AgendaMeeting(),
                    transition: Transition.leftToRightWithFade);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AgendaMeeting()));
              },
              leading: Icon(
                CupertinoIcons.map_pin_slash,
                color: Colors.white,
              ),
              title: Text(
                "Agenda of Meetings",
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                Get.to(() => MofMeeting(),
                    transition: Transition.leftToRightWithFade);
              },
              leading: Icon(
                CupertinoIcons.plus_circle_fill,
                color: Colors.white,
              ),
              title: Text(
                "Minutes of Meetings",
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                if (await canLaunch("https://www.sial.com.pk/")) {
                  await launch("https://www.sial.com.pk/");
                }
              },
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "SIAL Website",
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                Get.to(() => Settings(),
                    transition: Transition.leftToRightWithFade);
              },
              leading: Icon(
                CupertinoIcons.gear_solid,
                color: Colors.white,
              ),
              title: Text(
                "Setting",
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                Get.to(() => CalenderWidget(),
                    transition: Transition.leftToRightWithFade);
              },
              leading: Icon(
                CupertinoIcons.calendar,
                color: Colors.white,
              ),
              title: Text(
                "Calendar Schedule",
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 1));
                Get.to(() => About_sial(),
                    transition: Transition.leftToRightWithFade);
              },
              leading: Icon(
                CupertinoIcons.ant_circle,
                color: Colors.white,
              ),
              title: Text(
                "About",
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                logout();
              },
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
              title: Text(
                "Logout",
                textScaleFactor: 1.1,
                style: TextStyle(color: Colors.white, fontSize: 11.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw 'Could not launch $_url';
//   }
// }

// _launchUrl() async {
//   const url = 'https://www.sial.com.pk/';
//   if (await canLaunchUrl(Uri.parse(url))) {
//     await launchUrl(Uri.parse(url));
//   } else {
//     throw 'Could not launch $url';
//   }
// }

_launchUrl() async {
  var url = Uri.parse("https://www.sial.com.pk/");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURLApp() async {
  var url = Uri.parse("https://www.sial.com.pk/");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
