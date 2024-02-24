// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      price: json['price'] as String,
      discount: json['discount'] as String,
      discountPrice: json['discountPrice'] as String,
      brand: json['brand'] as String,
      description: json['description'] as String?,
      colors:
          (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      sizes:
          (json['sizes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      rating: json['rating'] as String?,
      model: json['model'] as String?,
      weight: json['weight'] as String?,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'discount': instance.discount,
      'discountPrice': instance.discountPrice,
      'brand': instance.brand,
      'description': instance.description,
      'colors': instance.colors,
      'sizes': instance.sizes,
      'images': instance.images,
      'rating': instance.rating,
      'model': instance.model,
      'weight': instance.weight,
    };
