class ServiceState {
  String? serviceId;
  String? serviceName;
  String? price;
  String? imagePath;

  ServiceState({this.serviceId, this.serviceName, this.price, this.imagePath});

  ServiceState.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    price = json['price'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['service_name'] = serviceName;
    data['price'] = price;
    data['imagePath'] = imagePath;
    return data;
  }
}
