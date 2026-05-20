import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          } else {
            // Finalizar cadastro
            context.go('/dashboard');
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            context.pop();
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(_currentStep == 2 ? 'FINALIZAR' : 'PRÓXIMO'),
                  ),
                ),
                const SizedBox(width: 16),
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('VOLTAR'),
                    ),
                  ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Dados Pessoais'),
            isActive: _currentStep >= 0,
            content: Column(
              children: const [
                TextField(decoration: InputDecoration(labelText: 'Nome Completo')),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'CPF')),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'Data de Nascimento')),
              ],
            ),
          ),
          Step(
            title: const Text('Contato'),
            isActive: _currentStep >= 1,
            content: Column(
              children: const [
                TextField(decoration: InputDecoration(labelText: 'Email')),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'WhatsApp')),
              ],
            ),
          ),
          Step(
            title: const Text('Endereço e Senha'),
            isActive: _currentStep >= 2,
            content: Column(
              children: const [
                TextField(decoration: InputDecoration(labelText: 'CEP')),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'Senha', obscureText: true)),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'Confirmar Senha', obscureText: true)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
