import 'package:fit_generation/src/chat_feat/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatView extends ConsumerWidget {
  const ChatView({Key? key}) : super(key: key);

  static const routeName = 'chat';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(currentStreamChannelProvider);
    return StreamChannel(
      channel: channel,
      showLoading: false,
      child: Scaffold(
        appBar: const StreamChannelHeader(
          title: Text("Chat"),
          showBackButton: true,
          showConnectionStateTile: true,
          showTypingIndicator: true,
          // elevation: 0,
          // actions: [StreamChannelAvatar(channel: chatChannel.channel)],
        ),
        body: Column(
          children: const <Widget>[
            Expanded(
              child: StreamMessageListView(
                  // messageBuilder: _messageBuilder,
                  ),
            ),
            StreamMessageInput(),
          ],
        ),
      ),
    );
  }
}

Widget _messageBuilder(
  BuildContext context,
  MessageDetails details,
  List<Message> messages,
  StreamMessageWidget _,
) {
  final message = details.message;
  final isCurrentUser =
      StreamChat.of(context).currentUser!.id == message.user!.id;
  final textAlign = isCurrentUser ? TextAlign.right : TextAlign.left;
  final color = isCurrentUser ? Colors.blueGrey : Colors.blue;

  return Padding(
    padding: const EdgeInsets.all(5),
    child: Card(
      color: color,
      child: ListTile(
        title: Text(
          message.text!,
          textAlign: textAlign,
        ),
        subtitle: Text(
          message.user!.name,
          textAlign: textAlign,
        ),
      ),
    ),
    // ),
  );
}
