import 'package:flutter/services.dart';
import 'package:misamoneykeeper_flutter/controller/account_add_view_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class AccountAdd extends StatefulWidget {
  const AccountAdd({super.key});

  @override
  State<AccountAdd> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AccountAdd> {
  final _formKey = GlobalKey<FormState>();

  //Mảng lưu các tài sản có thể chọn
  final List<String> _accountTypes = [
    'Tiền mặt',
    'Ngân hàng',
    'Tài sản cố định'
  ];
  var accountAddVM = Get.put(AccountAddViewModel());
  //Hàm để khởi tạo trạng thái ban đầu của widget
  @override
  void initState() {
    super.initState();
    accountAddVM.clean();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Thêm tài sản',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => accountAddVM.isLoading.value == true
                ? Center(child: loadingIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //Giá trị tài sản
                          Card(
                            child: TextFormField(
                              controller: accountAddVM.balanceController.value,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập giá trị tài sản';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                labelText: 'Giá trị tài sản',
                                prefixIcon: Icon(Icons.attach_money),
                              ),
                            ),
                          ),
                          //Tên tài sản
                          Card(
                            child: TextFormField(
                              controller: accountAddVM.nameController.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập tên';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                labelText: 'Tên',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                          ),
                          //Chọn loại tài sản
                          Obx(
                            () => DropdownButton(
                              value: accountAddVM.accountType.value,
                              isExpanded: true,
                              underline: const SizedBox(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              items: _accountTypes.map((accountType) {
                                return DropdownMenuItem(
                                  value: accountType,
                                  child: Row(
                                    children: [
                                      if (accountType == 'Tiền mặt')
                                        const Icon(Icons.account_balance_wallet)
                                      else if (accountType == 'Ngân hàng')
                                        const Icon(Icons.account_balance)
                                      else if (accountType == 'Tài sản cố định')
                                        const Icon(Icons.two_wheeler),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(accountType),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                accountAddVM.accountType.value =
                                    newValue ?? 'Tiền mặt';
                                if (newValue == 'Tiền mặt') {
                                  accountAddVM.accountTypeId.value = 1;
                                } else if (newValue == 'Ngân hàng') {
                                  accountAddVM.accountTypeId.value = 2;
                                } else {
                                  accountAddVM.accountTypeId.value = 3;
                                }
                              },
                            ),
                          ),
                          //Diễn giải
                          Card(
                            child: TextFormField(
                              controller:
                                  accountAddVM.descriptionController.value,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                labelText: 'Diễn giải',
                                prefixIcon: Icon(Icons.sort),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //Nút lưu
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  minimumSize: const Size(200.0, 50.0),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    accountAddVM.serviceCallAddAccount();
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.save,
                                      color: Colors.white,
                                    ),
                                    Text('Lưu',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
