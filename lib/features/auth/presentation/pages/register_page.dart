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
  bool _obscureSenha = true;
  bool _obscureConfirm = true;

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
                TextField(decoration: InputDecoration(labelText: 'Nome Completo', border: OutlineInputBorder())),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'CPF', border: OutlineInputBorder())),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'Data de Nascimento', border: OutlineInputBorder())),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'RG', border: OutlineInputBorder())),
              ],
            ),
          ),
          Step(
            title: const Text('Contato'),
            isActive: _currentStep >= 1,
            content: Column(
              children: const [
                TextField(decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'WhatsApp', border: OutlineInputBorder())),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'CEP', border: OutlineInputBorder())),
                SizedBox(height: 16),
                TextField(decoration: InputDecoration(labelText: 'Endereço', border: OutlineInputBorder())),
              ],
            ),
          ),
          Step(
            title: const Text('Senha'),
            isActive: _currentStep >= 2,
            content: Column(
              children: [
                TextField(
                  obscureText: _obscureSenha,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureSenha ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscureSenha = !_obscureSenha),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
