import 'package:fit_generation/src/auth_feat/auth_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const kDefaultChannelType = "dev";
const kDefaultChannelId =
    "!members-Kkqo_kW_XP4z_ApZHzRKNrxtw1EfRtvY6ARYxBWIzH0";
const kStreamChatApiKey = "cb2e82d3hkf8";

/// Instance of Stream Client.
///
/// Stream's [StreamChatClient] can be used to connect to our servers and
/// set the default user for the application. Performing these actions
/// trigger a websocket connection allowing for real-time updates.
final streamChatClientProvider = Provider<StreamChatClient>((ref) {
  return StreamChatClient(kStreamChatApiKey, logLevel: Level.INFO);
}, name: "streamChatClientProvider");

/// Return default channel until the state will be overridden like:
/// ```
/// ref.read(currentStreamChannelProvider.notifier).state = channel;
/// ```
final currentStreamChannelProvider = StateProvider<Channel>((ref) {
  final client = ref.watch(streamChatClientProvider);
  return Channel(client, kDefaultChannelType, kDefaultChannelId);
}, name: "currentStreamChannelProvider");

/// must be alive to prevent to reload.
final streamChannelListControllerProvider =
    Provider<StreamChannelListController>((ref) {
  final streamChatClient = ref.watch(streamChatClientProvider);
  final currentUserId = ref.watch(authRepoProvider).currentUserId();

  return StreamChannelListController(
    client: streamChatClient,
    filter: Filter.in_(
      'members',
      [currentUserId!],
    ),
    sort: const [SortOption('last_message_at')],
    limit: 20,
  );
});

/// async connect the current user to the streamChatClient.
/// Do not dispose to have the future value present trough app live
final initChatFutureProvider = FutureProvider<void>((ref) async {
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
  final streamUser = await streamChatClient.connectUser(
    guestUser,
    devToken.rawValue,
    // '''eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic3VwZXItYmFuZC05In0.0L6lGoeLwkz0aZRUcpZKsvaXtNEDHBcezVTZ0oPq40A''',
  );

  print("connected streamUser: ${streamUser}");

  const gmailAdminId = "rLVaJidIGIdtZObO5noZ6ELNHkK2";
  const bluewinAdminId = "Z3LGR5j9oBU4VdiIAlBTf8MuAZF2";

  if (currentUserId != gmailAdminId && currentUserId != bluewinAdminId) {
    /// create and watch new channel which include the trainers
    /// https://getstream.io/chat/docs/react/creating_channels/?language=dart
    final channelState = await streamChatClient.channel(
      kDefaultChannelType,
      // id: "Fit-Gen_${streamUser.name.substring(0, streamUser.name.indexOf("@"))}",
      id: streamUser.id,
      extraData: {
        "name": "Fit-Generation & ${streamUser.name}",
        "members": [
          streamUser.id,
          gmailAdminId,
          bluewinAdminId,
        ],
      },
    ).watch();

    print("channelState: $channelState");
    print("channelState members: ${channelState.members}");
    print("channelState channel name: ${channelState.channel?.name}");
  }

  // return streamChatClient;
}, name: "initChatFutureProvider");
