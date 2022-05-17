import 'package:fit_generation/src/chat_feat/chat_repo.dart';
import 'package:fit_generation/src/chat_feat/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelView extends ConsumerWidget {
  const ChannelView({Key? key}) : super(key: key);

  static const routeName = 'channel';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initStreamChat = ref.watch(initChatFutureProvider);

    return initStreamChat.when(
      data: (_) => const ChannelListWidget(),
      error: (error, _) => Center(
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

class ChannelListWidget extends ConsumerWidget {
  const ChannelListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final _listController = ref.watch(streamChannelListControllerProvider);

    return Scaffold(
      appBar: const StreamChannelListHeader(
        /// createChatWidget removed with actions: []
        actions: [],
      ),
      body: RefreshIndicator(
        onRefresh: _listController.refresh,
        child: StreamChannelListView(
          controller: _listController,
          onChannelTap: (channel) {
            ref.read(currentStreamChannelProvider.notifier).state = channel;
            context.goNamed(ChatView.routeName);
          },
        ),
      ),
    );
  }
}
