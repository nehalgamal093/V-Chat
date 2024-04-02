import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_chat/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:v_chat/presentation/pages/chat_page/widgets/chat_message.dart';
import 'package:v_chat/presentation/pages/chat_page/widgets/message_input.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:v_chat/presentation/pages/skeleton/messages_skeleton/message_skeleton.dart';
import 'package:v_chat/services/chat/chat.dart';

class ChatPage extends StatefulWidget {
  final String id;

  const ChatPage({super.key, required this.id});

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
        'https://chat-app-nehal-gamal.onrender.com',
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
          });
        });
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(
              _scrollController.position.maxScrollExtent,
            );
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
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
                                  list[index]['message']);
                            }),
                      ),
                      messageInput(context, _messageController, () async {
                        String msg = _messageController.text;
                        _messageController.clear();
                        setState(() {
                          print('message is ${msg}');
                          list.add({
                            "senderId": userId,
                            "receiverId": widget.id,
                            "message": msg,
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
                                  list[index]['message']);
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
                } else {
                  return Container();
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
