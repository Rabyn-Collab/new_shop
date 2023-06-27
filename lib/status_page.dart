import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/provider/auth_provider.dart';
import 'package:flutternew/view/home_page.dart';
import 'package:flutternew/view/login_page.dart';





class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);

    return Scaffold(
              body: auth.user == null ? LoginPage(): HomePage()
          );

  }
}
