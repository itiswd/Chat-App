import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himochat/model/message.dart';
import 'package:himochat/widgets/chatbubble.dart';
import 'package:himochat/widgets/constant.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();
  final listController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> allmessages = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            allmessages.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
              backgroundColor: const Color(0xff264653),
              appBar: AppBar(
                backgroundColor: const Color(0xff264653),
                toolbarHeight: 72,
                automaticallyImplyLeading: false,
                title: const Text(
                  'Himo Chat',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 28,
                  ),
                ),
                centerTitle: true,
              ),
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.123,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: listController,
                        itemCount: allmessages.length,
                        itemBuilder: (context, index) {
                          return allmessages[index].id == email
                              ? ChatBubble(
                                  message: allmessages[index],
                                )
                              : ChatBubbleFreind(message: allmessages[index]);
                        },
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: primaryColor,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.send,
                                textDirection: TextDirection.rtl,
                                color: primaryColor!,
                                size: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff264653),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: TextField(
                                controller: controller,
                                onSubmitted: (data) {
                                  messages.add({
                                    'message': data,
                                    kCreatedAt: DateTime.now(),
                                    'id': email
                                  });
                                  controller.clear();
                                  listController.animateTo(
                                    0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                },
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  // prefix: Padding(
                                  //   padding: const EdgeInsets.only(left: 8.0),
                                  //   child: Icon(
                                  //     Icons.send,
                                  //     textDirection: TextDirection.rtl,
                                  //     color: primaryColor!,
                                  //     size: 12,
                                  //   ),
                                  // ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  hintText: 'مراسلة',
                                  hintTextDirection: TextDirection.rtl,
                                  hintStyle: TextStyle(
                                    height: 1,
                                    color: Colors.white54,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}
