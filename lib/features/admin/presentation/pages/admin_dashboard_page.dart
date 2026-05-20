import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Técnico'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.go('/login');
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            color: Colors.amber,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Acesso Master Ativo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Você está logado como Administrador. Tenha cuidado ao alterar configurações.',
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Ferramentas da TAP',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildAdminCard(
            icon: Icons.bluetooth_searching,
            title: 'Parear Nova TAP',
            subtitle: 'Conectar ESP32 via Bluetooth',
            onTap: () {},
          ),
          _buildAdminCard(
            icon: Icons.tune,
            title: 'Calibrar Pulsos',
            subtitle: 'Ajustar conversão de pulsos para ML',
            onTap: () {},
          ),
          _buildAdminCard(
            icon: Icons.timer,
            title: 'Tempo de Abertura',
            subtitle: 'Configurar timeout da válvula',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Text(
            'Gerenciamento',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildAdminCard(
            icon: Icons.local_drink,
            title: 'Bebidas e Preços',
            subtitle: 'Atualizar cardápio da unidade',
            onTap: () {},
          ),
          _buildAdminCard(
            icon: Icons.credit_card,
            title: 'Leitoras de Cartão',
            subtitle: 'Configurar SumUp / Mercado Pago',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAdminCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black12,
          child: Icon(icon, color: Colors.black),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
