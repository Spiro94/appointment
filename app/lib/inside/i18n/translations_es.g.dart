///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEs = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsEmailVerificationLinkSentEs emailVerificationLinkSent = TranslationsEmailVerificationLinkSentEs._(_root);
	late final TranslationsForgotPasswordEs forgotPassword = TranslationsForgotPasswordEs._(_root);
	late final TranslationsHomeEs home = TranslationsHomeEs._(_root);
	late final TranslationsResetPasswordLinkSentEs resetPasswordLinkSent = TranslationsResetPasswordLinkSentEs._(_root);
	late final TranslationsResetPasswordEs resetPassword = TranslationsResetPasswordEs._(_root);
	late final TranslationsSignInEs signIn = TranslationsSignInEs._(_root);
	late final TranslationsSignUpEs signUp = TranslationsSignUpEs._(_root);
}

// Path: emailVerificationLinkSent
class TranslationsEmailVerificationLinkSentEs {
	TranslationsEmailVerificationLinkSentEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Enlace de Verificación de Correo Enviado';
	String get subtitle => 'Revisa tu correo para el enlace de verificación.';
}

// Path: forgotPassword
class TranslationsForgotPasswordEs {
	TranslationsForgotPasswordEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '¿Olvidaste tu Contraseña?';
	late final TranslationsForgotPasswordFormEs form = TranslationsForgotPasswordFormEs._(_root);
}

// Path: home
class TranslationsHomeEs {
	TranslationsHomeEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Inicio';
	late final TranslationsHomeNavigationEs navigation = TranslationsHomeNavigationEs._(_root);
	late final TranslationsHomeFeedEs feed = TranslationsHomeFeedEs._(_root);
}

// Path: resetPasswordLinkSent
class TranslationsResetPasswordLinkSentEs {
	TranslationsResetPasswordLinkSentEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Enlace de Restablecimiento de Contraseña';
	String get subtitle => 'Revisa tu correo para el enlace de restablecimiento de contraseña.';
	late final TranslationsResetPasswordLinkSentResendEs resend = TranslationsResetPasswordLinkSentResendEs._(_root);
}

// Path: resetPassword
class TranslationsResetPasswordEs {
	TranslationsResetPasswordEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Restablecer Contraseña';
	late final TranslationsResetPasswordFormEs form = TranslationsResetPasswordFormEs._(_root);
}

// Path: signIn
class TranslationsSignInEs {
	TranslationsSignInEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Iniciar Sesión';
	late final TranslationsSignInSignUpEs signUp = TranslationsSignInSignUpEs._(_root);
	late final TranslationsSignInForgotPasswordEs forgotPassword = TranslationsSignInForgotPasswordEs._(_root);
	late final TranslationsSignInFormEs form = TranslationsSignInFormEs._(_root);
}

// Path: signUp
class TranslationsSignUpEs {
	TranslationsSignUpEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Registrarse';
	late final TranslationsSignUpFormEs form = TranslationsSignUpFormEs._(_root);
	late final TranslationsSignUpResendEmailVerificationEs resendEmailVerification = TranslationsSignUpResendEmailVerificationEs._(_root);
}

// Path: forgotPassword.form
class TranslationsForgotPasswordFormEs {
	TranslationsForgotPasswordFormEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsForgotPasswordFormEmailEs email = TranslationsForgotPasswordFormEmailEs._(_root);
	late final TranslationsForgotPasswordFormSubmitEs submit = TranslationsForgotPasswordFormSubmitEs._(_root);
}

// Path: home.navigation
class TranslationsHomeNavigationEs {
	TranslationsHomeNavigationEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get feed => 'Feed';
	String get appointmentCapture => 'Agregar Cita';
	String get profile => 'Perfil';
	String get settings => 'Configuración';
}

// Path: home.feed
class TranslationsHomeFeedEs {
	TranslationsHomeFeedEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Próximas Citas';
	String get empty => 'No tienes citas próximas';
	String get emptySubtitle => 'Toca el botón + para crear tu primera cita';
}

