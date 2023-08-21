import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhl_teams_app/custom_widgets/team_rosters.dart';
import 'package:nhl_teams_app/models/team_constructor.dart';
import 'package:nhl_teams_app/styling.dart';
import 'package:url_launcher/url_launcher.dart';

import 'image_widget.dart';

/// All the extra details about the team are here

class TeamDetails extends StatelessWidget {
  final NHLTeam team;
  const TeamDetails({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    /// A map to run through for extra information
    Map<String, dynamic> teamInfo = {
      'Short name' : team.teamShortName,
      'Location' : team.teamLocation,
      'Venue' : team.teamVenue,
      'Division' : team.teamDivision,
      'Conference' : team.teamConference,
      'Franchise' : team.teamFranchise,
      'Official Site' : team.teamWebsite,
    };

    return Scaffold(
      backgroundColor: AppStyling().backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.chevron_left_rounded),
                color: AppStyling().nhlColor,
                iconSize: 20,
              ),
              backgroundColor: AppStyling().backgroundColor,
              title: Text(
                team.teamName,
                style: AppStyling().largeText,
              ),
          )
      ),
      body: Container(
        width: width,
        height: height,
        alignment: Alignment.topCenter,
        color: AppStyling().backgroundColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

              /// A card-like Container that shows quick information for a team
              /// This is the team's name, abbreviation, Link to website and year
              Container(
                  width: width*.96,
                  height: height*.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                          leading: Hero(
                              tag: team.id.toString(),
                              child: ImageWidget(
                                  imageUrl: team.teamLogo,
                                  imageSize: 100
                              )
                          ),
                          title: Text(
                            team.teamName,
                            style: AppStyling().largeText,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            team.teamAbb,
                            style: AppStyling().smallText,
                          ),
                          trailing: InkWell(
                            onTap: () => launchWebsite(team.teamWebsite),
                            child: const Icon(
                              Icons.link_rounded,
                              size: 20,
                              color: Colors.blue,
                            ),
                          )
                      ),

                      Divider(
                        height: 2.5,
                        color: Colors.grey[200],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Year Established: ",
                              style: AppStyling().smallText,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              team.teamYear,
                              style: AppStyling().largeText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              ),
              const SizedBox(height: 20),


              SizedBox(
                height: height*.04,
                child: Text(
                  'More information',
                  textAlign: TextAlign.start,
                  style: AppStyling().largeText,
                ),
              ),

              /// A column showing all the other team information
              Container(
                color: Colors.transparent,
                width: width,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    children: moreInformation(teamInfo)
                ),
              ),

              const SizedBox(height: 20),

              /// A button in case the user wants to see all the rosters
              TeamRosters(team: team)

            ],
          ),
        )
      ),
    );
  }

  /// This method returns a list of more information
  List<Widget> moreInformation(teamInfo){
    List<Widget> widgetList = [];
    teamInfo.forEach((k, info) {
      widgetList.add(Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              k,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w400
              ),
            ),
            Text(
              info,
              style: AppStyling().largeText.copyWith(
                color: k == 'Official Site'?
                Colors.lightBlue :
                Colors.grey[800],
              ),
            ),
          ],
        ),
      ));
    });
    return widgetList;
  }

  /// This method launches the team's website
  launchWebsite(String teamWeb)  async {
    if (await canLaunchUrl(Uri.parse(teamWeb))) {
      await launchUrl(Uri.parse(teamWeb));
    }
    else {
      throw 'Could not launch $teamWeb';
    }
  }
}