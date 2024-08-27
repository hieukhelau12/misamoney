import 'package:misamoneykeeper_flutter/controller/category_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/pay_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/common/category_cell.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

var categoryVM = Get.put(CategoryViewModel());
final payVM = Get.find<PayViewModel>();

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0.5,
          centerTitle: true,
          title: "Chọn Hạng Mục Chi"
              .text
              .white
              .size(20)
              .fontFamily(sansSemibold)
              .make(),
        ),
        body: FutureBuilder(
          future: categoryVM.serviceCallCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: loadingIndicator());
            } else if (snapshot.hasError) {
              return Container(
                color: Colors.amber,
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              var data = snapshot.data!;
              //Hiện thị các mục chính của danh mục chi
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.amberAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              "${SVKey.mainUrl}${data[i].caImage}",
                              width: 30,
                              height: 30,
                            ),
                            10.widthBox,
                            ("${data[i].caName}")
                                .text
                                .size(16)
                                .fontFamily(sansBold)
                                .color(Colors.black87)
                                .make()
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Hiện thị các mục con của mục chính
                        Flexible(
                          fit: FlexFit.loose,
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 7,
                                      childAspectRatio: 1.3),
                              itemCount: data[i].categoryDetails!.length,
                              itemBuilder: ((context, index) {
                                return CategoryCell(
                                    icon: SVKey.mainUrl +
                                        data[i]
                                            .categoryDetails![index]
                                            .cadImage!,
                                    title: data[i]
                                        .categoryDetails![index]
                                        .cadName!,
                                    onPressed: () {
                                      payVM.categoryDetailsId.value = data[i]
                                          .categoryDetails![index]
                                          .categoryDetailsId!;
                                      payVM.categoryIcon.value = SVKey.mainUrl +
                                          data[i]
                                              .categoryDetails![index]
                                              .cadImage!;
                                      payVM.categoryTitle.value = data[i]
                                          .categoryDetails![index]
                                          .cadName!;
                                      Get.back();
                                    });
                              })),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
