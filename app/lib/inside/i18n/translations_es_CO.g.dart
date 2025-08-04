///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEsCo = Translations; // ignore: unused_element
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
		    locale: AppLocale.esCo,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es-CO>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsEmailVerificationLinkSentEsCo emailVerificationLinkSent = TranslationsEmailVerificationLinkSentEsCo._(_root);
	late final TranslationsForgotPasswordEsCo forgotPassword = TranslationsForgotPasswordEsCo._(_root);
	late final TranslationsHomeEsCo home = TranslationsHomeEsCo._(_root);
	late final TranslationsResetPasswordLinkSentEsCo resetPasswordLinkSent = TranslationsResetPasswordLinkSentEsCo._(_root);
	late final TranslationsResetPasswordEsCo resetPassword = TranslationsResetPasswordEsCo._(_root);
	late final TranslationsSignInEsCo signIn = TranslationsSignInEsCo._(_root);
	late final TranslationsSignUpEsCo signUp = TranslationsSignUpEsCo._(_root);
}

// Path: emailVerificationLinkSent
class TranslationsEmailVerificationLinkSentEsCo {
	TranslationsEmailVerificationLinkSentEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Enlace de Verificación de Correo Enviado';
	String get subtitle => 'Revisa tu correo para el enlace de verificación.';
}

// Path: forgotPassword
class TranslationsForgotPasswordEsCo {
	TranslationsForgotPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '¿Olvidaste tu Contraseña?';
	late final TranslationsForgotPasswordFormEsCo form = TranslationsForgotPasswordFormEsCo._(_root);
}

// Path: home
class TranslationsHomeEsCo {
	TranslationsHomeEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Inicio';
	late final TranslationsHomeNavigationEsCo navigation = TranslationsHomeNavigationEsCo._(_root);
	late final TranslationsHomeFeedEsCo feed = TranslationsHomeFeedEsCo._(_root);
}

// Path: resetPasswordLinkSent
class TranslationsResetPasswordLinkSentEsCo {
	TranslationsResetPasswordLinkSentEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Enlace de Restablecimiento de Contraseña';
	String get subtitle => 'Revisa tu correo para el enlace de restablecimiento de contraseña.';
	late final TranslationsResetPasswordLinkSentResendEsCo resend = TranslationsResetPasswordLinkSentResendEsCo._(_root);
}

// Path: resetPassword
class TranslationsResetPasswordEsCo {
	TranslationsResetPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Restablecer Contraseña';
	late final TranslationsResetPasswordFormEsCo form = TranslationsResetPasswordFormEsCo._(_root);
}

// Path: signIn
class TranslationsSignInEsCo {
	TranslationsSignInEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Iniciar Sesión';
	late final TranslationsSignInSignUpEsCo signUp = TranslationsSignInSignUpEsCo._(_root);
	late final TranslationsSignInForgotPasswordEsCo forgotPassword = TranslationsSignInForgotPasswordEsCo._(_root);
	late final TranslationsSignInFormEsCo form = TranslationsSignInFormEsCo._(_root);
}

// Path: signUp
class TranslationsSignUpEsCo {
	TranslationsSignUpEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Registrarse';
	late final TranslationsSignUpFormEsCo form = TranslationsSignUpFormEsCo._(_root);
	late final TranslationsSignUpResendEmailVerificationEsCo resendEmailVerification = TranslationsSignUpResendEmailVerificationEsCo._(_root);
}

// Path: forgotPassword.form
class TranslationsForgotPasswordFormEsCo {
	TranslationsForgotPasswordFormEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsForgotPasswordFormEmailEsCo email = TranslationsForgotPasswordFormEmailEsCo._(_root);
	late final TranslationsForgotPasswordFormSubmitEsCo submit = TranslationsForgotPasswordFormSubmitEsCo._(_root);
}

