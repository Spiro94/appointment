import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/feed/bloc.dart';
import '../../../blocs/feed/state.dart';
import 'widgets/content_widget.dart';

/// Page for displaying upcoming appointments feed
@RoutePage()
class Feed_Page extends StatelessWidget implements AutoRouteWrapper {
  const Feed_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feed',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<Feed_Bloc, Feed_State>(
          builder: (context, state) {
            return Feed_ContentWidget(state: state);
          },
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => Feed_Bloc(), child: this);
  }
}
