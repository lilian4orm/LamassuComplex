// class HousesIdModel {
//   bool? error;
//   String? message;
//   List<Results>? results;
//   String? contentUrl;
//
//   HousesIdModel({this.error, this.message, this.results, this.contentUrl});
//
//   HousesIdModel.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     message = json['message'];
//     if (json['results'] != null) {
//       results = <Results>[];
//       json['results'].forEach((v) {
//         results!.add(new Results.fromJson(v));
//       });
//     }
//     contentUrl = json['content_url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['error'] = this.error;
//     data['message'] = this.message;
//     if (this.results != null) {
//       data['results'] = this.results!.map((v) => v.toJson()).toList();
//     }
//     data['content_url'] = this.contentUrl;
//     return data;
//   }
// }
//
// class Results {
//   String? sId;
//   String? name;
//   int? price;
//   String? description;
//   List<String>? imgs;
//   int? rating;
//   int? space;
//   int? livingRooms;
//   int? bedRooms;
//   int? bathRooms;
//   bool? isAvailable;
//   bool? isDeleted;
//   String? existingType;
//   String? centerId;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//   Results(
//       {this.sId,
//         this.name,
//         this.price,
//         this.description,
//         this.imgs,
//         this.rating,
//         this.space,
//         this.livingRooms,
//         this.bedRooms,
//         this.bathRooms,
//         this.isAvailable,
//         this.isDeleted,
//         this.existingType,
//         this.centerId,
//         this.createdAt,
//         this.updatedAt,
//         this.iV});
//
//   Results.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     price = json['price'];
//     description = json['description'];
//     imgs = json['imgs'].cast<String>();
//     rating = json['rating'];
//     space = json['space'];
//     livingRooms = json['living_rooms'];
//     bedRooms = json['bed_rooms'];
//     bathRooms = json['bath_rooms'];
//     isAvailable = json['is_available'];
//     isDeleted = json['is_deleted'];
//     existingType = json['existing_type'];
//     centerId = json['center_id'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['description'] = this.description;
//     data['imgs'] = this.imgs;
//     data['rating'] = this.rating;
//     data['space'] = this.space;
//     data['living_rooms'] = this.livingRooms;
//     data['bed_rooms'] = this.bedRooms;
//     data['bath_rooms'] = this.bathRooms;
//     data['is_available'] = this.isAvailable;
//     data['is_deleted'] = this.isDeleted;
//     data['existing_type'] = this.existingType;
//     data['center_id'] = this.centerId;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }