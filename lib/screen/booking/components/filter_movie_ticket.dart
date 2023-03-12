import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/information_ticket_selected_provider.dart';
import 'package:provider/provider.dart';

class FilterMovieTicket extends StatefulWidget {
  const FilterMovieTicket({Key? key}) : super(key: key);

  @override
  State<FilterMovieTicket> createState() => _FilterMovieTicketState();
}

class _FilterMovieTicketState extends State<FilterMovieTicket> {
  final _datePickerController = TextEditingController();

  int _selectedCinema = 0;
  int _selectedMovie = 0;
  DateTime? selectedDate;

  DropdownMenuItem buildItem(String text, int value) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: getProportionateScreenWidth(24),
        ),
      ),
    );
  }

  List<DropdownMenuItem> buildItemsBranch() {
    return [
      buildItem("Vui lòng chọn rạp", 0),
      buildItem("Galaxy Nguyễn Du", 1),
      buildItem("Galaxy Nguyễn Trãi", 2),
      buildItem("Galaxy Trung Chánh", 3),
      buildItem("Galaxy Trần Duy Hưng", 4),
      buildItem("Galaxy Nguyễn Chí Thanh", 5),
    ];
  }

  List<DropdownMenuItem> buildItemsMovie() {
    return [
      buildItem("Vui lòng chọn phim", 0),
      buildItem("Joker", 1),
      buildItem("Avengers: Endgame", 2),
      buildItem("Planet of the apes", 3),
      buildItem("The Lion King", 4),
      buildItem("The Dark Knight", 5),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final informationProvider =
        Provider.of<InformationTicketSelectedProvider>(context);

    return Container(
      width: SizeConfig.screenWidth,
      height: getProportionateScreenHeight(150),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropdownButton2(
            isExpanded: true,
            value: _selectedCinema,
            onChanged: (value) {
              setState(() {
                _selectedCinema = value as int;
              });
            },
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              width: getProportionateScreenWidth(400),
              height: getProportionateScreenHeight(80),
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
              icon: Icon(Icons.keyboard_arrow_up_rounded),
              iconSize: getProportionateScreenWidth(28),
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.grey,
              openMenuIcon: Icon(Icons.keyboard_arrow_down_rounded),
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 1,
              maxHeight: getProportionateScreenHeight(300),
              width: getProportionateScreenWidth(400),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(10),
                thickness: MaterialStateProperty.all(5),
                thumbColor: MaterialStateProperty.all(Colors.grey),
                trackColor: MaterialStateProperty.all(Colors.grey),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: getProportionateScreenHeight(75),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
            ),
            underline: Container(),
            items: buildItemsMovie(),
          ),
          DropdownButton2(
            isExpanded: true,
            value: _selectedMovie,
            onChanged: (value) {
              setState(() {
                _selectedMovie = value as int;
                informationProvider.setSelectedMovie(_selectedMovie);
              });
            },
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              width: getProportionateScreenWidth(400),
              height: getProportionateScreenHeight(80),
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
              icon: Icon(Icons.keyboard_arrow_up_rounded),
              iconSize: getProportionateScreenWidth(28),
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.grey,
              openMenuIcon: Icon(Icons.keyboard_arrow_down_rounded),
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 1,
              maxHeight: getProportionateScreenHeight(300),
              width: getProportionateScreenWidth(400),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(10),
                thickness: MaterialStateProperty.all(5),
                thumbColor: MaterialStateProperty.all(Colors.grey),
                trackColor: MaterialStateProperty.all(Colors.grey),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: getProportionateScreenHeight(75),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
            ),
            underline: Container(),
            items: buildItemsBranch(),
          ),
          // text field chose date
          Container(
            width: getProportionateScreenWidth(400),
            height: getProportionateScreenHeight(80),
            child: TextField(
              controller: _datePickerController,
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(24),
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: "Chọn ngày tháng năm",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(24),
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
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2024),
                ).then((value) {
                  setState(() {
                    selectedDate = value;
                  });
                  _datePickerController.text =
                      DateFormat("dd/MM/yyyy").format(value ?? DateTime.now());
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
