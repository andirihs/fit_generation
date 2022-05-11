import 'package:fit_generation/src/auth_feat/auth_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const defaultChannelType = "dev";
const defaultChannelId = "!members-Kkqo_kW_XP4z_ApZHzRKNrxtw1EfRtvY6ARYxBWIzH0";
const streamChatApiKey = "cb2e82d3hkf8";

/// Instance of Stream Client.
///
/// Stream's [StreamChatClient] can be used to connect to our servers and
/// set the default user for the application. Performing these actions
/// trigger a websocket connection allowing for real-time updates.
final streamChatClientProvider = Provider<StreamChatClient>((ref) {
  return StreamChatClient(streamChatApiKey, logLevel: Level.INFO);
}, name: "streamChatClientProvider");

/// Return default channel until the state will be overridden like:
/// ```
/// ref.read(currentStreamChannelProvider.notifier).state = channel;
/// ```
final currentStreamChannelProvider = StateProvider<Channel>((ref) {
  final client = ref.watch(streamChatClientProvider);
  return Channel(client, defaultChannelType, defaultChannelId);
}, name: "currentStreamChannelProvider");

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
  await streamChatClient.connectUser(
    guestUser,
    devToken.rawValue,
    // '''eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic3VwZXItYmFuZC05In0.0L6lGoeLwkz0aZRUcpZKsvaXtNEDHBcezVTZ0oPq40A''',
  );

  // return streamChatClient;
}, name: "initChatFutureProvider");
