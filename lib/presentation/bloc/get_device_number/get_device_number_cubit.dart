import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/presentation/bloc/get_device_number/get_device_number_state.dart';

import '../../../domain/usecases/get_device_numbers_usecase.dart';

class GetDeviceNumberCubit extends Cubit<GetDeviceNumbersState> {
  final GetDeviceNumberUseCase getDeviceNumberUseCase;

  GetDeviceNumberCubit({required this.getDeviceNumberUseCase})
      : super(GetDeviceNumbersInitial());

  Future<void> getDeviceNumbers() async {
    try {
      final contactNumbers = await getDeviceNumberUseCase.call();
      emit(GetDeviceNumbersLoaded(contacts: contactNumbers));
    } catch (e) {
      emit(GetDeviceNumbersFailure());
    }
  }
}
