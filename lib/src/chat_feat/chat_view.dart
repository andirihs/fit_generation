import 'package:fit_generation/src/chat_feat/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatView extends ConsumerWidget {
  const ChatView({Key? key}) : super(key: key);

  static const routeName = 'chat';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatChannel = ref.watch(chatCredentialModel);

    return StreamChannel(
      channel: chatChannel.channel,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const StreamChannelHeader(
            title: Text("Chat"),
            showBackButton: false,
            showConnectionStateTile: true,
            showTypingIndicator: true,
            // actions: [StreamChannelAvatar(channel: chatChannel.channel)],
          ),
          body: Column(
            children: const <Widget>[
              Expanded(
                child: StreamMessageListView(),
              ),
              StreamMessageInput(),
            ],
          ),
        );
      }),
    );
  }
}
