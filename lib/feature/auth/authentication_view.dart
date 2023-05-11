import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_news_app/feature/auth/authentication_provider.dart';
import 'package:flutter_firebase_news_app/product/constants/string_contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'package:flutter_firebase_news_app/product/widgets/text/title_text.dart';

import 'package:flutter_firebase_news_app/product/widgets/text/sub_title_text.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  final authProvider = StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
    return AuthenticationNotifier();
  });

  @override
  void initState() {
    super.initState();

    checkUser(FirebaseAuth.instance.currentUser);
  }

  void checkUser(User? user) {
    ref.read(authProvider.notifier).fetchUserDetail(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firebase.FirebaseUIActions(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            if (state.user != null) checkUser(state.user);
          }),
        ],
        child: SafeArea(
          child: Padding(
            padding: context.paddingLow,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _Header(),
                  Padding(
                    padding: context.paddingNormal,
                    child: firebase.LoginView(
                      showTitle: false,
                      action: firebase.AuthAction.signIn,
                      providers: firebase.FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
                    ),
                  ),
                  if (ref.watch(authProvider).isRedirect)
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        StringContants.continueToApp,
                        style: context.textTheme.bodySmall?.copyWith(decoration: TextDecoration.underline),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          value: StringContants.loginWelcomeBack,
        ),
        Padding(
          padding: context.onlyTopPaddingLow,
          child: const SubTitleText(
            value: StringContants.loginWelcomeDetail,
          ),
        ),
      ],
    );
  }
}
