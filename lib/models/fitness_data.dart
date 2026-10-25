class Challenge {
  final String title;
  final String activity;
  final int completed;
  final int total;
  final double progress;

  Challenge({
    required this.title,
    required this.activity,
    required this.completed,
    required this.total,
    required this.progress,
  });

  factory Challenge.fromJson(Map<String, dynamic> j) => Challenge(
    title: j['title'] as String,
    activity: j['activity'] as String,
    completed: j['completed'] as int,
    total: j['total'] as int,
    progress: (j['progress'] as num).toDouble(),
  );
}

class FeaturedPlan {
  final String id;
  final String title;
  final String duration;
  final String frequency;
  final String actionLabel;
  final String imageUrl;

  FeaturedPlan({
    required this.id,
    required this.title,
    required this.duration,
    required this.frequency,
    required this.actionLabel,
    required this.imageUrl,
  });

  factory FeaturedPlan.fromJson(Map<String, dynamic> j) => FeaturedPlan(
    id: j['id'] as String,
    title: j['title'] as String,
    duration: j['duration'] as String,
    frequency: j['frequency'] as String,
    actionLabel: j['actionLabel'] as String,
    imageUrl: j['imageUrl'] as String,
  );
}

class FilterOption {
  final String id;
  final String name;
  final bool selected;

  FilterOption({
    required this.id,
    required this.name,
    required this.selected,
  });

  factory FilterOption.fromJson(Map<String, dynamic> j) => FilterOption(
    id: j['id'] as String,
    name: j['name'] as String,
    selected: j['selected'] as bool,
  );
}

class WorkoutItem {
  final String id;
  final String title;
  final int calories;
  final int durationMinutes;
  final bool isPro;
  final String imageUrl;

  WorkoutItem({
    required this.id,
    required this.title,
    required this.calories,
    required this.durationMinutes,
    required this.isPro,
    required this.imageUrl,
  });

  factory WorkoutItem.fromJson(Map<String, dynamic> j) => WorkoutItem(
    id: j['id'] as String,
    title: j['title'] as String,
    calories: j['calories'] as int,
    durationMinutes: j['durationMinutes'] as int,
    isPro: j['isPro'] as bool,
    imageUrl: j['imageUrl'] as String,
  );
}

class Amenity {
  final String id;
  final String name;

  Amenity({required this.id, required this.name});

  factory Amenity.fromJson(Map<String, dynamic> j) => Amenity(
    id: j['id'] as String,
    name: j['name'] as String,
  );
}

class Gym {
  final String name;
  final String location;
  final String heroImageUrl;
  final double rating;
  final int reviewCount;
  final String description;
  final List<Amenity> amenities;
  final double priceAmount;
  final String pricePeriod;
  final String reserveLabel;

  Gym({
    required this.name,
    required this.location,
    required this.heroImageUrl,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.amenities,
    required this.priceAmount,
    required this.pricePeriod,
    required this.reserveLabel,
  });

  factory Gym.fromJson(Map<String, dynamic> gym, Map<String, dynamic> actions) {
    final pricing = gym['pricing'] as Map<String, dynamic>;
    final reserve = actions['reserve'] as Map<String, dynamic>;
    return Gym(
      name: gym['name'] as String,
      location: gym['location'] as String,
      heroImageUrl: gym['heroImageUrl'] as String,
      rating: (gym['rating'] as num).toDouble(),
      reviewCount: gym['reviewCount'] as int,
      description: gym['description'] as String,
      amenities: (gym['amenities'] as List)
          .map((e) => Amenity.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceAmount: (pricing['amount'] as num).toDouble(),
      pricePeriod: pricing['period'] as String,
      reserveLabel: reserve['label'] as String,
    );
  }
}

class FitnessData {
  final String date;
  final String greeting;
  final Challenge challenge;
  final List<FeaturedPlan> featured;
  final List<FilterOption> filters;
  final List<WorkoutItem> items;
  final Gym gym;

  FitnessData({
    required this.date,
    required this.greeting,
    required this.challenge,
    required this.featured,
    required this.filters,
    required this.items,
    required this.gym,
  });

  factory FitnessData.fromJson(Map<String, dynamic> json) {
    final home = json['fitnessHomePage'] as Map<String, dynamic>;
    final header = home['header'] as Map<String, dynamic>;
    final programs = home['workoutPrograms'] as Map<String, dynamic>;
    final details = json['fitnessGymDetailsPage'] as Map<String, dynamic>;

    return FitnessData(
      date: header['date'] as String,
      greeting: header['greeting'] as String,
      challenge: Challenge.fromJson(
          home['todaysChallenge'] as Map<String, dynamic>),
      featured: (home['featuredPlans'] as List)
          .map((e) => FeaturedPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      filters: (programs['filters'] as List)
          .map((e) => FilterOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      items: (programs['items'] as List)
          .map((e) => WorkoutItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      gym: Gym.fromJson(
        details['gym'] as Map<String, dynamic>,
        details['actions'] as Map<String, dynamic>,
      ),
    );
  }
}