// Path: resetPasswordLinkSent.resend
class TranslationsResetPasswordLinkSentResendEs {
	TranslationsResetPasswordLinkSentResendEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get question => '¿No recibiste el enlace?';
	String get action => 'Reenviar';
	String get success => 'Tu enlace de restablecimiento de contraseña fue reenviado.';
}

// Path: resetPassword.form
class TranslationsResetPasswordFormEs {
	TranslationsResetPasswordFormEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsResetPasswordFormPasswordEs password = TranslationsResetPasswordFormPasswordEs._(_root);
	late final TranslationsResetPasswordFormSubmitEs submit = TranslationsResetPasswordFormSubmitEs._(_root);
}

// Path: signIn.signUp
class TranslationsSignInSignUpEs {
	TranslationsSignInSignUpEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get question => '¿Necesitas una cuenta?';
	String get action => 'Registrarse';
}

// Path: signIn.forgotPassword
class TranslationsSignInForgotPasswordEs {
	TranslationsSignInForgotPasswordEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get question => '¿Olvidaste tu contraseña?';
}

// Path: signIn.form
class TranslationsSignInFormEs {
	TranslationsSignInFormEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSignInFormEmailEs email = TranslationsSignInFormEmailEs._(_root);
	late final TranslationsSignInFormPasswordEs password = TranslationsSignInFormPasswordEs._(_root);
	late final TranslationsSignInFormSubmitEs submit = TranslationsSignInFormSubmitEs._(_root);
}

// Path: signUp.form
class TranslationsSignUpFormEs {
	TranslationsSignUpFormEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSignUpFormEmailEs email = TranslationsSignUpFormEmailEs._(_root);
	late final TranslationsSignUpFormPasswordEs password = TranslationsSignUpFormPasswordEs._(_root);
	late final TranslationsSignUpFormSubmitEs submit = TranslationsSignUpFormSubmitEs._(_root);
}

// Path: signUp.resendEmailVerification
class TranslationsSignUpResendEmailVerificationEs {
	TranslationsSignUpResendEmailVerificationEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get question => '¿Aún necesitas verificar tu correo?';
	String get action => 'Reenviar';
	late final TranslationsSignUpResendEmailVerificationDialogEs dialog = TranslationsSignUpResendEmailVerificationDialogEs._(_root);
}

// Path: forgotPassword.form.email
class TranslationsForgotPasswordFormEmailEs {
	TranslationsForgotPasswordFormEmailEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Correo Electrónico';
	String get hint => 'juan.perez@ejemplo.com';
	late final TranslationsForgotPasswordFormEmailErrorEs error = TranslationsForgotPasswordFormEmailErrorEs._(_root);
}

// Path: forgotPassword.form.submit
class TranslationsForgotPasswordFormSubmitEs {
	TranslationsForgotPasswordFormSubmitEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Restablecer Contraseña';
}

// Path: resetPassword.form.password
class TranslationsResetPasswordFormPasswordEs {
	TranslationsResetPasswordFormPasswordEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Contraseña';
	late final TranslationsResetPasswordFormPasswordErrorEs error = TranslationsResetPasswordFormPasswordErrorEs._(_root);
}

// Path: resetPassword.form.submit
class TranslationsResetPasswordFormSubmitEs {
	TranslationsResetPasswordFormSubmitEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Restablecer Contraseña';
	String get success => 'Tu contraseña fue restablecida.';
}

// Path: signIn.form.email
class TranslationsSignInFormEmailEs {
	TranslationsSignInFormEmailEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Correo Electrónico';
	String get hint => 'juan.perez@ejemplo.com';
	late final TranslationsSignInFormEmailErrorEs error = TranslationsSignInFormEmailErrorEs._(_root);
}

