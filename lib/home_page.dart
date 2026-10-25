import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/fitness_cubit.dart';
import 'cubit/fitness_state.dart';
import 'fitness_page.dart';
import 'models/fitness_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const green = Color(0xFF20C765);
  static const dark = Color(0xFF111116);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // STATUS BAR - ORA, WIFI, BATERIE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '9:41',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 18,
                        height: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(width: 3, height: 4, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(1))),
                            const SizedBox(width: 1.5),
                            Container(width: 3, height: 6, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(1))),
                            const SizedBox(width: 1.5),
                            Container(width: 3, height: 9, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(1))),
                            const SizedBox(width: 1.5),
                            Container(width: 3, height: 12, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(1))),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.wifi, size: 16, color: Colors.black),
                      const SizedBox(width: 6),
                      Row(
                        children: [
                          Container(
                            width: 22,
                            height: 11,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        bottomLeft: Radius.circular(2),
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(flex: 2, child: SizedBox()),
                              ],
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ============================================
              // TOT CE URMEAZĂ DEPINDE DE STARE (BlocBuilder)
              // ============================================
              BlocBuilder<FitnessCubit, FitnessState>(
                builder: (context, state) {
                  final cubit = context.read<FitnessCubit>();

                  // LOADING
                  if (state is FitnessLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(60),
                        child: CircularProgressIndicator(color: green),
                      ),
                    );
                  }

                  // ERROR
                  if (state is FitnessError) {
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          const Icon(Icons.error_outline,
                              size: 48, color: Colors.red),
                          const SizedBox(height: 10),
                          Text(state.message),
                          TextButton(
                            onPressed: cubit.load,
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: green),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // SUCCESS sau EMPTY
                  final d = cubit.data;
                  final list =
                  state is FitnessSuccess ? state.items : <WorkoutItem>[];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d.date,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8C8C96),
                        ),
                      ),

                      const SizedBox(height: 5),

                      // HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            d.greeting,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFE2E2E5),
                              ),
                            ),
                            child: const Icon(
                              Icons.notifications_none_rounded,
                              size: 22,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // TODAY'S CHALLENGE
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: dark,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    d.challenge.title,
                                    style: const TextStyle(
                                      color: Color(0xFF9D9DA6),
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    d.challenge.activity,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 47,
                              height: 47,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    value: d.challenge.progress,
                                    strokeWidth: 4,
                                    backgroundColor: const Color(0xFF33333A),
                                    valueColor:
                                    const AlwaysStoppedAnimation<Color>(
                                        green),
                                  ),
                                  Text(
                                    '${d.challenge.completed}/${d.challenge.total}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 23),

                      // FEATURED PLAN
                      const Text(
                        'Featured Plan',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 130,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (final p in d.featured)
                              Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: SizedBox(
                                  width: 270,
                                  child: _featuredCard(p, d, context),
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // WORKOUT PROGRAMS
                      const Text(
                        'Workout Programs',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // CĂUTARE
                      TextField(
                        onChanged: cubit.search,
                        decoration: InputDecoration(
                          hintText: 'Search workouts',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // SORTARE + FAVORITE
                      Row(
                        children: [
                          PopupMenuButton<SortBy>(
                            onSelected: cubit.changeSort,
                            itemBuilder: (_) => const [
                              PopupMenuItem(
                                  value: SortBy.none, child: Text('Default')),
                              PopupMenuItem(
                                  value: SortBy.calories,
                                  child: Text('Calories')),
                              PopupMenuItem(
                                  value: SortBy.duration,
                                  child: Text('Duration')),
                              PopupMenuItem(
                                  value: SortBy.title, child: Text('Title')),
                            ],
                            child: Row(
                              children: [
                                const Icon(Icons.sort, color: green),
                                const SizedBox(width: 4),
                                Text('Sort: ${cubit.sort.name}'),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: cubit.toggleOnlyFavorites,
                            icon: Icon(
                              cubit.onlyFavorites
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: cubit.onlyFavorites
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      // FILTRE (din JSON)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (final f in d.filters)
                              _filterButton(
                                f.name,
                                f.id == cubit.filterId,
                                    () => cubit.selectFilter(f.id),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // EMPTY sau LISTA
                      if (state is FitnessEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Text('Niciun antrenament găsit.'),
                          ),
                        )
                      else
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            mainAxisExtent: 165,
                          ),
                          itemBuilder: (_, i) =>
                              _workoutCard(list[i], d, context),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // CARD FEATURED
  // ------------------------------------------------------------------
  Widget _featuredCard(FeaturedPlan p, FitnessData d, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FitnessPage(gym: d.gym)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFDDDDDD),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(p.imageUrl),
            fit: BoxFit.cover,
            onError: (_, __) {},
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.28),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  const Icon(
                    Icons.fitness_center,
                    size: 13,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${p.duration}  •  ${p.frequency}',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  p.actionLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // BUTON FILTRU
  // ------------------------------------------------------------------
  Widget _filterButton(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 9),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: selected ? green : Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: selected ? green : const Color(0xFFE0E0E4),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF8B8B94),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // CARD WORKOUT (cu favorite)
  // ------------------------------------------------------------------
  Widget _workoutCard(WorkoutItem w, FitnessData d, BuildContext context) {
    final cubit = context.read<FitnessCubit>();
    final fav = cubit.isFavorite(w.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FitnessPage(gym: d.gym)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFDDDDDD),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(w.imageUrl),
            fit: BoxFit.cover,
            onError: (_, __) {},
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.28),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Favorite
            Positioned(
              top: 6,
              left: 6,
              child: GestureDetector(
                onTap: () => cubit.toggleFavorite(w.id),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    fav ? Icons.favorite : Icons.favorite_border,
                    size: 16,
                    color: fav ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),

            // Pro
            if (w.isPro)
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.workspace_premium, size: 11, color: green),
                      SizedBox(width: 3),
                      Text(
                        'Pro',
                        style: TextStyle(
                          color: green,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Titlu + info
            Positioned(
              left: 12,
              right: 8,
              bottom: 13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    w.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department_outlined,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${w.calories} kcal',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 9),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 11,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${w.durationMinutes} min',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 9),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}