class GlobalEvent {
  String scope, action, message;
  GlobalEvent(String scope, String action, {String message}){
    this.scope = scope;
    this.action = action;
    this.message = message;
  }
}