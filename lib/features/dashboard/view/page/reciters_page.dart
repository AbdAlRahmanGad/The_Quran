import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quran/features/dashboard/controller/bloc/dashboard_bloc.dart';

import '../../../auth/model/reciter.dart';
import '../../../auth/model/user_details.dart';
import '../../controller/database_helper.dart';

class RecitersPage extends StatefulWidget {
  final UserDetails userDetails;
  final List<Reciter> reciters;
  const RecitersPage({
    super.key,
    required this.userDetails,
    required this.reciters,
  });

  @override
  RecitersPageState createState() => RecitersPageState(userDetails, reciters);
}

class RecitersPageState extends State<RecitersPage> {
  final UserDetails userDetails;
  final List<Reciter> reciters;
  RecitersPageState(this.userDetails, this.reciters);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DashboardBloc dashboardBloc = context.read<DashboardBloc>();
    dashboardBloc.add(GetUserDetails());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reciters'),
      ),
      // get all reciters from database repo
      body: ListView.builder(
        itemCount: reciters.length,
        itemBuilder: (context, index) {
          Reciter reciter = reciters[index];
          bool isFavourite = userDetails.favouriteReciters
              .any((favReciter) => favReciter.reciterId == reciter.reciterId);
          return ListTile(
            title: Text(reciter.reciterName),
            subtitle: Text(reciter.reciterStyle),
            trailing: IconButton(
              icon: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () async {
                if (isFavourite) {
                  await DatabaseHelper.instance.deleteFavouriteReciter(
                      userDetails.userId, reciter.reciterId);
                  setState(() {
                    userDetails.favouriteReciters.removeWhere((favReciter) =>
                        favReciter.reciterId == reciter.reciterId);
                  });
                } else {
                  await DatabaseHelper.instance.insertFavouriteReciter(
                      userDetails.userId, reciter.reciterId);
                  setState(() {
                    userDetails.favouriteReciters.add(reciter);
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }
}