// Path: home.navigation
class TranslationsHomeNavigationEsCo {
	TranslationsHomeNavigationEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get feed => 'Feed';
	String get appointmentCapture => 'Agregar Cita';
	String get profile => 'Perfil';
	String get settings => 'Configuración';
}

// Path: home.feed
class TranslationsHomeFeedEsCo {
	TranslationsHomeFeedEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Próximas Citas';
	String get empty => 'No tienes citas próximas';
	String get emptySubtitle => 'Toca el botón + para crear tu primera cita';
}

// Path: resetPasswordLinkSent.resend
class TranslationsResetPasswordLinkSentResendEsCo {
	TranslationsResetPasswordLinkSentResendEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get question => '¿No recibiste el enlace?';
	String get action => 'Reenviar';
	String get success => 'Tu enlace de restablecimiento de contraseña fue reenviado.';
}

// Path: resetPassword.form
class TranslationsResetPasswordFormEsCo {
	TranslationsResetPasswordFormEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsResetPasswordFormPasswordEsCo password = TranslationsResetPasswordFormPasswordEsCo._(_root);
	late final TranslationsResetPasswordFormSubmitEsCo submit = TranslationsResetPasswordFormSubmitEsCo._(_root);
}

// Path: signIn.signUp
class TranslationsSignInSignUpEsCo {
	TranslationsSignInSignUpEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get question => '¿Necesitas una cuenta?';
	String get action => 'Registrarse';
}

// Path: signIn.forgotPassword
class TranslationsSignInForgotPasswordEsCo {
	TranslationsSignInForgotPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get question => '¿Olvidaste tu contraseña?';
}

// Path: signIn.form
class TranslationsSignInFormEsCo {
	TranslationsSignInFormEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSignInFormEmailEsCo email = TranslationsSignInFormEmailEsCo._(_root);
	late final TranslationsSignInFormPasswordEsCo password = TranslationsSignInFormPasswordEsCo._(_root);
	late final TranslationsSignInFormSubmitEsCo submit = TranslationsSignInFormSubmitEsCo._(_root);
}

// Path: signUp.form
class TranslationsSignUpFormEsCo {
	TranslationsSignUpFormEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSignUpFormEmailEsCo email = TranslationsSignUpFormEmailEsCo._(_root);
	late final TranslationsSignUpFormPasswordEsCo password = TranslationsSignUpFormPasswordEsCo._(_root);
	late final TranslationsSignUpFormSubmitEsCo submit = TranslationsSignUpFormSubmitEsCo._(_root);
}

// Path: signUp.resendEmailVerification
class TranslationsSignUpResendEmailVerificationEsCo {
	TranslationsSignUpResendEmailVerificationEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get question => '¿Aún necesitas verificar tu correo?';
	String get action => 'Reenviar';
	late final TranslationsSignUpResendEmailVerificationDialogEsCo dialog = TranslationsSignUpResendEmailVerificationDialogEsCo._(_root);
}

// Path: forgotPassword.form.email
class TranslationsForgotPasswordFormEmailEsCo {
	TranslationsForgotPasswordFormEmailEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Correo Electrónico';
	String get hint => 'juan.perez@ejemplo.com';
	late final TranslationsForgotPasswordFormEmailErrorEsCo error = TranslationsForgotPasswordFormEmailErrorEsCo._(_root);
}

// Path: forgotPassword.form.submit
class TranslationsForgotPasswordFormSubmitEsCo {
	TranslationsForgotPasswordFormSubmitEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Restablecer Contraseña';
}

// Path: resetPassword.form.password
class TranslationsResetPasswordFormPasswordEsCo {
	TranslationsResetPasswordFormPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Contraseña';
	late final TranslationsResetPasswordFormPasswordErrorEsCo error = TranslationsResetPasswordFormPasswordErrorEsCo._(_root);
}

