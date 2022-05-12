import 'package:fit_generation/src/auth_feat/auth_view.dart';
import 'package:fit_generation/src/localization/i10n.dart';
import 'package:fit_generation/src/shared_services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  static const String routeName = "welcome";

  void _navigate(BuildContext context, WidgetRef ref) async {
    final sharedPrefService = ref.read(sharedPrefServiceProvider);
    await sharedPrefService.setOnboardingDone();

    context.goNamed(AuthView.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.shortestSide;
    double imageWidth;
    imageWidth = screenWidth > 600 ? 400 : screenWidth * 0.8;

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: context.l10n.onboardingScreen1Header,
          body: "",
          image: Image.asset(
            'assets/logo/Logo_Fit-Generation.png',
            width: imageWidth * 0.5,
          ),
        ),
      ],
      showDoneButton: true,
      onDone: () => _navigate(context, ref),
      done: Text(context.l10n.onboardingScreenDoneButtonText),
      showNextButton: false,
      next: const Icon(Icons.arrow_forward),
      showSkipButton: false,
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.transparent,
      ),
    );
  }
}
