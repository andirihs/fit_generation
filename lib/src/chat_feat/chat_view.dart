import 'package:fit_generation/src/chat_feat/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatView extends ConsumerWidget {
  const ChatView({Key? key}) : super(key: key);

  static const routeName = 'chat';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRepo = ref.watch(chatRepoFutureProvider);
    // final chatChannel = ref.watch(chatCredentialModel);

    return chatRepo.when(
      data: (data) {
        return StreamChannel(
          channel: data.streamChatChannel,
          child: Builder(builder: (context) {
            return Scaffold(
              appBar: const StreamChannelHeader(
                title: Text("Chat"),
                showBackButton: false,
                showConnectionStateTile: true,
                showTypingIndicator: true,
                // elevation: 0,
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
      },
      error: (error, st) => Center(
        child: Text(
          error.toString(),
          style: const TextStyle(color: Colors.red),
        ),
      ),
      loading: () => const Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
