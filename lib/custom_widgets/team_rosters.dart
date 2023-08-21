import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_handlers/roster_bloc.dart';
import '../models/roster_constructor.dart';
import '../models/team_constructor.dart';
import '../styling.dart';

/// This button widget that gets the rosters
class TeamRosters extends StatelessWidget {
  final NHLTeam team;
  const TeamRosters({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final rosterBloc = BlocProvider.of<RosterBloc>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () async {
        /// This API for rosters is called when the button is clicked
        rosterBloc.fetchRoster(team.id);

        /// At the same time we pull up a bottom Modal where Modals will be shown
        showTeamRosters(context, height);
      },
      child: Container(
        height: height*.065,
        width: width*.95,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                AppStyling().nhlColor,
                Colors.grey[800]!
              ]
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
            'See Rosters',
            style: AppStyling().largeText.copyWith(
                color: Colors.white
            )
        ),
      ),
    );
  }

  /// This returns the list of all rosters
  /// States were not used in the Roster Bloc because it was not part of the scope
  /// And time was very limited


  void showTeamRosters(context, height){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      builder: (BuildContext context) {
        return  BlocBuilder<RosterBloc, List<Roster>>(
          builder: (context, rosters) {
            return FractionallySizedBox(
              heightFactor: 0.95,
              child: Container(
                  height: height,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15)
                      )
                  ),
                  child:  rosters.isEmpty ?
                  Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: height*.02),
                          Text(
                            'Getting Rosters...',
                            style: AppStyling().largeText,
                          )
                        ],
                      )
                  ):
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15
                        ),
                        child: Text(
                          'Team Rosters',
                          style: AppStyling().largeText.copyWith(
                              fontSize: 14
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        color: AppStyling().nhlColor,
                      ),
                      SizedBox(height: height*.02),
                      Expanded(
                          child: ListView.builder(
                              itemCount: rosters.length,
                              itemBuilder: (context, index){
                                return ListTile(
                                  title: Text(
                                    rosters[index].playerName,
                                    style: AppStyling().largeText,
                                  ),
                                  subtitle: Text(
                                    rosters[index].position,
                                    style: AppStyling().smallText,
                                  ),
                                  trailing: Text(
                                    rosters[index].jerseyNumber,
                                    style: AppStyling().largeText,
                                  ),
                                );
                              }
                          )
                      )
                    ],
                  )
              ),
            );
          },
        );
      },
    );
  }
}
