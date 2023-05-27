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

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
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
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return FutureBuilder(
      future: userProvider.getProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserInfo userInfo = snapshot.data as UserInfo;
          return Container(
            width: SizeConfig.screenWidth * 0.8,
            height: SizeConfig.screenHeight * 0.8,
            margin: EdgeInsets.symmetric(
              horizontal: isMobile ? 0 : SizeConfig.screenWidth * 0.1,
              vertical: isMobile ? 0 : SizeConfig.screenHeight * 0.05,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: isMobile ? 1 : 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NavigationRail(
                        selectedIndex: _selectedIndex,
                        backgroundColor: Colors.white,
                        onDestinationSelected: (int index) {
                          setState(() {
                            _selectedIndex = index;
                            _tabController.animateTo(_selectedIndex);
                          });
                        },
                        selectedLabelTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        unselectedLabelTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        labelType: NavigationRailLabelType.none,
                        extended: isMobile ? false : true,
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(Icons.person),
                            selectedIcon: Icon(Icons.person),
                            label: Text('Thông tin cá nhân'),
                            indicatorColor: Colors.blue,
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.history),
                            selectedIcon: Icon(Icons.history),
                            label: Text('Lịch sử đặt vé'),
                            indicatorColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(30)),
                Flexible(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30),
                        vertical: getProportionateScreenHeight(30),
                      ),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ProfileInfo(userInfo: userInfo),
                          const Text('Lịch sử đặt vé'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const CustomLoadingScreen();
      },
    );
  }
}
