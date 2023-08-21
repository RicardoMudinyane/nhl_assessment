import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhl_teams_app/styling.dart';
import 'dart:math' as math;

import '../bloc_handlers/team_bloc.dart';

/// Our custom AppBAr widget

customAppBar(double height, BuildContext context){

  final teamBloc = BlocProvider.of<TeamBloc>(context);

  /// We start by changing the default size of the AppBar

  /// We use Stack to overlay the textForm field on the background Widget
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, height + 80 ),
    child: Stack(
      children: [
        /// A designed backGround to give the app a nice feel
        Container(
          color: AppStyling().nhlColor,
          height: height+75,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: -15,
                bottom: -20,
                child:
                Opacity(
                  opacity: .1,
                  child: Image.asset(
                    "assets/hockey_icon.png",
                    height: 175,
                    width: 175,
                  ),
                )
              ),
              Positioned(
                right: -50,
                bottom: -50,
                child:
                Transform.rotate(
                  angle: math.pi / 12.0,
                  child: Opacity(
                    opacity: .2,
                    child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/en/thumb/3/3a/05_NHL_Shield.svg/640px-05_NHL_Shield.svg.png",
                      height: 200,
                      width: 200,
                    ),
                  )
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                      "NHL Teams",
                      style: AppStyling().largeText.copyWith(
                          color: AppStyling().nhlTextColor
                      )
                  )
              ),
            ],
          )
        ),
        Container(),

        /// Just a textField with Icons for searching and filtering.
        Positioned(
          top: 100.0,
          left: 20.0,
          right: 20.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppStyling().nhlColor,
                width: 1.6
              )
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              primary: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: PopupMenuButton(
                icon: Icon(
                  Icons.filter_alt_rounded,
                  color: AppStyling().nhlColor,
                  size: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onSelected: (filterValue){ },
                itemBuilder: (context) => [
                  'All Teams',
                  'Eastern',
                  'Western',
                ].map((e){
                  return PopupMenuItem<String>(
                    value: e,
                    onTap: (){
                      BlocProvider.of<TeamBloc>(context).applyFilter(e);
                    },
                    child: Text(
                      e,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: Colors.black
                      ),
                    ),
                  );
                }).toList(),
              ),
              title: TextField(
                textAlignVertical: TextAlignVertical.center,
                  onChanged: (query) {
                    teamBloc.applySearch(query);
                  },
                  style: AppStyling().largeText,
                  decoration: InputDecoration(
                    hintText: "Search for a team...",
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.only(top: 0.0),
                    border: InputBorder.none,
                    hintStyle: AppStyling().hintText
                  )
              ),
              actions: [
                IconButton(
                  icon: Icon(
                      size: 20,
                      Icons.search,
                      color: AppStyling().nhlColor
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )
        )
      ],
    ),
  );
}