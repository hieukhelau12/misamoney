import 'package:misamoneykeeper_flutter/controller/category_details_collect_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/collect_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CategoryCollect extends StatelessWidget {
  const CategoryCollect({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryDetails = Get.put(CategoryDetailsCollectViewModel());
    final payCollect = Get.find<CollectViewModel>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0.5,
          centerTitle: true,
          title: "Chọn Hạng Mục Thu"
              .text
              .white
              .size(20)
              .fontFamily(sansSemibold)
              .make(),
        ),
        body: FutureBuilder(
          future: categoryDetails.serviceCallCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: loadingIndicator());
            } else if (snapshot.hasError) {
              return Container(
                color: Colors.amber,
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              var data = snapshot.data!;
              //Hiện thị các mục của danh mục thu
              return ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black26,
                  );
                },
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Image.network(
                        "${SVKey.mainUrl}${data[index].cadImage}",
                        width: 30,
                        height: 35,
                      ),
                      10.widthBox,
                      ("${data[index].cadName}")
                          .text
                          .size(16)
                          .fontFamily(sansBold)
                          .color(Colors.black87)
                          .make()
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.symmetric(vertical: 5))
                      .margin(const EdgeInsets.symmetric(vertical: 5))
                      .make()
                      .onTap(() {
                    payCollect.categoryDetailsId.value =
                        data[index].categoryDetailsId!;
                    payCollect.categoryIcon.value =
                        SVKey.mainUrl + data[index].cadImage!;
                    payCollect.categoryTitle.value = data[index].cadName!;
                    Get.back();
                  });
                },
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
