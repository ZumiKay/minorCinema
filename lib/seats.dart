import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minor_cinemaapp/Bloc/cinema_bloc.dart';

class SeatRow extends StatelessWidget {
  final int numSeats;
  final List<int> freeSeats;
  final String rowSeats;
  const SeatRow(
      {Key? key,
      required this.numSeats,
      required this.freeSeats,
      required this.rowSeats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cinemaBloc = BlocProvider.of<CinemaBloc>(context);
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(numSeats, (index) {
          if (freeSeats.contains(index + 1)) {
            return GestureDetector(
              onTap: () {
                cinemaBloc.add(OnSelectedSeatsEvent('$rowSeats${index + 1}'));
                
              },
              child: BlocBuilder<CinemaBloc, CinemaState>(
               
                builder: (_, state) => Image(
                    width: 50,
                    height: 50,
                    image: state.selectedSeats.contains('$rowSeats${index + 1}')
                        ? const AssetImage('images/chair.png')
                        : const AssetImage('images/chair2.png')),
              ),
            );
          }
          // return Image(width: 10 , height: 10 ,image: AssetImage('images/chair2.png'));
          return const Image(
              width: 50, height: 50, image: AssetImage('images/chair.png'));
        }),
      ),
    );
  }
}
