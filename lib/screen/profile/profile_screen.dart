import 'package:movie_ticket_booking_flutter_nlu/component/custom_loading_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/user/user_info.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/user_provider.dart';
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
    final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(
                          child: Text(
                            'Thông tin',
                            style: TextStyle(
                              color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Lịch sử',
                            style: TextStyle(
                              color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.7,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ProfileInfo(userInfo: userInfo),
                        const Text('Lịch sử đặt vé'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const CustomLoadingScreen();
        });
  }
}
