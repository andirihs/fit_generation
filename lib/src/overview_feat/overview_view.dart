import 'package:fit_generation/src/auth_feat/auth_repo.dart';
import 'package:fit_generation/src/util_widget/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OverviewView extends ConsumerWidget {
  const OverviewView({Key? key}) : super(key: key);

  static const routeName = 'overview';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(authRepoProvider).currentUserEmail();

    return Scaffold(
      appBar: CustomAppBar(title: "Hi $userEmail"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: const OverviewWidget(
                subtitle: "recipes",
                contentWidget: SizedBox(
                  child: Center(child: Text("placeholder")),
                  height: 180,
                ),
              ),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            const OverviewWidget(
              subtitle: "About us",
              contentWidget: SizedBox(
                child: Center(child: Text("placeholder")),
                height: 120,
              ),
            ),
            Container(
              child: const OverviewWidget(
                subtitle: "subscriptions",
                contentWidget: SizedBox(
                  child: Center(child: Text("placeholder")),
                  height: 150,
                ),
              ),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}

class OverviewWidget extends ConsumerWidget {
  const OverviewWidget({
    required this.subtitle,
    required this.contentWidget,
    Key? key,
  }) : super(key: key);

  final String subtitle;
  final Widget contentWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Align(
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              alignment: Alignment.topLeft),
          contentWidget,
        ],
      ),
    );
  }
}

// class WebViewFitGeneration extends StatefulWidget {
//   const WebViewFitGeneration({Key? key}) : super(key: key);
//
//   @override
//   WebViewFitGenerationState createState() => WebViewFitGenerationState();
// }
//
// class WebViewFitGenerationState extends State<WebViewFitGeneration> {
//   static const _urlToFitGeneration = "https://fit-generation.ch";
//
//   @override
//   void initState() {
//     super.initState();
//     // Enable virtual display.
//     if (Platform.isAndroid) WebView.platform = AndroidWebView();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const WebView(
//       initialUrl: _urlToFitGeneration,
//       allowsInlineMediaPlayback: true,
//       javascriptMode: JavascriptMode.unrestricted,
//     );
//   }
// }
