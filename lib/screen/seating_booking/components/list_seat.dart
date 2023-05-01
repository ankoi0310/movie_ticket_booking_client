import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';

import '../../../config/size_config.dart';

class ListSeat extends StatefulWidget {
  const ListSeat({Key? key}) : super(key: key);

  @override
  State<ListSeat> createState() => _ListSeatState();
}

class _ListSeatState extends State<ListSeat> {
  List<String> listRowAlphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(listRowAlphabet.length, (index) {
                  return Container(
                    width: 35,
                    height: 35,
                    margin: const EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        listRowAlphabet[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(24),
                        ),
                      ),
                    ),
                  );
                })),
          ),
          Expanded(
            flex: 8,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(listRowAlphabet.length, (indexColumn) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(20, (indexRow) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: 5,
                          right: (indexRow == 3 || indexRow == 15) ? 30 : 5,
                          top: 5,
                          bottom: 5,
                        ),
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: HoverBuilder(
                              builder: (isHovering) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: isHovering
                                          ? Theme.of(context).primaryColor
                                          : const Color.fromRGBO(
                                              42, 60, 109, 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${listRowAlphabet[indexColumn]}${indexRow + 1}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              getProportionateScreenWidth(18),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      );
                    }),
                  );
                })),
          ),
          Expanded(
            flex: 1,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(listRowAlphabet.length, (index) {
                  return Container(
                    width: 35,
                    height: 35,
                    margin: const EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        listRowAlphabet[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(24),
                        ),
                      ),
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }
}
