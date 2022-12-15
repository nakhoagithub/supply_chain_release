import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/app/blocs/app_bloc.dart';
import 'package:supply_chain/blocs/app/blocs/app_event.dart';
import 'package:supply_chain/blocs/app/blocs/app_state.dart';
import 'package:supply_chain/blocs/main/views/main_page.dart';

import '../../../enum.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const App());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppBloc()..add(AppInitialEvent());
      },
      child: const AppStart(),
    );
  }
}

class AppStart extends StatelessWidget {
  const AppStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffbae5f4),
      body: SafeArea(
          child: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          switch (state.appStatus) {
            case AppStatus.initialize:
              break;
            case AppStatus.authentication:
              Navigator.of(context)
                  .pushAndRemoveUntil(MainPage.route(), (route) => false);
              break;
            case AppStatus.unauthentication:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
              break;
          }
        },
        child: Column(
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 1,
              child: Center(
                child: Image.asset(
                  "assets/images/suppychain.png",
                  height: 200,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: const [
                  Text(
                    "Welcome to Supply Chain",
                    style: TextStyle(fontSize: 24),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Version 1.0",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
