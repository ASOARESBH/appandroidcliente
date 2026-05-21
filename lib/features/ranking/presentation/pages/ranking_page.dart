import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:choppon_app/core/constants/app_colors.dart';

class RankingPage extends ConsumerStatefulWidget {
  const RankingPage({super.key});

  @override
  ConsumerState<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends ConsumerState<RankingPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.amber,
          tabs: const [
            Tab(text: 'Nacional'),
            Tab(text: 'Minha Cidade'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRankingList(isNacional: true),
          _buildRankingList(isNacional: false),
        ],
      ),
    );
  }

  Widget _buildRankingList({required bool isNacional}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        final isTop3 = index < 3;
        Color medalColor;
        if (index == 0) medalColor = Colors.amber;
        else if (index == 1) medalColor = Colors.grey[400]!;
        else if (index == 2) medalColor = Colors.brown[300]!;
        else medalColor = Colors.transparent;

        return Card(
          elevation: isTop3 ? 4 : 1,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isTop3 ? BorderSide(color: medalColor, width: 2) : BorderSide.none,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '#${index + 1}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isTop3 ? medalColor : Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/default_avatar.png'),
                ),
              ],
            ),
            title: Text(
              'Usuário ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(isNacional ? 'São Paulo - SP' : 'Unidade Centro'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${10000 - (index * 500)} pts',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
                if (isTop3)
                  Icon(Icons.emoji_events, color: medalColor, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
