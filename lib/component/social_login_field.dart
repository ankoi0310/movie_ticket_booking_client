import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class SocialLoginField extends StatefulWidget {
  const SocialLoginField({Key? key}) : super(key: key);

  @override
  State<SocialLoginField> createState() => _SocialLoginFieldState();
}

class _SocialLoginFieldState extends State<SocialLoginField> {
  late final AuthenticationProvider _authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
  late final CustomFlutterToast _toast = CustomFlutterToast();

  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '915458067606-b9t0ncrd28ugfahtp2qjbp6de2kbg233.apps.googleusercontent.com',
    signInOption: SignInOption.standard,
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
      'https://www.googleapis.com/auth/user.birthday.read',
      'https://www.googleapis.com/auth/user.gender.read',
    ],
  );

  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  Future<void> loginFacebook() async {
    final LoginResult result = await FacebookAuth.i.login(); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final LoginResult result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {
      _checking = false;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Login"),
        content: Text(result.status.toString()),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"))
        ],
      ),
    );
  }

  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  String prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  void _printCredentials() {
    print(
      prettyPrint(_accessToken!.toJson()),
    );
  }

  Future<void> loginGoogle() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        return;
      }
      final googleAuth = await account.authentication;
      final accessToken = googleAuth.accessToken;

      if (accessToken == null) return;
      HttpResponse response = await _authenticationProvider.loginGoogle(accessToken);

      if (response.success) {
        await _appRouterDelegate.setPathName(PublicRouteData.home.name);
      } else {
        _toast.showToast(
          success: response.success,
          message: response.message,
        );
      }

      // UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(OAuthProvider('google.com'));
      // print(userCredential.user!.email);
      // print(userCredential.additionalUserInfo!.profile);
      // print(userCredential.user!.providerData);
      // FirebaseAuth.instance.userChanges().listen((User? user) {
      //   if (user == null) {
      //     print('User is currently signed out!');
      //   } else {
      //     print('User is signed in!');
      //   }
      // });
    } catch (error) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    // _checkIfIsLogged();
    _toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlutterSocialButton(
          onTap: loginFacebook,
          mini: true,
          buttonType: ButtonType.facebook, // Button type for different type buttons
        ),
        FlutterSocialButton(
          onTap: loginGoogle,
          mini: true,
          buttonType: ButtonType.google, // Button type for different type buttons
        ),
      ],
    );
  }
}