// Path: signIn.form.password
class TranslationsSignInFormPasswordEs {
	TranslationsSignInFormPasswordEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Contraseña';
	late final TranslationsSignInFormPasswordErrorEs error = TranslationsSignInFormPasswordErrorEs._(_root);
}

// Path: signIn.form.submit
class TranslationsSignInFormSubmitEs {
	TranslationsSignInFormSubmitEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Iniciar Sesión';
}

// Path: signUp.form.email
class TranslationsSignUpFormEmailEs {
	TranslationsSignUpFormEmailEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Correo Electrónico';
	String get hint => 'juan.perez@ejemplo.com';
	late final TranslationsSignUpFormEmailErrorEs error = TranslationsSignUpFormEmailErrorEs._(_root);
}

// Path: signUp.form.password
class TranslationsSignUpFormPasswordEs {
	TranslationsSignUpFormPasswordEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Contraseña';
	late final TranslationsSignUpFormPasswordErrorEs error = TranslationsSignUpFormPasswordErrorEs._(_root);
}

// Path: signUp.form.submit
class TranslationsSignUpFormSubmitEs {
	TranslationsSignUpFormSubmitEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Registrarse';
}

// Path: signUp.resendEmailVerification.dialog
class TranslationsSignUpResendEmailVerificationDialogEs {
	TranslationsSignUpResendEmailVerificationDialogEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Enlace de Verificación de Correo';
	String get cancel => 'Cancelar';
	late final TranslationsSignUpResendEmailVerificationDialogSubmitEs submit = TranslationsSignUpResendEmailVerificationDialogSubmitEs._(_root);
}

// Path: forgotPassword.form.email.error
class TranslationsForgotPasswordFormEmailErrorEs {
	TranslationsForgotPasswordFormEmailErrorEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa tu dirección de correo electrónico.';
	String get invalid => 'Por favor ingresa una dirección de correo electrónico válida.';
}

// Path: resetPassword.form.password.error
class TranslationsResetPasswordFormPasswordErrorEs {
	TranslationsResetPasswordFormPasswordErrorEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa una contraseña.';
	String get invalid => 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un carácter especial.';
}

// Path: signIn.form.email.error
class TranslationsSignInFormEmailErrorEs {
	TranslationsSignInFormEmailErrorEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa tu dirección de correo electrónico.';
	String get invalid => 'Por favor ingresa una dirección de correo electrónico válida.';
}

// Path: signIn.form.password.error
class TranslationsSignInFormPasswordErrorEs {
	TranslationsSignInFormPasswordErrorEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa una contraseña.';
}

// Path: signUp.form.email.error
class TranslationsSignUpFormEmailErrorEs {
	TranslationsSignUpFormEmailErrorEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa tu dirección de correo electrónico.';
	String get invalid => 'Por favor ingresa una dirección de correo electrónico válida.';
}

// Path: signUp.form.password.error
class TranslationsSignUpFormPasswordErrorEs {
	TranslationsSignUpFormPasswordErrorEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa una contraseña.';
	String get invalid => 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un carácter especial.';
}

