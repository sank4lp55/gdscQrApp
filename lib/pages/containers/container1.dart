import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:xpense_flutter_web/pages/containers/container2.dart';
import 'package:xpense_flutter_web/pages/output.dart';
import 'package:xpense_flutter_web/utils/colors.dart';
import 'package:xpense_flutter_web/utils/constants.dart';
import 'package:xpense_flutter_web/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Container1 extends StatefulWidget {
  const Container1({Key? key}) : super(key: key);

  @override
  _Container1State createState() => _Container1State();
}

class _Container1State extends State<Container1> {
  String? qrdata;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileContainer1(),
      desktop: DesktopContainer1(),
    );
  }

  _qrScanner() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      qrdata = await scanner.scan();
      //String? qrDataPhoto = await scanner.scanPhoto();
      print(qrdata);
      if (qrdata != null) {
        Get.to(Output(
          riddle: qrdata,
        ));
      }
      //print(qrDataPhoto);
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        qrdata = await scanner.scan();
        print(qrdata);
        if (qrdata != null) {
          Get.to(Output(
            riddle: qrdata,
          ));
        }
      }
    }
  }

  _launchURL() async {
    const url = 'https://www.instagram.com/gdsc_akgec/?hl=en';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  //================ MOBILE ===============

  Widget MobileContainer1() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 20),
      child: Column(
        children: [
          InkWell(
            //onTap: _qrScanner(),
            onTap: () {
              _qrScanner();
              // Get.to(Output(
              //   riddle: qrdata!,
              // ));
              //print("yes");
            },
            child: Container(
              height: w! / 3.5,
              width: w! / 3.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(qr), fit: BoxFit.contain)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '\nTap Above \nTo Scan \n',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w! / 10, fontWeight: FontWeight.bold, height: 1),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Why are you still reading this !?\nHurry Up ! Scan the QR',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 45,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary)),
                onPressed: _launchURL,
                // icon: Icon(Icons.arrow_drop_down),
                child: Text('Follow Us')),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'GDSC Akgec',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          )
        ],
      ),
    );
  }

  //============== DESKTOP =============

  Widget DesktopContainer1() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Container(
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tap the\nLeft Icon\nTo Scan\n',
                  style: TextStyle(
                      fontSize: w! / 30,
                      fontWeight: FontWeight.bold,
                      height: 1),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please open the webApp through your Mobile phone !',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 45,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.primary)),
                          onPressed: () {},
                          //icon: Icon(Icons.arrow_drop_down),
                          child: Text('Follow Us')),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'GDSC Akgec',
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          )),
          Expanded(
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(qr), fit: BoxFit.contain)),
            ),
          ),
        ],
      ),
    );
  }
}
