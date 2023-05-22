import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/branch/branch_search.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/movie/movie_search.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/branch.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/branch_provider.dart';

class FilterMovieTicket extends StatefulWidget {
  final String? slug;

  const FilterMovieTicket({Key? key, required this.slug}) : super(key: key);

  @override
  State<FilterMovieTicket> createState() => _FilterMovieTicketState();
}

class _FilterMovieTicketState extends State<FilterMovieTicket> {
  final _datePickerController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(DateTime.now()));

  late LoadingProvider _loadingProvider = Provider.of<LoadingProvider>(context);
  bool isCallApiMovie = false;
  bool isCallApiBranch = false;

  Branch? _selectedBranch;
  Movie? _selectedMovie;
  DateTime? selectedDate = DateTime.now();

  DropdownMenuItem<Object> buildItem(String text, Object? value) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: getProportionateScreenWidth(20),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final informationProvider = Provider.of<InformationTicketSelectedProvider>(context);
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final branchProvider = Provider.of<BranchProvider>(context, listen: false);

    return Container(
      width: SizeConfig.screenWidth,
      height: getProportionateScreenHeight(150),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder(
              future: isCallApiMovie ? null : movieProvider.getMoviesSearch(MovieSearch(movieState: MovieState.nowShowing)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  HttpResponse response = snapshot.data as HttpResponse;
                  List<Movie> movies = List<Movie>.from(response.data.map((movie) => Movie.fromJson(movie)));
                  List<DropdownMenuItem> items = [];
                  items.add(buildItem("Tất cả phim", null));
                  items.addAll(movies.map((movie) => buildItem(movie.name, movie)).toList());
                  if (widget.slug != null) {
                    _selectedMovie = items.firstWhere((element) => element.value?.slug == widget.slug).value as Movie?;
                    Future.delayed(Duration.zero, () {
                      informationProvider.setSelectedMovie(_selectedMovie);
                    });
                  }
                  isCallApiMovie = true;

                  return widget.slug == null
                      ? DropdownButton2(
                          isExpanded: true,
                          value: _selectedMovie,
                          onChanged: (value) {
                            setState(() {
                              _selectedMovie = value;
                              informationProvider.setSelectedMovie(_selectedMovie);
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                            ),
                            width: getProportionateScreenWidth(350),
                            height: getProportionateScreenHeight(60),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          iconStyleData: IconStyleData(
                            icon: const Icon(Icons.keyboard_arrow_up_rounded),
                            iconSize: getProportionateScreenWidth(28),
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.grey,
                            openMenuIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            elevation: 1,
                            maxHeight: getProportionateScreenHeight(300),
                            width: getProportionateScreenWidth(350),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(10),
                              thickness: MaterialStateProperty.all(5),
                              thumbColor: MaterialStateProperty.all(Colors.grey),
                              trackColor: MaterialStateProperty.all(Colors.grey),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height: getProportionateScreenHeight(60),
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                            ),
                          ),
                          underline: Container(),
                          items: items,
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                          ),
                          width: getProportionateScreenWidth(350),
                          height: getProportionateScreenHeight(60),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _selectedMovie!.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenWidth(20),
                              ),
                            ),
                          ),
                        );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          FutureBuilder(
            future: isCallApiBranch ? null : branchProvider.searchBranch(BranchSearch()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                HttpResponse response = snapshot.data as HttpResponse;
                List<Branch> branches = List<Branch>.from(response.data.map((branch) => Branch.fromJson(branch)));
                List<DropdownMenuItem> items = [];
                items.add(buildItem("Tất cả rạp", null));
                items.addAll(branches.map((branch) => buildItem(branch.name, branch)).toList());
                // Future.delayed(Duration.zero, () {
                //   isCallApiBranch = true;
                // });
                isCallApiBranch = true;

                return DropdownButton2(
                  isExpanded: true,
                  value: _selectedBranch,
                  onChanged: (value) {
                    setState(() {
                      _selectedBranch = value as Branch?;
                      informationProvider.setSelectedBranch(_selectedBranch);
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    width: getProportionateScreenWidth(350),
                    height: getProportionateScreenHeight(60),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  iconStyleData: IconStyleData(
                    icon: const Icon(Icons.keyboard_arrow_up_rounded),
                    iconSize: getProportionateScreenWidth(28),
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                    openMenuIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    elevation: 1,
                    maxHeight: getProportionateScreenHeight(300),
                    width: getProportionateScreenWidth(350),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(10),
                      thickness: MaterialStateProperty.all(5),
                      thumbColor: MaterialStateProperty.all(Colors.grey),
                      trackColor: MaterialStateProperty.all(Colors.grey),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    height: getProportionateScreenHeight(60),
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                  ),
                  underline: Container(),
                  items: items,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          // text field chose date
          Container(
            color: Colors.white,
            width: getProportionateScreenWidth(350),
            height: getProportionateScreenHeight(60),
            child: TextField(
              controller: _datePickerController,
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(20),
                height: 1.5,
              ),
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Chọn ngày tháng năm",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(30),
                  vertical: getProportionateScreenHeight(12),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(20),
                  height: 1.5,
                ),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                  size: getProportionateScreenWidth(22),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: selectedDate!,
                  currentDate: selectedDate!,
                  firstDate: DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
                  lastDate: DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day + 7),
                ).then((value) {
                  setState(() {
                    selectedDate = value;
                    informationProvider.setSelectedDate(selectedDate!);
                  });
                  _datePickerController.text = DateFormat('dd-MM-yyyy').format(value ?? DateTime.now());
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
