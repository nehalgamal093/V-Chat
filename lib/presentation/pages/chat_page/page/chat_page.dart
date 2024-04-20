import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_chat/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:v_chat/presentation/pages/chat_page/widgets/chat_message.dart';
import 'package:v_chat/presentation/pages/chat_page/widgets/message_input.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:v_chat/presentation/pages/skeleton/messages_skeleton/message_skeleton.dart';
import 'package:v_chat/services/chat/chat.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final String name;
  final String img;
  const ChatPage(
      {super.key, required this.id, required this.name, required this.img});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<dynamic> list = [];
  late final IO.Socket _socket;
  String? userId;
  late SharedPreferences prefs;
  getUserId() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id').toString();
    });
  }

  _connectSocket() async {
    prefs = await SharedPreferences.getInstance();
    String id = '';
    setState(() {
      id = prefs.getString('user_id').toString();
    });
    _socket = IO.io(
        dotenv.env['BASE_URL'],
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({'userId': id})
            .enableForceNewConnection()
            .build());
    _socket.onConnect((data) => print('Connection established'));
    _socket.onError((data) => print('Connect Error: $data'));
    _socket.on('newMessage', (data) {
      if (data['senderId'] == widget.id) {
        setState(() {
          list.add({
            "senderId": widget.id,
            "receiverId": userId,
            "message": data['message'],
            "createdAt": DateTime.now()
          });
        });
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(
              _scrollController.position.maxScrollExtent,
            );
          }
        });
      }
    });
  }

  saveIdOfCurrentSender() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    //save id of the sender so it will not send notification when chat is open
    sharedPrefs.setString('sender_id', widget.id);
  }

  removeIdOfCurrentSender() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    //save id of the sender so it will not send notification when chat is open
    sharedPrefs.remove('sender_id');
  }

  @override
  void initState() {
    super.initState();
    saveIdOfCurrentSender();
    _connectSocket();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent,
          );
        }
      });
    });
    getUserId();
  }

  @override
  void dispose() {
    _socket.disconnect();
    removeIdOfCurrentSender();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red,
              child: Image.network(widget.img),
            ),
            const SizedBox(width: 10),
            Text(widget.name),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(child: BlocBuilder<GetMessagesBloc, GetMessagesState>(
              builder: (context, state) {
                list = state.messages;

                if (state.messagesStatus == GetMessagesStatus.loading) {
                  return messageSkeleton(context);
                } else if (state.messagesStatus == GetMessagesStatus.loaded) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return chatMessage(
                                  list[index]['senderId'] != widget.id,
                                  list[index]['message'],
                                  list[index]["createdAt"].substring(11, 16));
                            }),
                      ),
                      messageInput(context, _messageController, () async {
                        String msg = _messageController.text;
                        _messageController.clear();
                        setState(() {
                          list.add({
                            "senderId": userId,
                            "receiverId": widget.id,
                            "message": msg,
                            "createdAt": DateTime.now()
                          });
                        });
                        Future.delayed(const Duration(milliseconds: 150), () {
                          if (_scrollController.hasClients) {
                            _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent,
                            );
                          }
                        });
                        Chat().sendMessage(msg, widget.id);
                      }, _scrollController),
                    ],
                  );
                } else if (state.messagesStatus ==
                    GetMessagesStatus.receiveMessage) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) {
                              return chatMessage(
                                  list[index]['senderId'] != widget.id,
                                  list[index]['message'],
                                  list[index]["createdAt"].substring(11, 16));
                            }),
                      ),
                      messageInput(context, _messageController, () async {
                        String msg = _messageController.text;
                        _messageController.clear();
                        setState(() {
                          list.add({
                            "senderId": userId,
                            "receiverId": widget.id,
                            "message": _messageController.text,
                            "createdAt": DateTime.now()
                          });
                        });
                        Future.delayed(const Duration(milliseconds: 150), () {
                          if (_scrollController.hasClients) {
                            _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent,
                            );
                          }
                        });
                        Chat().sendMessage(msg, widget.id);
                      }, _scrollController)
                    ],
                  );
                } else if (state.messagesStatus == GetMessagesStatus.error) {
                  return const Text('Error');
                } else {
                  return const Text('Something else');
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
