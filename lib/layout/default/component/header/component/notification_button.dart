import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/notice.dart';
import 'package:movie_ticket_booking_flutter_nlu/utilities/StringUtil.dart';

class NotificationButton extends StatefulWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  List<Notice> notices = [];
  late int numNoticeNotRead = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final noticeProvider = Provider.of<NoticeProvider>(context, listen: false);
    final authService = AuthenticationService.instance;
    authService.getCurrentUserEmail().then((value) => noticeProvider.getNoticeSearch(value).then((value) {
          HttpResponse response = value;
          if (response.success) {
            setState(() {
              notices = (value.data as List<dynamic>).map((e) => Notice.fromJson(e)).toList();
              numNoticeNotRead = notices.where((element) => !element.isRead).length;
            });
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    final noticeProvider = Provider.of<NoticeProvider>(context, listen: false);
    final authService = AuthenticationService.instance;
    return Stack(
      children: [
        InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            authService.getCurrentUserEmail().then((value) => noticeProvider.readAllNotice(value).then((value) {
                  HttpResponse response = value;
                  if (response.success) {
                    setState(() {
                      numNoticeNotRead = 0;
                    });
                  }
                }));
            showMenu(
              context: context,
              constraints: const BoxConstraints(minWidth: 400, maxHeight: 500),
              position: const RelativeRect.fromLTRB(121, 62, 120, 0),
              items: [
                PopupMenuItem(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: notices.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              notices.length,
                              (index) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.notifications),
                                    SizedBox(width: getProportionateScreenWidth(10)),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(StringUtil.changeNoticeType(notices[index].type),
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            const SizedBox(width: 5),
                                            !notices[index].isRead
                                                ? const Text('*',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14,
                                                    ))
                                                : Container(),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          notices[index].description,
                                          maxLines: 2,
                                          softWrap: true,
                                          textDirection: TextDirection.ltr,
                                          overflow: TextOverflow.ellipsis,
                                          textWidthBasis: TextWidthBasis.parent,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            );
          },
          child: Container(
            margin: EdgeInsets.all(getProportionateScreenWidth(3)),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: accentColor,
              child: Icon(Icons.notifications, color: Colors.black),
            ),
          ),
        ),
        numNoticeNotRead > 0 ? Positioned(
                right: 0,
                top: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      numNoticeNotRead.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ):  Positioned(
          right: 0,
          top: 0,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
            ),
          ),
        ),
      ],
    );
  }
}
