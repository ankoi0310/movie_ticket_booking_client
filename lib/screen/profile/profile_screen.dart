import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/component/profile_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  final AuthenticationService authenticationService = AuthenticationService.instance;

  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      margin: EdgeInsets.fromLTRB(
        isMobile ? 15 : SizeConfig.screenWidth / 10,
        isMobile ? 0 : 150,
        isMobile ? 15 : SizeConfig.screenWidth / 10,
        10,
      ),
      child: Stack(
        children: [
          SizedBox(
            width: SizeConfig.screenWidth * 0.8,
            height: SizeConfig.screenHeight * 0.6,
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _tabController.index = index;
                      _selectedIndex = index;
                    });
                  },
                  minWidth: SizeConfig.screenWidth * 0.1,
                  extended: true,
                  labelType: NavigationRailLabelType.none,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Thông tin cá nhân'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.history),
                      selectedIcon: Icon(Icons.history),
                      label: Text('Lịch sử đặt vé'),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.6,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, (1 - _animation.value) * MediaQuery.of(context).size.height),
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            ProfileInfo(),
                            Text('Lịch sử đặt vé'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // const ProfileCard(),
          // Container(
          //   alignment: Alignment.center,
          //   child: FutureBuilder(
          //     future: authenticationService.getAvatar(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         return ProfileAvatar(avatar: snapshot.data.toString());
          //       }
          //
          //       return const SizedBox();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      margin: const EdgeInsets.only(top: 70),
      padding: EdgeInsets.fromLTRB(10, Responsive.isMobile(context) ? 80 : 20, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const ProfileInfo(),
    );
  }
}
