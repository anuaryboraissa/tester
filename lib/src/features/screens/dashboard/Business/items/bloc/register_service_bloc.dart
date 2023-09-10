import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erisiti/src/features/services/enpoints/create_receipt.dart';
import 'package:erisiti/src/features/services/enpoints/get_business_receipt_id.dart';
import 'package:erisiti/src/features/services/enpoints/get_businesses_by_tin.dart';
import 'package:erisiti/src/features/services/enpoints/get_products_by_tin.dart';
import 'package:erisiti/src/features/services/enpoints/get_user_receipt_by_tin.dart';
import 'package:erisiti/src/features/services/enpoints/register_business.dart';
import 'package:erisiti/src/features/services/enpoints/register_item.dart';
import 'package:meta/meta.dart';

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
  }

  FutureOr<void> registerServiceEvent(
      RegisterServiceEvent event, Emitter<RegisterServiceState> emit) {}

  FutureOr<void> registerBusinessEvent(
      RegisterBusinessEvent event, Emitter<RegisterServiceState> emit) async {
    List<Map<String, dynamic>> businesses = event.businesses;
    int totalBusinesses = businesses.length;
    double progress = 0;

    for (int index = 0; index < totalBusinesses; index++) {
      Map<String, dynamic> business = businesses[index];
      List<Map<String, dynamic>> items = business['products'];
      int totalItems = items.length;

      final registerBusiness = await RegisterBusinessService.registerBusiness(
          business['businessName'],
          business['businessRegion'],
          business['businessDistrict'],
          business['businessRegistrationNumber'],
          business['businessTinNumber']);

      if (registerBusiness['code'] == 5000) {
        progress = index / (totalBusinesses - 1);
        if (totalItems == 0) {
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
            itemProgress =
                ((index2 / (totalItems - 1)) * index) / ((totalBusinesses - 1));

            if (itemProgress >= progress) {
              emit(RegistrationProcessState(itemProgress));
              progress = itemProgress;
            }
          } else {
            print("Something went wrong while register item");
            emit(RegistrationProcessState(0.0));
            emit(RegisterBusinessState("${registerItems['message']}", false));
          }
        }
        print("new progress $progress");
      } else {
        // print("Something went wrong ety");
        emit(RegistrationProcessState(0.0));
        emit(RegisterBusinessState("${registerBusiness['message']}", false));
      }
    }
    if (progress == 1.0) {
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
    } else {
      emit(BusinessByTinState(const [], true, result['message']));
    }
  }

  FutureOr<void> findProductsByBusinessNumberEvent(
      FindProductsByBusinessNumberEvent event,
      Emitter<RegisterServiceState> emit) async {
    final result = await FindProductsService.getProductsByBusinessNumber(
        int.parse(event.businessNumber));
    if (result['code'] == 5000) {
      emit(FindProductsByBusinessNumberState(result['data'], false, "Success"));
    } else {
      emit(FindProductsByBusinessNumberState(
          const [], true, result['messages']));
    }
  }

  FutureOr<void> findUserReceiptByTinEvent(FindUserReceiptByTinEvent event,
      Emitter<RegisterServiceState> emit) async {
    final result = await FindUserReceiptService.getUserReceiptByTin(
        int.parse(event.tinNumber));
    if (result['code'] == 5000) {
      emit(FindUserReceiptByTinState(result['data'], false, "Success"));
    } else {
      emit(FindUserReceiptByTinState(const [], true, result['messages']));
    }
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
          const [], true, result['messages']));
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
      emit(GenerateReceiptState(true, result['message']));
    } else {
      emit(GenerateReceiptState(false, result['message']));
    }
  }
}