// Path: resetPassword.form.submit
class TranslationsResetPasswordFormSubmitEsCo {
	TranslationsResetPasswordFormSubmitEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Restablecer Contraseña';
	String get success => 'Tu contraseña fue restablecida.';
}

// Path: signIn.form.email
class TranslationsSignInFormEmailEsCo {
	TranslationsSignInFormEmailEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Correo Electrónico';
	String get hint => 'juan.perez@ejemplo.com';
	late final TranslationsSignInFormEmailErrorEsCo error = TranslationsSignInFormEmailErrorEsCo._(_root);
}

// Path: signIn.form.password
class TranslationsSignInFormPasswordEsCo {
	TranslationsSignInFormPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Contraseña';
	late final TranslationsSignInFormPasswordErrorEsCo error = TranslationsSignInFormPasswordErrorEsCo._(_root);
}

// Path: signIn.form.submit
class TranslationsSignInFormSubmitEsCo {
	TranslationsSignInFormSubmitEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Iniciar Sesión';
}

// Path: signUp.form.email
class TranslationsSignUpFormEmailEsCo {
	TranslationsSignUpFormEmailEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Correo Electrónico';
	String get hint => 'juan.perez@ejemplo.com';
	late final TranslationsSignUpFormEmailErrorEsCo error = TranslationsSignUpFormEmailErrorEsCo._(_root);
}

// Path: signUp.form.password
class TranslationsSignUpFormPasswordEsCo {
	TranslationsSignUpFormPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Contraseña';
	late final TranslationsSignUpFormPasswordErrorEsCo error = TranslationsSignUpFormPasswordErrorEsCo._(_root);
}

// Path: signUp.form.submit
class TranslationsSignUpFormSubmitEsCo {
	TranslationsSignUpFormSubmitEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Registrarse';
}

// Path: signUp.resendEmailVerification.dialog
class TranslationsSignUpResendEmailVerificationDialogEsCo {
	TranslationsSignUpResendEmailVerificationDialogEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Enlace de Verificación de Correo';
	String get cancel => 'Cancelar';
	late final TranslationsSignUpResendEmailVerificationDialogSubmitEsCo submit = TranslationsSignUpResendEmailVerificationDialogSubmitEsCo._(_root);
}

// Path: forgotPassword.form.email.error
class TranslationsForgotPasswordFormEmailErrorEsCo {
	TranslationsForgotPasswordFormEmailErrorEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa tu dirección de correo electrónico.';
	String get invalid => 'Por favor ingresa una dirección de correo electrónico válida.';
}

// Path: resetPassword.form.password.error
class TranslationsResetPasswordFormPasswordErrorEsCo {
	TranslationsResetPasswordFormPasswordErrorEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa una contraseña.';
	String get invalid => 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un carácter especial.';
}

// Path: signIn.form.email.error
class TranslationsSignInFormEmailErrorEsCo {
	TranslationsSignInFormEmailErrorEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa tu dirección de correo electrónico.';
	String get invalid => 'Por favor ingresa una dirección de correo electrónico válida.';
}

// Path: signIn.form.password.error
class TranslationsSignInFormPasswordErrorEsCo {
	TranslationsSignInFormPasswordErrorEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa una contraseña.';
}

// Path: signUp.form.email.error
class TranslationsSignUpFormEmailErrorEsCo {
	TranslationsSignUpFormEmailErrorEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa tu dirección de correo electrónico.';
	String get invalid => 'Por favor ingresa una dirección de correo electrónico válida.';
}

// Path: signUp.form.password.error
class TranslationsSignUpFormPasswordErrorEsCo {
	TranslationsSignUpFormPasswordErrorEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Por favor ingresa una contraseña.';
	String get invalid => 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un carácter especial.';
}

// Path: signUp.resendEmailVerification.dialog.submit
class TranslationsSignUpResendEmailVerificationDialogSubmitEsCo {
	TranslationsSignUpResendEmailVerificationDialogSubmitEsCo._(this._root);

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

