import 'dart:async';

import 'package:appointment/app/builder.dart';
import 'package:appointment/inside/i18n/translations.g.dart';
import 'package:appointment/outside/theme/theme.dart';
import 'package:flutter/material.dart';

import 'mocks/mocked_app.dart';

FutureOr<Widget> testAppBuilder({
  required Key key,
  required String? accessToken,
  required String? deepLinkOverride,
  required MocksContainer mocks,
  required OutsideTheme theme,
}) async {
  mocks.mockEffectProviderGetEffectMethods();

  return await appBuilder(
    key: key,
    deepLinkFragmentOverride: deepLinkOverride,
    appLocale: AppLocale.en,
    theme: theme,
    accessToken: accessToken,
    effectProviders: mocks.effectProviders,
    repositories: mocks.repositories,
  );
}
