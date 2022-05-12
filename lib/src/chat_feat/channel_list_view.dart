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
      data: (_) {
        return const ChannelListWidget();
      },
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

class ChannelListWidget extends ConsumerStatefulWidget {
  const ChannelListWidget({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ChannelListWidgetState();
}

class _ChannelListWidgetState extends ConsumerState<ChannelListWidget> {
  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    sort: const [SortOption('last_message_at')],
    limit: 20,
  );

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final userId = StreamChat.of(context).currentUser!.id;
    final streamClient = StreamChat.of(context).client;

    /// add the current user to the default chat.
    /// Nothing happened when the user is already in this chat.
    /// This action use special permission and is therefore only possible
    /// in channelType: "dev"
    streamClient.addChannelMembers(
      defaultChannelId,
      defaultChannelType,
      [userId],
    );
  }

  void _onNewChatTapped() {
    //ToDo: add dialog or route to create a chat with:
    // name, picture and invite chat-member
    final userId = StreamChat.of(context).currentUser!.id;
    // final streamClient = StreamChat.of(context).client;

    // streamClient.createChannel("dev", channelData: {
    //   "name": "hello World Dev",
    //   "members": ["$userId", "rLVaJidIGIdtZObO5noZ6ELNHkK2"]
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamChannelListHeader(onNewChatButtonTap: _onNewChatTapped),
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
