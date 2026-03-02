class CalendarResponse {
  final bool? success;
  final String? message;
  final List<CalendarEntry>? data;

  CalendarResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CalendarResponse.fromJson(Map<String, dynamic> json) {
    return CalendarResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<CalendarEntry>.from(
          json['data'].map((x) => CalendarEntry.fromJson(x)))
          : [],
    );
  }
}

class CalendarEntry {
  final String? id;
  final Creator? creator;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final String? country;
  final String? city;
  final String? fullAddress;

  CalendarEntry({
    this.id,
    this.creator,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.country,
    this.city,
    this.fullAddress,
  });

  factory CalendarEntry.fromJson(Map<String, dynamic> json) {
    return CalendarEntry(
      id: json['_id'],
      creator: json['creatorId'] != null
          ? Creator.fromJson(json['creatorId'])
          : null,
      startDate: json['startDate'],
      endDate: json['endDate'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      country: json['country'],
      city: json['city'],
      fullAddress: json['fullAddress'],
    );
  }
}

class Creator {
  final String? id;
  final String? name;
  final String? email;
  final String? image;

  Creator({
    this.id,
    this.name,
    this.email,
    this.image,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
    );
  }
}