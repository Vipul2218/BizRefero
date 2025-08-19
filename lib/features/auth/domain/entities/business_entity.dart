import 'package:equatable/equatable.dart';
import 'location_entity.dart';

class BusinessEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String category;
  final String? subcategory;
  final String? logoUrl;
  final List<String> imageUrls;
  final LocationEntity location;
  final String? phone;
  final String? email;
  final String? website;
  final Map<String, dynamic> socialMedia;
  final Map<String, dynamic> hours;
  final double rating;
  final int reviewCount;
  final List<String> amenities;
  final List<String> tags;
  final String ownerId;
  final bool isVerified;
  final bool isActive;
  final bool isFeatured;
  final double? price;
  final String? priceRange;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BusinessEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.subcategory,
    this.logoUrl,
    this.imageUrls = const [],
    required this.location,
    this.phone,
    this.email,
    this.website,
    this.socialMedia = const {},
    this.hours = const {},
    this.rating = 0.0,
    this.reviewCount = 0,
    this.amenities = const [],
    this.tags = const [],
    required this.ownerId,
    this.isVerified = false,
    this.isActive = true,
    this.isFeatured = false,
    this.price,
    this.priceRange,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        subcategory,
        logoUrl,
        imageUrls,
        location,
        phone,
        email,
        website,
        socialMedia,
        hours,
        rating,
        reviewCount,
        amenities,
        tags,
        ownerId,
        isVerified,
        isActive,
        isFeatured,
        price,
        priceRange,
        createdAt,
        updatedAt,
      ];

  /// Get business status
  String get status {
    if (!isActive) return 'Inactive';
    if (!isVerified) return 'Unverified';
    if (isFeatured) return 'Featured';
    return 'Active';
  }

  /// Get rating stars text
  String get ratingText {
    if (reviewCount == 0) return 'No reviews';
    return '${rating.toStringAsFixed(1)} (${reviewCount} ${reviewCount == 1 ? 'review' : 'reviews'})';
  }

  /// Check if business is open now
  bool get isOpenNow {
    if (hours.isEmpty) return true; // Assume open if no hours specified
    
    final now = DateTime.now();
    final dayOfWeek = now.weekday; // 1 = Monday, 7 = Sunday
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    
    final todayKey = _getDayKey(dayOfWeek);
    final todayHours = hours[todayKey];
    
    if (todayHours == null || todayHours == 'closed') return false;
    if (todayHours == '24/7' || todayHours == 'open') return true;
    
    // Parse hours like "09:00-17:00"
    if (todayHours is String && todayHours.contains('-')) {
      final parts = todayHours.split('-');
      if (parts.length == 2) {
        final openTime = parts[0].trim();
        final closeTime = parts[1].trim();
        return _isTimeInRange(currentTime, openTime, closeTime);
      }
    }
    
    return true; // Default to open if format is unclear
  }

  /// Get today's hours
  String get todayHours {
    final now = DateTime.now();
    final dayOfWeek = now.weekday;
    final todayKey = _getDayKey(dayOfWeek);
    final todayHours = hours[todayKey];
    
    if (todayHours == null) return 'Hours not specified';
    if (todayHours == 'closed') return 'Closed today';
    if (todayHours == '24/7') return 'Open 24 hours';
    if (todayHours == 'open') return 'Open';
    
    return todayHours.toString();
  }

  /// Get distance to this business from a location
  double distanceFrom(LocationEntity from) {
    return location.distanceTo(from);
  }

  /// Check if business has specific amenity
  bool hasAmenity(String amenity) {
    return amenities.contains(amenity);
  }

  /// Check if business has specific tag
  bool hasTag(String tag) {
    return tags.contains(tag);
  }

  /// Get primary contact method
  String? get primaryContact {
    if (phone?.isNotEmpty == true) return phone;
    if (email?.isNotEmpty == true) return email;
    return null;
  }

  /// Copy with method
  BusinessEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? subcategory,
    String? logoUrl,
    List<String>? imageUrls,
    LocationEntity? location,
    String? phone,
    String? email,
    String? website,
    Map<String, dynamic>? socialMedia,
    Map<String, dynamic>? hours,
    double? rating,
    int? reviewCount,
    List<String>? amenities,
    List<String>? tags,
    String? ownerId,
    bool? isVerified,
    bool? isActive,
    bool? isFeatured,
    double? price,
    String? priceRange,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BusinessEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      logoUrl: logoUrl ?? this.logoUrl,
      imageUrls: imageUrls ?? this.imageUrls,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      socialMedia: socialMedia ?? this.socialMedia,
      hours: hours ?? this.hours,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      amenities: amenities ?? this.amenities,
      tags: tags ?? this.tags,
      ownerId: ownerId ?? this.ownerId,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      price: price ?? this.price,
      priceRange: priceRange ?? this.priceRange,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convert to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'subcategory': subcategory,
      'logo_url': logoUrl,
      'image_urls': imageUrls,
      'location': location.toMap(),
      'phone': phone,
      'email': email,
      'website': website,
      'social_media': socialMedia,
      'hours': hours,
      'rating': rating,
      'review_count': reviewCount,
      'amenities': amenities,
      'tags': tags,
      'owner_id': ownerId,
      'is_verified': isVerified,
      'is_active': isActive,
      'is_featured': isFeatured,
      'price': price,
      'price_range': priceRange,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create from map
  factory BusinessEntity.fromMap(Map<String, dynamic> map) {
    return BusinessEntity(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      subcategory: map['subcategory'],
      logoUrl: map['logo_url'],
      imageUrls: List<String>.from(map['image_urls'] ?? []),
      location: LocationEntity.fromMap(map['location'] ?? {}),
      phone: map['phone'],
      email: map['email'],
      website: map['website'],
      socialMedia: Map<String, dynamic>.from(map['social_media'] ?? {}),
      hours: Map<String, dynamic>.from(map['hours'] ?? {}),
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['review_count'] ?? 0,
      amenities: List<String>.from(map['amenities'] ?? []),
      tags: List<String>.from(map['tags'] ?? []),
      ownerId: map['owner_id'] ?? '',
      isVerified: map['is_verified'] ?? false,
      isActive: map['is_active'] ?? true,
      isFeatured: map['is_featured'] ?? false,
      price: map['price']?.toDouble(),
      priceRange: map['price_range'],
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  // Helper methods for time operations
  String _getDayKey(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1: return 'monday';
      case 2: return 'tuesday';
      case 3: return 'wednesday';
      case 4: return 'thursday';
      case 5: return 'friday';
      case 6: return 'saturday';
      case 7: return 'sunday';
      default: return 'monday';
    }
  }

  bool _isTimeInRange(String currentTime, String openTime, String closeTime) {
    // Simple time comparison (assumes 24-hour format)
    final current = _timeToMinutes(currentTime);
    final open = _timeToMinutes(openTime);
    final close = _timeToMinutes(closeTime);
    
    if (close < open) {
      // Handles overnight hours (e.g., 22:00-02:00)
      return current >= open || current <= close;
    } else {
      return current >= open && current <= close;
    }
  }

  int _timeToMinutes(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return 0;
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    return hours * 60 + minutes;
  }

  @override
  String toString() {
    return 'BusinessEntity(id: $id, name: $name, category: $category, location: ${location.shortAddress}, rating: $rating)';
  }
}