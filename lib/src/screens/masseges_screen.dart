import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/massages_provider.dart';
import '../utils/app_constant.dart';

class MassagesScreen extends StatefulWidget {
  static const routeName = "/massages-screen";
  @override
  _MassagesScreenState createState() => _MassagesScreenState();
}

class _MassagesScreenState extends State<MassagesScreen> {
  TextEditingController _textEditingController = TextEditingController();

  var isWitchLand = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final massages = Provider.of<MassagesProvider>(context, listen: false)
        .massages
        .reversed
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          " المحادثات",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: massages.length,
                itemBuilder: (context, i) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: massages[i].senderId == "1"
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      // width: screenUtil.setWidth(450),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: massages[i].senderId == "1"
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        crossAxisAlignment: massages[i].senderId == "1"
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Text(
                            massages[i].senderId,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: isLandScape
                                  ? screenUtil.setSp(25)
                                  : screenUtil.setSp(35),
                            ),
                          ),
                          Text(
                            massages[i].content,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.black,
                              fontSize: isLandScape
                                  ? screenUtil.setSp(22)
                                  : screenUtil.setSp(32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 5),
            Container(
              // color: Colors.grey,
              height: isLandScape
                  ? screenUtil.setHeight(450)
                  : screenUtil.setHeight(300),
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "اكتب رسالتك",
                            labelStyle: TextStyle(
                              fontSize: isLandScape
                                  ? screenUtil.setSp(25)
                                  : screenUtil.setSp(30),
                            ),
                            contentPadding: EdgeInsets.all(8.0),
                            errorBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          controller: _textEditingController,
                          // onChanged: (value) {
                          //   setState(() {
                          //     commentText = value;
                          //   });
                          // },
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Icon(
                            Icons.send,
                            size: isLandScape
                                ? screenUtil.setSp(35)
                                : screenUtil.setSp(60),
                            color: AppColors.primaryColor,
                          ),
                        ),
                        onTap: () async {
                          // if (_textEditingController.text.trim().length < 1) {
                          //   return;
                          // }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
