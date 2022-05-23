import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/models/screen_argument_model.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';

class SubmenuPage extends StatelessWidget {
  final arguments = Get.arguments as ScreenArgument;

  SubmenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var submenus = arguments.listPayload as List<ScreenArgument>;
    return Scaffold(
      appBar: defaultAppBar(title: arguments.stringPayload ?? 'Sub Menu'),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[300],
            thickness: 1.0,
            height: 0.5,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: arguments.listPayload?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '${submenus[index].link}',
                  arguments: ScreenArgument(
                    stringPayload: submenus[index].stringPayload,
                    id: submenus[index].id,
                    link: 'content'
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Icon(
                        //   Icons.link,
                        // ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          submenus[index].stringPayload ?? '-',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.navigate_next,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
