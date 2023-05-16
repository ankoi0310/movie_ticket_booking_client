import 'dart:math';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  bool isToggle = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    const double height = 40;
    const double collapsedWidth = 40;
    final double expandedWidth = SizeConfig.screenWidth / 3;

    return Container(
      height: height,
      width: expandedWidth,
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 375),
        height: height,
        width: isToggle ? collapsedWidth : expandedWidth,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: -10,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 375),
              top: 4,
              left: 4,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: isToggle ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3F7),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animationController.value * 2 * pi,
                        child: child,
                      );
                    },
                    child: const Icon(
                      Icons.mic,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 375),
              left: getProportionateScreenWidth(isToggle ? 0 : collapsedWidth),
              top: getProportionateScreenWidth(isToggle ? 0 : 4),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isToggle ? 0 : 1,
                child: SizedBox(
                  height: height,
                  width: expandedWidth - collapsedWidth * 2,
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    cursorRadius: const Radius.circular(10),
                    cursorWidth: 2,
                    cursorColor: Colors.black,
                    clipBehavior: Clip.antiAlias,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.only(bottom: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(height / 2),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(height / 2),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              child: IconButton(
                highlightColor: Colors.black.withOpacity(0.1),
                onPressed: () {
                  // setState(() {
                  //   if (isToggle) {
                  //     isToggle = false;
                  //     _animationController.reverse();
                  //   } else {
                  //     isToggle = true;
                  //     _animationController.forward();
                  //   }
                  // });
                  print('Search button pressed');
                },
                icon: SvgPicture.asset(
                  'icons/search.svg',
                  width: 18,
                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
