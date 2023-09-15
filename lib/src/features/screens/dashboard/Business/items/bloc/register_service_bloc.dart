import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/features/receipts/modal/receipt.dart';
// import 'package:erisiti/src/features/screens/dashboard/features/receipts/modal/helper.dart';
// import 'package:erisiti/business/productList/helper.dart';
import 'package:erisiti/src/features/services/database/dbHelpers/business.dart';
import 'package:erisiti/src/features/services/database/modalHelpers/business_helper.dart';
import 'package:erisiti/src/features/services/database/modalHelpers/client_helper.dart';
import 'package:erisiti/src/features/services/database/modalHelpers/receipt_product_helper.dart';
import 'package:erisiti/src/features/services/database/modals/receipt.dart';
import 'package:erisiti/src/features/services/enpoints/create_receipt.dart';
import 'package:erisiti/src/features/services/enpoints/get_business_receipt_id.dart';
import 'package:erisiti/src/features/services/enpoints/get_businesses_by_tin.dart';
import 'package:erisiti/src/features/services/enpoints/get_products_by_tin.dart';
import 'package:erisiti/src/features/services/enpoints/get_user_receipt_by_tin.dart';
import 'package:erisiti/src/features/services/enpoints/register_business.dart';
import 'package:erisiti/src/features/services/enpoints/register_item.dart';
import 'package:erisiti/src/features/services/enpoints/single_receipt.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../../../../services/database/modalHelpers/product_helper.dart';
import '../../../../../services/database/modalHelpers/receipt_helper.dart';

part 'register_service_event.dart';
part 'register_service_state.dart';