// Path: signUp.resendEmailVerification.dialog.submit
class TranslationsSignUpResendEmailVerificationDialogSubmitEs {
	TranslationsSignUpResendEmailVerificationDialogSubmitEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Reenviar';
	String get success => 'Tu enlace de verificación de correo fue reenviado.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'emailVerificationLinkSent.title': return 'Enlace de Verificación de Correo Enviado';
			case 'emailVerificationLinkSent.subtitle': return 'Revisa tu correo para el enlace de verificación.';
			case 'forgotPassword.title': return '¿Olvidaste tu Contraseña?';
			case 'forgotPassword.form.email.label': return 'Correo Electrónico';
			case 'forgotPassword.form.email.hint': return 'juan.perez@ejemplo.com';
			case 'forgotPassword.form.email.error.empty': return 'Por favor ingresa tu dirección de correo electrónico.';
			case 'forgotPassword.form.email.error.invalid': return 'Por favor ingresa una dirección de correo electrónico válida.';
			case 'forgotPassword.form.submit.label': return 'Restablecer Contraseña';
			case 'home.title': return 'Inicio';
			case 'home.navigation.feed': return 'Feed';
			case 'home.navigation.appointmentCapture': return 'Agregar Cita';
			case 'home.navigation.profile': return 'Perfil';
			case 'home.navigation.settings': return 'Configuración';
			case 'home.feed.title': return 'Próximas Citas';
			case 'home.feed.empty': return 'No tienes citas próximas';
			case 'home.feed.emptySubtitle': return 'Toca el botón + para crear tu primera cita';
			case 'resetPasswordLinkSent.title': return 'Enlace de Restablecimiento de Contraseña';
			case 'resetPasswordLinkSent.subtitle': return 'Revisa tu correo para el enlace de restablecimiento de contraseña.';
			case 'resetPasswordLinkSent.resend.question': return '¿No recibiste el enlace?';
			case 'resetPasswordLinkSent.resend.action': return 'Reenviar';
			case 'resetPasswordLinkSent.resend.success': return 'Tu enlace de restablecimiento de contraseña fue reenviado.';
			case 'resetPassword.title': return 'Restablecer Contraseña';
			case 'resetPassword.form.password.label': return 'Contraseña';
			case 'resetPassword.form.password.error.empty': return 'Por favor ingresa una contraseña.';
			case 'resetPassword.form.password.error.invalid': return 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un carácter especial.';
			case 'resetPassword.form.submit.label': return 'Restablecer Contraseña';
			case 'resetPassword.form.submit.success': return 'Tu contraseña fue restablecida.';
			case 'signIn.title': return 'Iniciar Sesión';
			case 'signIn.signUp.question': return '¿Necesitas una cuenta?';
			case 'signIn.signUp.action': return 'Registrarse';
			case 'signIn.forgotPassword.question': return '¿Olvidaste tu contraseña?';
			case 'signIn.form.email.label': return 'Correo Electrónico';
			case 'signIn.form.email.hint': return 'juan.perez@ejemplo.com';
			case 'signIn.form.email.error.empty': return 'Por favor ingresa tu dirección de correo electrónico.';
			case 'signIn.form.email.error.invalid': return 'Por favor ingresa una dirección de correo electrónico válida.';
			case 'signIn.form.password.label': return 'Contraseña';
			case 'signIn.form.password.error.empty': return 'Por favor ingresa una contraseña.';
			case 'signIn.form.submit.label': return 'Iniciar Sesión';
			case 'signUp.title': return 'Registrarse';
			case 'signUp.form.email.label': return 'Correo Electrónico';
			case 'signUp.form.email.hint': return 'juan.perez@ejemplo.com';
			case 'signUp.form.email.error.empty': return 'Por favor ingresa tu dirección de correo electrónico.';
			case 'signUp.form.email.error.invalid': return 'Por favor ingresa una dirección de correo electrónico válida.';
			case 'signUp.form.password.label': return 'Contraseña';
			case 'signUp.form.password.error.empty': return 'Por favor ingresa una contraseña.';
			case 'signUp.form.password.error.invalid': return 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un carácter especial.';
			case 'signUp.form.submit.label': return 'Registrarse';
			case 'signUp.resendEmailVerification.question': return '¿Aún necesitas verificar tu correo?';
			case 'signUp.resendEmailVerification.action': return 'Reenviar';
			case 'signUp.resendEmailVerification.dialog.title': return 'Enlace de Verificación de Correo';
			case 'signUp.resendEmailVerification.dialog.cancel': return 'Cancelar';
			case 'signUp.resendEmailVerification.dialog.submit.label': return 'Reenviar';
			case 'signUp.resendEmailVerification.dialog.submit.success': return 'Tu enlace de verificación de correo fue reenviado.';
			default: return null;
		}
	}
}

