import 'package:fit_generation/src/auth_feat/auth_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// must be override when starting application
final streamChatClientProvider = Provider<StreamChatClient>((ref) {
  throw UnimplementedError();
});

final chatRepoFutureProvider = FutureProvider<ChatRepo>((ref) async {
  final streamChatClient = ref.watch(streamChatClientProvider);
  final currentUserId = ref.watch(authRepoProvider).currentUserId();
  final currentUserEmail = ref.watch(authRepoProvider).currentUserEmail();

  if (currentUserId == null) {
    throw "no user authenticated";
  }

  final guestUser = User(id: currentUserId, name: currentUserEmail);

  //ToDo: replace dev token: https://getstream.io/chat/docs/flutter-dart/tokens_and_authentication/?language=dart
  final devToken = streamChatClient.devToken(guestUser.id);

  print("StreamChat dev token: $devToken");

  /// Set the current user. In a production scenario, this should be done using
  /// a backend to generate a user token using our server SDK.
  /// Please see the following for more information:
  /// https://getstream.io/chat/docs/flutter-dart/tokens_and_authentication/?language=dart
  await streamChatClient.connectUser(
    guestUser,
    devToken.rawValue,
    // '''eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic3VwZXItYmFuZC05In0.0L6lGoeLwkz0aZRUcpZKsvaXtNEDHBcezVTZ0oPq40A''',
    connectWebSocket: true,
  );

  // streamChatClient.connectGuestUser(guestUser);

  /// Creates a channel using the type `messaging` and `flutterdevs`.
  /// Channels are containers for holding messages between different members. To
  /// learn more about channels and some of our predefined types, checkout our
  /// our channel docs: https://getstream.io/chat/docs/flutter-dart/creating_channels/?language=dart
  /// https://dashboard.getstream.io/app/1184326/chat/explorer?path=channels,dev_channel_type:fit-generation
  final streamChatChannel =
      streamChatClient.channel('dev', id: 'fit_generation2');

  /// `.watch()` is used to create and listen to the channel for updates. If the
  /// channel already exists, it will simply listen for new events.
  await streamChatChannel.watch();

  // await streamChatChannel.addMembers([guestUser.id]);

  return ChatRepo(
    streamChatClient: streamChatClient,
    streamChatChannel: streamChatChannel,
  );
}, name: "chatRepoFutureProvider");

class ChatRepo {
  ChatRepo({required this.streamChatClient, required this.streamChatChannel});

  final StreamChatClient streamChatClient;
  final Channel streamChatChannel;
}