class RegisterServiceBloc
    extends Bloc<RegisterServiceEvent, RegisterServiceState> {
  RegisterServiceBloc() : super(RegisterServiceInitial()) {
    on<RegisterServiceEvent>(registerServiceEvent);
    on<RegisterBusinessEvent>(registerBusinessEvent);
    on<FindBusinessEvent>(findBusinessEvent);
    on<FindProductsByBusinessNumberEvent>(findProductsByBusinessNumberEvent);
    on<FindUserReceiptByTinEvent>(findUserReceiptByTinEvent);
    on<FindBusinessReceiptsByBusinessIdEvent>(
        findBusinessReceiptsByBusinessIdEvent);
    on<GenerateReceiptEvent>(generateReceiptEvent);
    on<FindReceiptByNumberEvent>(findReceiptByNumberEvent);
    on<AddBusinessItemEvent>(addBusinessItemEvent);
  }

  FutureOr<void> registerServiceEvent(
      RegisterServiceEvent event, Emitter<RegisterServiceState> emit) {}

  FutureOr<void> registerBusinessEvent(
      RegisterBusinessEvent event, Emitter<RegisterServiceState> emit) async {
    List<Map<String, dynamic>> businesses = event.businesses;
    int totalBusinesses = businesses.length;
    double progress = 0;
    print("step 1 $progress");

    for (int index = 0; index < totalBusinesses; index++) {
      Map<String, dynamic> business = businesses[index];
      List<Map<String, dynamic>> items = business['products'];
      int totalItems = items.length;
      print("step 2 $progress");
      final registerBusiness = await RegisterBusinessService.registerBusiness(
          business['businessName'],
          business['businessRegion'],
          business['businessDistrict'],
          business['businessRegistrationNumber'],
          business['businessTinNumber']);

      if (registerBusiness['code'] == 5000) {
        print("step n $progress");
        if ((totalBusinesses - 1) > 0) {
          progress = index / (totalBusinesses - 1);
        }
        if ((totalBusinesses - 1) == 0 && totalItems == 1) {
          progress = 1.0;
        }
        if (totalItems == 0) {
          print("step 3 $progress");
          emit(RegistrationProcessState(progress));
        }
        double itemProgress = 0;
        for (int index2 = 0; index2 < items.length; index2++) {
          Map<String, dynamic> item = items[index2];
          final registerItems = await RegisterItemService.registerItem(
              item['name'],
              int.parse(item['price']),
              !item['acceptDecimal'],
              item['unit'],
              business['businessRegistrationNumber']);
          if (registerItems['code'] == 5000) {
            if ((totalBusinesses - 1) > 0 && (totalItems - 1) > 0) {
              itemProgress = ((index2 / (totalItems - 1)) * index) /
                  ((totalBusinesses - 1));
            }

            print("item progre $itemProgress");
            if (itemProgress >= progress) {
              progress = itemProgress;
              print("step b $progress");
              emit(RegistrationProcessState(itemProgress));
            }
            emit(RegistrationProcessState(itemProgress));
            print("step 4 $progress");
          } else {
            print("Something went wrong while register item");
            emit(RegistrationProcessState(0.0));
            emit(RegisterBusinessState("${registerItems['message']}", false));
          }
        }
        print("step 5 $progress");
        print("new progress $progress");
      } else {
        // print("Something went wrong ety");
        emit(RegistrationProcessState(0.0));
        emit(RegisterBusinessState("${registerBusiness['message']}", false));
      }
    }
    if (progress == 1.0) {
      print("step 6 $progress");
      emit(RegisterBusinessState("Successfully registered", true));
    }
  }

  FutureOr<void> findBusinessEvent(
      FindBusinessEvent event, Emitter<RegisterServiceState> emit) async {
    final result = await FindBusinessesService.getBusinessByTin(
        int.parse(event.tinNumber));
    print(result);
    if (result['code'] == 5000) {
      emit(BusinessByTinState(result['data'], false, "Success"));
      for (Map<String, dynamic> item in (result['data'] as List)) {
        saveBusiness(item);
      }
    } else {
      print("response msg ${result['message']}");
      emit(BusinessByTinState(
          const [],
          true,
          result['message'].toString().contains("Network is unreachable")
              ? "Network is unreachable"
              : result['message']));
    }
  }

  void saveBusiness(Map<String, dynamic> item) {
    BusinessHelper()
        .queryByBusinessNumber(item['businessRegistrationNumber'])
        .then((value) {
      if (value == null) {
        BusinessProfile businessProfile = BusinessProfile(
            id: item['id'],
            createdAt: item['createdAt'],
            businessType: item['businessType'],
            createdBy: item['createdBy'],
            updatedAt: item['updatedAt'],
            updatedBy: item['updatedBy'],
            deleted: item['deleted'] ? 1 : 0,
            uuid: item['uuid'],
            active: item['active'] ? 1 : 0,
            businessName: item['businessName'],
            region: item['region'],
            tinNumber: item['tinNo'],
            businessRegNumber: item['businessRegistrationNumber'],
            district: item['district']);

        BusinessHelper().insert(businessProfile).then((value2) {
          if (value2 > 0) {
            Fluttertoast.showToast(msg: "Business saved Successfully");
          }
        });
      }
    });
  }

  void saveClient(Map<String, dynamic> item) {
    ClientHelper().queryByTinNumber(item['tinNo'], item['id']).then((value) {
      // print("user mwenyewe is ${value} prev tin ${item['tinNo']}");
      ClientHelper().queryAll().then((value) {
        print("wapo ${value.length}");
        value.forEach((element) {
          print("this ${element!.fullName} tin ${element.tinNumber}");
        });
      });
      if (value == null) {
        ClientProfile clientProfile = ClientProfile(
            id: item['id'],
            createdAt: item['createdAt'],
            deleted: item['deleted'] ? 1 : 0,
            uuid: item['uuid'],
            fullName: item['fullName'],
            username: item['username'],
            tinNumber: item['tinNo'],
            phone: item['phone'],
            userType: item['userType'],
            createdBy: item['createdBy'],
            updatedAt: item['updatedAt'],
            updatedBy: item['updatedBy']);
        ClientHelper().insert(clientProfile).then((value2) {
          if (value2 > 0) {
            Fluttertoast.showToast(
                msg: "${item['fullName']} saved successfully");
          }
        });
      }
    });
  }

  FutureOr<void> findProductsByBusinessNumberEvent(
      FindProductsByBusinessNumberEvent event,
      Emitter<RegisterServiceState> emit) async {
    final result = await FindProductsService.getProductsByBusinessNumber(
        int.parse(event.businessNumber));
    if (result['code'] == 5000) {
      emit(FindProductsByBusinessNumberState(result['data'], false, "Success"));

      saveProducts(result['data'], "");
    } else {
      print("message is ${result['message']}");
      emit(FindProductsByBusinessNumberState(
          const [],
          true,
          result['message'].toString().contains("Connection")
              ? "Network is unreachable"
              : result['message']));
    }
  }

  void saveProducts(List result, String businessRegNumber) {
    for (Map<String, dynamic> item in (result)) {
      print("item id ${item['id']} ..........................");
      ProductHelper().queryById(item['id']).then((value) {
        if (value == null) {
          ReceiptItem receiptItem = ReceiptItem(
              id: item['id'],
              createdAt: item['createdAt'],
              updatedAt: item['updatedAt'],
              createdBy: item['createdBy'],
              updatedBy: item['updatedBy'],
              uuid: item['uuid'],
              active: item['active'] ? 1 : 0,
              deleted: item['deleted'] ? 1 : 0,
              amount:
                  int.parse(item['amount'] ?? item['price'].toString()) + 0.0,
              businessRegNumber: item['businessProfile'] != null
                  ? item['businessProfile']['businessRegistrationNumber']
                  : businessRegNumber,
              productName: item['productName']);

          ProductHelper().insert(receiptItem).then((value2) {
            if (value2 > 0) {
              ProductHelper().queryAll().then((value) {
                print("total products registered ${value.length}");
              });
              Fluttertoast.showToast(
                  msg: "${item['productName']} saved successfully");
              print("business profile is ${item['businessProfile']}.......");
              if (item['businessProfile'] != null) {
                saveBusiness(item['businessProfile']);
              }
            }
          });
        }
      });
    }
  }

  FutureOr<void> findUserReceiptByTinEvent(FindUserReceiptByTinEvent event,
      Emitter<RegisterServiceState> emit) async {
    final result = await FindUserReceiptService.getUserReceiptByTin(
        int.parse(event.tinNumber));
    if (result['code'] == 5000) {
      List receipts = result['data'];
      double taxAmount = 0.0;
      double totalAmount = 0.0;
      int totalReceipts = receipts.length;
      receipts.forEach((element) {
        taxAmount = element['tozo'] + taxAmount;
        totalAmount = element['amount'] + totalAmount;
      });
      Map<String, dynamic> receiptOverview = {
        "totalReceipts": totalReceipts,
        "taxAmount": taxAmount,
        "totalAmount": totalAmount,
        "receipts": receipts
      };
      emit(FindUserReceiptByTinState(receiptOverview, false, "Success"));

      for (Map<String, dynamic> receipt in receipts) {
        ReceiptHelper()
            .queryByReceiptNumber(receipt['receiptNumber'])
            .then((value) {
          if (value == null) {
            ReceiptModal receiptModal = ReceiptModal(
                id: receipt['id'],
                createdAt: receipt['updatedAt'],
                deleted: receipt['deleted'] ? 1 : 0,
                uuid: receipt['uuid'],
                active: receipt['active'] ? 1 : 0,
                receiptNumber: receipt['receiptNumber'],
                amount: double.parse(receipt['amount'].toString()),
                vat: double.parse(receipt['vat'].toString()),
                tozo: double.parse(receipt['tozo'].toString()),
                businessProfile: receipt['businessProfile']['id'],
                clientProfile: receipt['client']['id']);

            ReceiptHelper().insert(receiptModal).then((value2) {
              if (value2 > 0) {
                Fluttertoast.showToast(
                    msg: "${receipt['receiptNumber']} saved successfully");
                saveBusiness(receipt['businessProfile']);
                saveClient(receipt['client']);
                saveProducts(receipt['receiptProducts'],
                    receipt['businessProfile']['businessRegistrationNumber']);
                saveReceiptProducts(
                    receipt['receiptNumber'], receipt['receiptProducts']);
              }
            });
          }
        });
      }
    } else {
      emit(FindUserReceiptByTinState(const {}, true, result['message']));
    }
  }

  void saveReceiptProducts(String receiptNumber, List products) {
    //apa
    products.forEach((element) {
      ReceiptProductHelper()
          .queryByReceiptProduct(receiptNumber, element['id'])
          .then((value) {
        if (value == null) {
          ReceiptProducts receiptProducts = ReceiptProducts(
              productId: element['id'], receiptNumber: receiptNumber);
          ReceiptProductHelper().insert(receiptProducts).then((value2) {
            if (value2 > 0) {
              Fluttertoast.showToast(msg: "Receipt product saved successfully");
            }
          });
        }
      });
    });
  }

  FutureOr<void> findBusinessReceiptsByBusinessIdEvent(
      FindBusinessReceiptsByBusinessIdEvent event,
      Emitter<RegisterServiceState> emit) async {
    final result = await FindBusinessReceiptsService.getBusinessReceiptsById(
        event.businessId);
    if (result['code'] == 5000) {
      emit(FindBusinessReceiptsByBusinessIdState(
          result['data'], false, "Success"));
    } else {
      emit(FindBusinessReceiptsByBusinessIdState(
          const [],
          true,
          result['message'].toString().contains("Connection")
              ? "Network is unreachable"
              : result['message']));
    }
  }

  FutureOr<void> generateReceiptEvent(
      GenerateReceiptEvent event, Emitter<RegisterServiceState> emit) async {
    print("yeap ${event.item}");
    final result = await GenerateReceiptService.generateReceipt(
        event.item['amount'],
        event.item['vat'],
        event.item['tozo'],
        event.item['businessId'],
        event.item['tinNo'],
        event.item['products']);
    if (result['code'] == 5000) {
      emit(GenerateReceiptState(true, result['message'], result['data']));
    } else {
      emit(GenerateReceiptState(false, result['message'], ""));
    }
  }

  FutureOr<void> findReceiptByNumberEvent(FindReceiptByNumberEvent event,
      Emitter<RegisterServiceState> emit) async {
    final result =
        await FindSingleReceiptService.getReceiptByNumber(event.receiptNumber);
    if (result['code'] == 5000) {
      print(result);
      emit(FindReceiptByNumberState(result['data'], true, "success"));
    } else {
      emit(FindReceiptByNumberState(const {}, false, result['message']));
    }
  }

  FutureOr<void> addBusinessItemEvent(
      AddBusinessItemEvent event, Emitter<RegisterServiceState> emit) async {
    List<Map<String, dynamic>> items = event.products;
    for (int index2 = 0; index2 < items.length; index2++) {
      Map<String, dynamic> item = items[index2];
      final registerItems = await RegisterItemService.registerItem(
          item['name'],
          int.parse(item['price']),
          !item['acceptDecimal'],
          item['unit'],
          item['businessRegNumber']);
      if (registerItems['code'] == 5000) {
        emit(AddBusinessItemState("${registerItems['message']}", true));
      } else {
        emit(AddBusinessItemState("${registerItems['message']}", false));
      }
    }
  }
}
