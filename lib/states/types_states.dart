enum AuthenticationStatusLogged {
  unInitialized,
  authenticated,
  authenticating,
  unAuthenticated,
  sendPasswordReset,
}

//+++ UserOrder
enum UserOrder {
  name,
}

extension UserOrderExtension on UserOrder {
  static const names = {
    UserOrder.name: 'Nome',
  };
  String get label => names[this];
}
//--- UserOrder

//+++ InfoCodeOrder
enum InfoCodeOrder {
  code,
  name,
  unit,
  infoIndOwnerRefName,
}

extension InfoCodeOrderExtension on InfoCodeOrder {
  static const names = {
    InfoCodeOrder.code: 'Codigo',
    InfoCodeOrder.name: 'Nome',
    InfoCodeOrder.unit: 'Unidade',
    InfoCodeOrder.infoIndOwnerRefName: 'Organizador',
  };
  String get label => names[this];
}
//--- InfoCodeOrder
