import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nhl_teams_app/styling.dart';
import '../bloc_handlers/team_bloc.dart';


/// This Widget shows the error in case the API to get teams failed

class TeamsError extends StatelessWidget {
  final String? errorMessage;
  const TeamsError({Key? key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage ??
                'Well this is embarrassing'"\n"
                    'Something went wrong!',
            textAlign: TextAlign.center,
            style: AppStyling().largeText.copyWith(
                color: Colors.red
            ),
          ),

          SizedBox(height: height*.04),

          /// This button retries to call the API again in case there issue was temporarily
          InkWell(
            onTap: (){
              BlocProvider.of<TeamBloc>(context).fetchTeams();
            },
            child: Container(
              width: width*.5,
              height: height*.06,
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
                'Retry',
                style: AppStyling().largeText.copyWith(
                    color: Colors.white
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
