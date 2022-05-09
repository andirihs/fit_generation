import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

final chatCredentialModel =
    Provider.autoDispose<StreamChatCredentialModel>((ref) {
  /// The Provider will be overridden in runApp() methode
  throw UnimplementedError();
});

class StreamChatCredentialModel {
  StreamChatCredentialModel({required this.client, required this.channel});
  final StreamChatClient client;
  final Channel channel;
}

class ChatRepo {
  static Future<StreamChatCredentialModel> initSteamChat() async {
    /// Create a new instance of [StreamChatClient] passing the apikey obtained from your
    /// project dashboard.
    final client = StreamChatClient(
      's2dxdhpxd94g',
      logLevel: Level.INFO,
    );

    /// Set the current user. In a production scenario, this should be done using
    /// a backend to generate a user token using our server SDK.
    /// Please see the following for more information:
    /// https://getstream.io/chat/docs/flutter-dart/tokens_and_authentication/?language=dart
    await client.connectUser(
      User(id: 'tutorial-flutter'),
      '''eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic3VwZXItYmFuZC05In0.0L6lGoeLwkz0aZRUcpZKsvaXtNEDHBcezVTZ0oPq40A''',
    );

    /// Creates a channel using the type `messaging` and `flutterdevs`.
    /// Channels are containers for holding messages between different members. To
    /// learn more about channels and some of our predefined types, checkout our
    /// our channel docs: https://getstream.io/chat/docs/flutter-dart/creating_channels/?language=dart
    final channel = client.channel('messaging', id: 'flutterdevs');

    /// `.watch()` is used to create and listen to the channel for updates. If the
    /// channel already exists, it will simply listen for new events.
    await channel.watch();

    return StreamChatCredentialModel(
      client: client,
      channel: channel,
    );
  }
}
