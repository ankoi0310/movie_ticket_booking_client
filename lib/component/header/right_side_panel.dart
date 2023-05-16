import 'package:movie_ticket_booking_flutter_nlu/component/custom_button.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/custom_search_bar.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';

class RightSidePanel extends StatelessWidget {
  const RightSidePanel({
    Key? key,
    required this.isLoggedIn,
  }) : super(key: key);

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final AppRouterDelegate appRouterDelegate = AppRouterDelegate.instance;
    final AuthenticationProvider authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    const name = 'Dương Nguyễn Cẩm Nhung';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: isLoggedIn ? 6 : 5,
          child: const CustomSearchBar(),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              ...isLoggedIn
                  ? [
                      Expanded(
                        flex: 1,
                        child: Text.rich(
                          TextSpan(
                            text: 'Xin chào, ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenWidth(24),
                            ),
                            children: [
                              TextSpan(
                                text: name,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: getProportionateScreenWidth(24),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () => appRouterDelegate.setPathName(PublicRouteData.profile.name),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.logout, color: Colors.red),
                          onPressed: () async {
                            await authenticationProvider.logout();
                            await appRouterDelegate.setPathName(PublicRouteData.home.name);
                          },
                        ),
                      ),
                    ]
                  : [
                      SizedBox(width: getProportionateScreenWidth(20)),
                      HoverBuilder(
                        builder: (isHovering) {
                          return NormalButton(
                            label: 'Đăng nhập',
                            textColor: Colors.white,
                            backgroundColor: isHovering ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.secondary,
                            onTap: () => appRouterDelegate.setPathName(PublicRouteData.login.name),
                          );
                        },
                      ),
                    ],
            ],
          ),
        ),
      ],
    );
  }
}
