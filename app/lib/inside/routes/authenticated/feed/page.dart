import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../blocs/feed/bloc.dart';
import '../../../blocs/feed/event.dart';
import '../../../blocs/feed/state.dart';
import 'widgets/content_widget.dart';

/// Page for displaying upcoming appointments feed
@RoutePage()
class Feed_Page extends StatelessWidget {
  const Feed_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Feed_Bloc, Feed_State>(
      builder: (context, state) {
        return FScaffold(
          header: FHeader(
            title: Text(
              state.showPastAppointments ? 'Citas Pasadas' : 'Próximas Citas',
            ),
            suffixes: [
              FButton(
                style: FButtonStyle.outline(),
                onPress: () {
                  context.read<Feed_Bloc>().add(
                    const Feed_Event_TogglePastAppointments(),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      state.showPastAppointments
                          ? Icons.schedule
                          : Icons.history,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(state.showPastAppointments ? 'Futuras' : 'Pasadas'),
                  ],
                ),
              ),
            ],
          ),
          child: Feed_ContentWidget(state: state),
        );
      },
    );
  }
}
