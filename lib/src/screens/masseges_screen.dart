import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/massages_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_constant.dart';

class MassagesScreen extends StatefulWidget {
  static const routeName = "/massages-screen";
  final String chatId;
  final bool isChatScreen;

  const MassagesScreen({Key key, this.chatId, this.isChatScreen = false})
      : super(key: key);
  @override
  _MassagesScreenState createState() => _MassagesScreenState();
}

class _MassagesScreenState extends State<MassagesScreen> {
  TextEditingController _textEditingController = TextEditingController();

  var isWitchLand = false;

  var isLoading = false;

  String _recievedId;
  String _chatId;

  @override
  void initState() {
    super.initState();
    fetchMassages();
  }

  void fetchMassages() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<MassagesProvider>(context, listen: false)
        .fetchChatMessages(widget.chatId);
    setState(() {
      isLoading = false;
    });
  }

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

    final isMe = Provider.of<AuthProvider>(context, listen: false).userId;

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
      body: isLoading
          ? Center(
              child: sleekCircularSlider(
                context,
                40,
                AppColors.primaryColor,
                AppColors.scondryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<MassagesProvider>(
                builder: (context, massage, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          reverse: true,
                          itemCount: massage.chatMassages.length,
                          itemBuilder: (context, i) {
                            _recievedId = massage.chatMassages[i].receiverId;
                            _chatId = massage.chatMassages[i].chatId;
                            return Column(
                              mainAxisAlignment:
                                  isMe == massage.chatMassages[i].senderId
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              crossAxisAlignment:
                                  isMe == massage.chatMassages[i].senderId
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  // width: screenUtil.setWidth(450),
                                  decoration: BoxDecoration(
                                    color:
                                        isMe == massage.chatMassages[i].senderId
                                            ? Colors.grey[300]
                                            : AppColors.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: isMe ==
                                              massage.chatMassages[i].senderId
                                          ? Radius.circular(10)
                                          : Radius.circular(0),
                                      bottomRight: isMe ==
                                              massage.chatMassages[i].senderId
                                          ? Radius.circular(0)
                                          : Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    massage.chatMassages[i].content,
                                    style: TextStyle(
                                      color: isMe ==
                                              massage.chatMassages[i].senderId
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: isLandScape
                                          ? screenUtil.setSp(25)
                                          : screenUtil.setSp(35),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            );
                          }),
                    ),

                    // SizedBox(height: 5),
                    Container(
                      // color: Colors.grey,
                      height: isLandScape
                          ? screenUtil.setHeight(450)
                          : screenUtil.setHeight(270),
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
                                    labelText: "  اكتب رسالتك...",
                                    labelStyle: TextStyle(
                                      fontSize: isLandScape
                                          ? screenUtil.setSp(25)
                                          : screenUtil.setSp(30),
                                    ),
                                    contentPadding: EdgeInsets.all(8.0),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  controller: _textEditingController,
                                ),
                              ),
                              SizedBox(width: 20),
                              InkWell(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Icon(
                                    Icons.send,
                                    size: isLandScape
                                        ? screenUtil.setSp(35)
                                        : screenUtil.setSp(60),
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                onTap: () async {
                                  if (_textEditingController.text
                                          .trim()
                                          .length <
                                      1) {
                                    return;
                                  }
                                  try {
                                    await Provider.of<MassagesProvider>(context,
                                            listen: false)
                                        .postMessage(
                                      content: _textEditingController.text,
                                      senderId: int.parse(isMe),
                                      recieverId: int.parse(_recievedId),
                                      chatId: int.parse(_chatId),
                                    );
                                    _textEditingController.clear();
                                  } catch (e) {
                                    // print(e.toString());
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "يوجد خطأ الرجاء التاكد من الاتصال بالانترنت",
                                        ),
                                      ),
                                    );
                                  }
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
            ),
    );
  }
}
