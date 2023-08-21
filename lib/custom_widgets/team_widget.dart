import 'package:flutter/material.dart';
import 'package:nhl_teams_app/custom_widgets/image_widget.dart';
import 'package:nhl_teams_app/styling.dart';
import '../models/team_constructor.dart';
import 'team_details.dart';


/// This Widget return the teams when they are loaded in the home screen

class TeamWidget extends StatelessWidget {

  final List<NHLTeam> teams;
  const TeamWidget({
    Key? key,
    required this.teams
  }) : super(key: key);

  final double imageSize = 40;

  @override
  Widget build(BuildContext context) {

    /// Teams are shown in a GridView fashion with just a name and logo
    return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8
        ),
        itemCount: teams.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              /// This closes the keyboard in case the user clicks the team from search
              FocusManager.instance.primaryFocus?.unfocus();

              /// This method takes the user to see more info about the selected team
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => TeamDetails(
                  team: teams[index],
                )),
              );
            },
            child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1.5
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: teams[index].id.toString(),
                      child: ImageWidget(
                          imageUrl: teams[index].teamLogo,
                          imageSize: imageSize
                      )
                    ),
                    Text(
                      teams[index].teamName,
                      textAlign: TextAlign.center,
                      style: AppStyling().largeText,
                    )
                  ],
                )
            ),
          );
        }
    );
  }
}