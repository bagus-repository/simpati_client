import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/configs/configs.dart';
import 'package:simpati_client/cores/controllers/efilling_controller.dart';
import 'package:simpati_client/cores/utils/format_utils.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';

class RiwayatServicePage extends StatelessWidget {
  RiwayatServicePage({Key? key}) : super(key: key);
  final _controller = Get.put(EfillingController());

  @override
  Widget build(BuildContext context) {
    _controller.loadRiwayat();
    return Scaffold(
      appBar: defaultAppBar(title: 'Riwayat Pelayanan'),
      body: Obx(() => RefreshIndicator(
          onRefresh: () => _controller.loadRiwayat(),
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[300],
              thickness: 1.0,
              height: 0.5,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _controller.riwayatList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var item = _controller.riwayatList[index];
              return GestureDetector(
                onTap: () {
                  
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ConfigColor.primaryColor,
                      width: 3.0,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '#${item.serviceNo}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            FormatUtil.formatIdDate(FormatDateType.common, item.createdDate),
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Kategori : ${item.fillingType.lookupDesc}',
                        style: const TextStyle(
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status :',
                            style: const TextStyle(
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: item.sts == 0 ? ConfigColor.primaryColor: item.sts == 1 ? ConfigColor.successColor:ConfigColor.errorColor,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(FormatUtil.getRiwayatStatus(item.sts), style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                      Text(
                        'Approval Oleh : ${item.approvalBy?.name ?? '-'}',
                        style: const TextStyle(
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
