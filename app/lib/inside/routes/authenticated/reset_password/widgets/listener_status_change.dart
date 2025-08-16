import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../../shared/utils/snackbar_utils.dart';
import '../../../../blocs/reset_password/bloc.dart';
import '../../../../blocs/reset_password/state.dart';
import '../../../../i18n/translations.g.dart';
import '../../../router.dart';

class ResetPassword_Listener_StatusChange extends StatelessWidget {
  const ResetPassword_Listener_StatusChange({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPassword_Bloc, ResetPassword_State>(
      child: child,
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case ResetPassword_Status.resetPasswordError:
            {
              if (state.errorMessage != null) {
                SnackbarUtils.showFAlertSnackbar(
                  context,
                  text: state.errorMessage!,
                  alertStyle: FAlertStyle.destructive(),
                );
              }
            }
          case ResetPassword_Status.resetPasswordSuccess:
            {
              context.router.navigate(const Home_Route());
              SnackbarUtils.showFAlertSnackbar(
                context,
                text: context.t.resetPassword.form.submit.success,
              );
            }
          case ResetPassword_Status.sendResetPasswordLinkInProgress:
          case ResetPassword_Status.sendResetPasswordLinkError:
          case ResetPassword_Status.sendResetPasswordLinkSuccess:
          case ResetPassword_Status.resendResetPasswordLinkInProgress:
          case ResetPassword_Status.resendResetPasswordLinkError:
          case ResetPassword_Status.resendResetPasswordLinkSuccess:
          case ResetPassword_Status.resetPasswordInProgress:
          case ResetPassword_Status.idle:
            break;
        }
      },
    );
  }
}
