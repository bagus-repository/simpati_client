import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/configs/configs.dart';
import 'package:simpati_client/cores/controllers/efilling_controller.dart';
import 'package:simpati_client/cores/data/constants.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';

class EfillingPage extends StatelessWidget {
  EfillingPage({Key? key}) : super(key: key);
  final _efillingCtrl = Get.put(EfillingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(title: 'Pilih Layanan'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            dividerDefault(),
            defaultTxtField(
              label: 'Pilih Kategori *',
              controller: _efillingCtrl.txtServiceCtrl,
              focusNode: AlwaysDisabledFocusNode(),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return SimpleDialog(
                      children: _efillingCtrl.services
                          .map((element) => SimpleDialogOption(
                                onPressed: () {
                                  _efillingCtrl.txtServiceCtrl.text =
                                      element.lookupDesc;
                                  _efillingCtrl.serviceCode =
                                      element.lookupValue;
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    element.lookupDesc,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    );
                  },
                );
              },
            ),
            dividerDefault(),
            Container(
              width: double.infinity,
              height: 60.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: ConfigColor.primaryColor,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(ConstantData.IMAGES_FOLDER + 'upload-icon.png',
                      width: 50.0),
                  dividerColHeading(),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload file dokumen',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Format : PDF,RAR,ZIP, Maks. 10MB',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      )),
                  Obx(
                    () => Visibility(
                      visible: _efillingCtrl.filePath.value.isNotEmpty,
                      child: FaIcon(
                        FontAwesomeIcons.solidCheckCircle,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            dividerDefault(),
            Obx(() => Visibility(
                visible: _efillingCtrl.filePath.value.isNotEmpty,
                child: Text(
                    'Berkas yang akan diupload: ${_efillingCtrl.fileName.value}'))),
            dividerDefault(),
            Obx(() => Visibility(
                visible: !_efillingCtrl.isPageSubmitting.value,
                child: buttonSubmitDefault(
                    onPressed: () => _efillingCtrl.pickFile(),
                    text: 'Pilih berkas'))),
            dividerHeading(),
            Obx(
              () => buttonCompact(
                onPressed: () => _efillingCtrl.submitFilling(),
                text: 'Ajukan',
                iconData: FontAwesomeIcons.chevronCircleRight,
                buttonColor: ConfigColor.primaryColor,
                isSubmitting: _efillingCtrl.isPageSubmitting.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
