import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nhl_teams_app/custom_widgets/team_widget.dart';
import 'bloc_handlers/team_bloc.dart';
import 'bloc_handlers/team_state.dart';
import 'custom_widgets/app_bar.dart';
import 'custom_widgets/team_loading.dart';
import 'custom_widgets/teams_error.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      /// A custom AppBar that includes a search bar and a filter Icon.
      /// The AppBar also includes an image
      appBar: customAppBar(
          AppBar().preferredSize.height,
          context
      ),

      /// The HomeScreen contains a BlocBuilder that checks what State our app is in
      body: BlocBuilder<TeamBloc, TeamState>(
          builder: (context, state) {

            /// The states below should be self-explanatory
            if (state is TeamLoading)  {
              return const TeamsLoading();
            }
            else if (state is TeamLoaded){
              return TeamWidget(teams: state.teams);
            }
            else if (state is TeamError) {
              return TeamsError(errorMessage: state.message);
            }
            return const TeamsError();
          }
      ),
    );
  }
}