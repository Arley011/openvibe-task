import 'package:flutter/material.dart';
import 'package:openvibe_app/common/extensions/date_time_extension.dart';
import 'package:openvibe_app/domain/models/message.dart';

class MessageDetailScreen extends StatelessWidget {
  const MessageDetailScreen({
    super.key,
    required this.message,
  });

  // TODO implement retrieving from cache
  static PageRoute route(Message message) {
    return MaterialPageRoute(
      builder: (_) => MessageDetailScreen(message: message),
    );
  }

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(message.icon, style: const TextStyle(fontSize: 32)),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.nickname,
                          style: theme.textTheme.titleSmall,
                        ),
                        Row(
                          children: [
                            Text(
                              message.createdAt.formattedTime24H,
                              style: theme.textTheme.labelMedium,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                Icons.circle,
                                size: 4,
                                color: theme.textTheme.labelMedium?.color,
                              ),
                            ),
                            Text(
                              message.createdAt.formattedDate,
                              style: theme.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SafeArea(
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    message.message,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const sample =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Viverra justo nec ultrices dui sapien eget mi proin. Tortor consequat id porta nibh venenatis cras sed felis eget. Amet mattis vulputate enim nulla aliquet porttitor lacus. Consequat nisl vel pretium lectus. Diam ut venenatis tellus in metus. Donec massa sapien faucibus et. Et leo duis ut diam quam nulla porttitor massa id. Vitae tempus quam pellentesque nec nam aliquam sem et. Pellentesque id nibh tortor id aliquet lectus proin nibh nisl. Integer eget aliquet nibh praesent tristique magna sit amet. Duis ut diam quam nulla porttitor massa. Non quam lacus suspendisse faucibus interdum posuere. Egestas diam in arcu cursus. Bibendum at varius vel pharetra vel turpis nunc eget. Purus in massa tempor nec feugiat nisl. Sed sed risus pretium quam. Pretium quam vulputate dignissim suspendisse. Purus semper eget duis at tellus at urna condimentum mattis. Porta lorem mollis aliquam ut porttitor leo. Porttitor leo a diam sollicitudin tempor. Dignissim cras tincidunt lobortis feugiat. Egestas tellus rutrum tellus pellentesque eu tincidunt tortor. Tristique et egestas quis ipsum suspendisse ultrices gravida dictum. Mauris nunc congue nisi vitae suscipit tellus. Bibendum arcu vitae elementum curabitur vitae. Justo laoreet sit amet cursus sit amet. Tortor vitae purus faucibus ornare suspendisse sed. Nulla facilisi morbi tempus iaculis urna id. Sit amet aliquam id diam. Nisi vitae suscipit tellus mauris a diam maecenas sed enim. Augue interdum velit euismod in pellentesque massa. Lacinia at quis risus sed vulputate odio. Sit amet porttitor eget dolor morbi non arcu risus quis. Sed elementum tempus egestas sed. Ut tortor pretium viverra suspendisse potenti nullam. In tellus integer feugiat scelerisque varius. Diam donec adipiscing tristique risus nec. Fusce id velit ut tortor pretium viverra. Faucibus purus in massa tempor. Tincidunt eget nullam non nisi. Nec nam aliquam sem et tortor consequat id porta. Diam in arcu cursus euismod quis. Ultricies tristique nulla aliquet enim tortor at. Fusce id velit ut tortor pretium viverra. Dictumst vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt. Sagittis nisl rhoncus mattis rhoncus. Augue ut lectus arcu bibendum. Nunc faucibus a pellentesque sit amet. Justo laoreet sit amet cursus sit amet dictum sit.';
}
