import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/data/providers/store_provider.dart';
import 'package:simpati_client/cores/models/screen_argument_model.dart';
import 'package:simpati_client/ui/pages/content_page.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';

class PelayananPage extends StatelessWidget {
  final storeProvider = Get.find<StoreProvider>();

  PelayananPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(title: 'Persyaratan Layanan'),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[300],
            thickness: 1.0,
            height: 0.5,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: storeProvider.serviceModel?.data.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var item = storeProvider.serviceModel!.data[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => ContentPage(),
                    arguments: ScreenArgument(
                      stringPayload: item.lookupDesc,
                      id: item.lookupValue,
                      link: 'service',
                    ));
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
                          item.lookupDesc,
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
