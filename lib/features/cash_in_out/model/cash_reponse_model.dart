class CashReposeModel{
  String data;

  CashReposeModel(this.data);

  CashReposeModel.fromJson(Map<String,dynamic>json, this.data){
    data=json[''];
  }
}