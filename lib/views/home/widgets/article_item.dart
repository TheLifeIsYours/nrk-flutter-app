import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/app_theme.dart';
import 'package:nrk/views/home/home_controller.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleItem extends GetView<HomeController> {
  final RssItem item;
  final int index;
  final bool hasRead;
  final Function(int index, RssItem item) onTap;
  final Function(int index, RssItem item) handleOnLongPress;
  final Function() onHandleReturn;

  const ArticleItem({
    Key? key,
    required this.item,
    required this.index,
    required this.hasRead,
    required this.onTap,
    required this.handleOnLongPress,
    required this.onHandleReturn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contents = item.media?.contents;
    late String? image = "";

    if (contents != null) {
      if (contents.isNotEmpty) {
        image = contents[0].url;
      }
    }

    return GetBuilder(
      init: HomeController(),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: () => onTap(index, item),
          onLongPress: () => handleOnLongPress(index, item),
          child: Card(
            child: Column(
              children: [
                if (controller.hasHighEmphasis(item))
                  const SizedBox(
                    width: double.infinity,
                    height: 16.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppTheme.pink,
                      ),
                    ),
                  ),
                Stack(
                  children: [
                    if (image != "")
                      GestureDetector(
                        onDoubleTap: () => interactiveImageView(image),
                        child: Hero(
                          tag: '$image$index',
                          child: CachedNetworkImage(
                            imageUrl: image!,
                            placeholder: (context, url) => const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      )
                    //TODO: implement video directly in the list
                    //else if (RegExp(r'http://www.nrk.no/video/.*').hasMatch(item.link ?? ""))
                    //  const Center()
                    else if (!controller.hasHighEmphasis(item))
                      const SizedBox(
                        width: double.infinity,
                        height: 16.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppTheme.blue,
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Transform.translate(
                        offset: const Offset(12.0, -16.0),
                        child: IconButton(
                          iconSize: 16.0,
                          onPressed: () => {
                            controller.newsService.toggleReadArticle(item),
                            controller.updateArticleList(),
                            controller.update()
                          },
                          icon: Icon(
                            hasRead ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                            color: hasRead ? Colors.white : Colors.white54,
                            shadows: const [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 3.0,
                                offset: Offset(0.5, 0.25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.title != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            item.title ?? '',
                            style: TextStyle(
                              fontSize: controller.newsService.settings.displayCompactList ? 18 : 20,
                            ),
                          ),
                        ),
                      if (item.description != null && !controller.newsService.settings.displayCompactList)
                        Text(
                          item.description ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            color: context.theme.textTheme.caption?.color,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void interactiveImageView(image) {
    Get.to(
      SafeArea(
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black87,
            child: Hero(
              tag: image,
              child: InteractiveViewer(
                maxScale: 5.0,
                child: CachedNetworkImage(
                  imageUrl: image!,
                  placeholder: (context, url) => const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 48.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
