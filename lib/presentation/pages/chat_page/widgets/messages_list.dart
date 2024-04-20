// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:v_chat/bloc/get_messages_bloc/get_messages_bloc.dart';
// import 'package:v_chat/presentation/pages/chat_page/widgets/chat_message.dart';

// Widget messagesList(String id) {
//   return BlocProvider(
//     create: (context) => GetMessagesBloc()..add(MessagesEvent(id: id)),
//     child: BlocBuilder<GetMessagesBloc, GetMessagesState>(
//       builder: (context, state) {
//         return ListView.builder(
//             shrinkWrap: true,
//             itemCount: state.messages.length,
//             itemBuilder: (context, index) {
//               return chatMessage(
//                   state.messages[index]['senderId'] != id,
//                   state.messages[index]['message'],
//                   state.messages[index]["createdAt"]);
//             });
//       },
//     ),
//   );
// }
