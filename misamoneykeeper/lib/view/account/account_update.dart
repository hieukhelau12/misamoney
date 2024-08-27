import 'package:flutter/services.dart';
import 'package:misamoneykeeper_flutter/controller/account_update_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class AccountUpdate extends StatefulWidget {
  final AccountModel accountModel;
  const AccountUpdate({super.key, required this.accountModel});

  @override
  State<AccountUpdate> createState() => _AccountUpdateState();
}

class _AccountUpdateState extends State<AccountUpdate> {
  late AccountUpdateViewModel accountUpdateVM;
  final _formKey = GlobalKey<FormState>();

  //Hàm để khởi tạo trạng thái ban đầu của widget
  @override
  void initState() {
    super.initState();
    accountUpdateVM =
        Get.put(AccountUpdateViewModel(widget.accountModel.accountId!));
    accountUpdateVM.balanceController.value.text =
        widget.accountModel.acMoney!.toString();
    accountUpdateVM.nameController.value.text = widget.accountModel.acName!;
    if (widget.accountModel.acType == 1) {
      accountUpdateVM.accountType.value = "Tiền mặt";
    } else if (widget.accountModel.acType == 2) {
      accountUpdateVM.accountType.value = "Ngân hàng";
    } else {
      accountUpdateVM.accountType.value = "Tài sản cố định";
    }
    accountUpdateVM.descriptionController.value.text =
        widget.accountModel.acExplanation!;
  }

  //Mảng lưu các tài sản có thể chọn
  final List<String> _accountTypes = [
    'Tiền mặt',
    'Ngân hàng',
    'Tài sản cố định'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sửa tài khoản',
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
        body: Obx(
          () => accountUpdateVM.isLoading.value == true
              ? Center(child: loadingIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Card(
                          //Giá trị tài sản
                          child: TextFormField(
                            controller: accountUpdateVM.balanceController.value,
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
                        Card(
                          //Tên tài sản
                          child: TextFormField(
                            controller: accountUpdateVM.nameController.value,
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
                            value: accountUpdateVM.accountType.value,
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
                              accountUpdateVM.accountType.value =
                                  newValue ?? 'Tiền mặt';
                              if (newValue == 'Tiền mặt') {
                                accountUpdateVM.accountTypeId.value = 1;
                              } else if (newValue == 'Ngân hàng') {
                                accountUpdateVM.accountTypeId.value = 2;
                              } else {
                                accountUpdateVM.accountTypeId.value = 3;
                              }
                            },
                          ),
                        ),
                        //Diễn giải
                        Card(
                          child: TextFormField(
                            controller:
                                accountUpdateVM.descriptionController.value,
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
                                  accountUpdateVM.serviceCallAccountUpdate();

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
        ));
  }
}
