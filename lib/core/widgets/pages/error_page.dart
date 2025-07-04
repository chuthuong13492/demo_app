import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_app_bar.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.state,
    this.error,
  });

  final GoRouterState state;

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'Lỗi điều hướng',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                error ?? state.error.toString(),
                textAlign: TextAlign.center,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
