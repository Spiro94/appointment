import 'package:flutter/material.dart';

class FamilySetup_LoadingWidget extends StatelessWidget {
  const FamilySetup_LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator.adaptive(),
          SizedBox(height: 16),
          Text('Cargando...'),
        ],
      ),
    );
  }
}
