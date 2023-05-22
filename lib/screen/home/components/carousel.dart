import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:movie_ticket_booking_flutter_nlu/addon/buildin_transformers.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';

class Carousel extends StatefulWidget {
  final List<Movie> movies;
  final Map<String, Uint8List> images;

  const Carousel({
    Key? key,
    required this.movies,
    required this.images,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> with TickerProviderStateMixin {
  final IndexController _indexController = IndexController();
  late int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: TransformerPageView(
        controller: _indexController,
        index: _currentPageIndex,
        itemCount: widget.movies.length,
        loop: true,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index!;
          });
        },
        transformer: ScaleAndFadeTransformer(),
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.memory(widget.images[movie.imageHorizontal]!).image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: SizeConfig.screenHeight * 0.6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              buildPreviousButton(context),
              builNextButton(context),
            ],
          );
        },
      ),
    );
  }

  Positioned builNextButton(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      child: HoverBuilder(
        builder: (isHovering) {
          return Container(
            decoration: BoxDecoration(
              gradient: isHovering
                  ? LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        // darker on the right
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    )
                  : null,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _currentPageIndex = (_currentPageIndex + 1) % widget.movies.length;
                });
                _indexController.move(_currentPageIndex);
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: isHovering ? accentColor : Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        },
      ),
    );
  }

  Positioned buildPreviousButton(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      child: HoverBuilder(builder: (isHovering) {
        return Container(
          decoration: BoxDecoration(
            gradient: isHovering
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      // darker on the left
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  )
                : null,
          ),
          child: IconButton(
            onPressed: () {
              setState(() {
                _currentPageIndex = (_currentPageIndex - 1) % widget.movies.length;
              });
              _indexController.move(_currentPageIndex);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: isHovering ? accentColor : Theme.of(context).colorScheme.secondary,
            ),
          ),
        );
      }),
    );
  }
}
