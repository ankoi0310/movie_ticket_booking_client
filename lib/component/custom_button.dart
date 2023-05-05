import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class LogoButton extends StatelessWidget {
  const LogoButton({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    final appRouterDelegate = AppRouterDelegate.instance;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(3)),
      child: IconButton(
        hoverColor: Colors.transparent,
        icon: Image.asset(path, width: getProportionateScreenWidth(150)),
        onPressed: () => appRouterDelegate.setPathName(PublicRouteData.home.name),
      ),
    );
  }
}

class ColorCustomIconButton extends StatelessWidget {
  const ColorCustomIconButton({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: IconButton(
        hoverColor: Colors.transparent,
        icon: SvgPicture.asset(
          path,
          width: 20,
        ),
        onPressed: () {},
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: IconButton(
        icon: SvgPicture.asset(
          path,
          width: 15,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        onPressed: () => {},
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: getProportionateScreenWidth(28),
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
        ),
      ),
      onPressed: () {},
    );
  }
}

class IconLabelButton extends StatelessWidget {
  const IconLabelButton({
    Key? key,
    required this.label,
    required this.path,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final String path;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(path, width: 20, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      label: Text(label.toUpperCase(), style: const TextStyle(color: Colors.white)),
    );
  }
}

class NormalButton extends StatelessWidget {
  const NormalButton({
    Key? key,
    required this.label,
    required this.textColor,
    this.path = '',
    this.iconColor = Colors.white,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final Color textColor;
  final String path;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(3)),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(25),
          vertical: getProportionateScreenWidth(10),
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (path.isNotEmpty) ...[
              Image.asset(path, color: iconColor, width: getProportionateScreenWidth(15)),
              SizedBox(width: getProportionateScreenWidth(5)),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(28),
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatefulWidget {
  const MenuButton({
    Key? key,
    required this.label,
    required this.color,
    required this.hoverColor,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final Color color;
  final Color hoverColor;
  final VoidCallback onPressed;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: TextButton(
        onPressed: widget.onPressed,
        onHover: (value) {
          setState(() {
            _isHover = value;
          });
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _isHover ? widget.hoverColor : widget.color,
            fontSize: getProportionateScreenWidth(32),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
