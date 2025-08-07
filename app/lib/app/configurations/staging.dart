import 'package:logging/logging.dart' as logging;

import '../../inside/i18n/translations.g.dart';
import '../../outside/client_providers/supabase/client_provider_configuration.dart';
import '../../outside/effect_providers/mixpanel/effect_provider_configuration.dart';
import '../../outside/theme/theme.dart';
import '../runner.dart';
import 'configuration.dart';

void main() {
  final configuration = AppConfiguration(
    appLocale: AppLocale.esCo,
    logLevel: logging.Level.ALL,
    theme: OutsideThemes.lightTheme,
    deepLinkBaseUri:
        'com.daniel.villamizar.appointment.appointment.staging.deep://deeplink-callback',
    clientProvidersConfigurations: ClientProvidersConfigurations(
      sentry: null,
      supabase: const Supabase_ClientProvider_Configuration(
        url: 'https://ahrwudgekwmsrddktfsl.supabase.co',
        anonKey:
            '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFocnd1ZGdla3dtc3JkZGt0ZnNsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ1MTc5NzYsImV4cCI6MjA3MDA5Mzk3Nn0.VwJJrZ0yXI4I016Ubgf21Xgub2vmjcKnEooRYkvjDco''',
      ),
    ),
    effectProvidersConfigurations: EffectProvidersConfigurations(
      mixpanel: const Mixpanel_EffectProvider_Configuration(
        sendEvents: true,
        token: 'CHANGE_ME',
        environment: 'CHANGE_ME',
      ),
    ),
  );

  appRunner(configuration: configuration);
}
