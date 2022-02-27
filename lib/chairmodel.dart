class Chairs {
  final String rowSeats;
  final int seats;
  final List<int> freeseats;

  Chairs(
      {required this.rowSeats,required this.seats , required this.freeseats});
  static List<Chairs> listChair = [
    Chairs(rowSeats: 'A' , seats: 3 , freeseats: [1,3]),
    Chairs(rowSeats: 'B', seats: 5, freeseats: [1,2,3,4,5]),
    Chairs(rowSeats: 'C', seats: 5, freeseats: [1,2,3,4,5]),
    Chairs(rowSeats: 'D', seats: 4, freeseats: [1,2,3,4]),
    Chairs(rowSeats: 'E', seats: 6, freeseats: [1,2,3,4,5,6]),
    Chairs(rowSeats: 'F', seats: 6, freeseats: [1,2,3,4,5,6])
  ];
}
