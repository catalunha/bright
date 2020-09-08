enum AuthenticationStatusLogged {
  unInitialized,
  authenticated,
  authenticating,
  unAuthenticated,
  sendPasswordReset,
}

// +++ StudentFilter +++
enum StudentFilter {
  active,
  inactive,
}

extension StudentFilterExtension on StudentFilter {
  static const names = {
    StudentFilter.active: 'Ativos',
    StudentFilter.inactive: 'Inativos',
  };
  String get label => names[this];
}
// --- StudentFilter ---

// +++ StudentFilter +++
enum MeetFilter {
  paid,
  notpaid,
}

extension MeetFilterExtension on MeetFilter {
  static const names = {
    MeetFilter.paid: 'Pago',
    MeetFilter.notpaid: 'Não Pago',
  };
  String get label => names[this];
}
// --- MeetFilter ---

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
