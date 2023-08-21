import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nhl_teams_app/home_screen.dart';

import 'bloc_handlers/roster_bloc.dart';
import 'bloc_handlers/team_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    /// Initialising the Blocs used in the App
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamBloc>(create: (_) => TeamBloc()..fetchTeams()),
        BlocProvider<RosterBloc>(create: (_) => RosterBloc()),
      ],
      child: const MaterialApp(
        title: 'NHL Teams',
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}