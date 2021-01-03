import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';

class PersonalAssistantBot extends StatefulWidget {
  @override
  _PersonalAssistantBotState createState() => _PersonalAssistantBotState();
}

class _PersonalAssistantBotState extends State<PersonalAssistantBot> {
  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "Google Service Account").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });

    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();
  @override
  void initState() {
    messsages.insert(0,
        {"data": 0, "message": "Hey, I am Dr.Robo !\nHow Can I assist you?"});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        backgroundColor: Color(0xff073763),
        automaticallyImplyLeading: false,
        title: Text(
          "Dr. Robot",
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/plus.png',
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 10),
                  child: Text(
                    "Today, ${DateFormat("Hm").format(DateTime.now())}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Flexible(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: messsages.length,
                        itemBuilder: (context, index) => chat(
                            messsages[index]["message"].toString(),
                            messsages[index]["data"]))),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 5.0,
                  thickness: 0.5,
                  color: Color(0xff073763),
                ),
                Container(
                  child: ListTile(
                    title: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xFFDCDCDC),
                      ),
                      padding: EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: messageInsert,
                        decoration: InputDecoration(
                          hintText: "Enter a Message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        onChanged: (value) {},
                      ),
                    ),
                    trailing: Container(
                      height: 45,
                      width: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff073763),
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                          icon: Icon(
                            Icons.send_sharp,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (messageInsert.text.isEmpty) {
                              print("empty message");
                            } else {
                              setState(() {
                                messsages.insert(0,
                                    {"data": 1, "message": messageInsert.text});
                              });
                              response(messageInsert.text);
                              //sample();
                              messageInsert.clear();
                            }
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 7),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/doctorRobot.png"),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                radius: Radius.circular(15.0),
                color: data == 1 ? Colors.grey : Colors.orangeAccent,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void sample() {
    messsages.insert(0, {"data": 0, "message": 'Hey, I am your assistant'});
  }
}
