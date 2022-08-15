abstract class QRCodeStates{}

class QRCodeInitialState extends QRCodeStates{}

class GetDataSuccessState extends QRCodeStates{}
class GetDataLoadingState extends QRCodeStates{}
class GetDataErrorState extends QRCodeStates{
  final String error;
  GetDataErrorState(this.error);
}