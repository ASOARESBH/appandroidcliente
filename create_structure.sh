#!/bin/bash
# Script para criar a estrutura do projeto Flutter ChoppOn

echo "Criando estrutura do projeto Flutter..."

# Criar diretórios principais
mkdir -p lib/core/{constants,error,network,routes,utils}
mkdir -p lib/features/{auth,profile,dashboard,points,history,ranking,locations,admin}/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{pages,widgets,providers}}

# Criar arquivos base
touch lib/main.dart
touch lib/core/constants/app_colors.dart
touch lib/core/constants/app_strings.dart
touch lib/core/network/api_client.dart
touch lib/core/network/auth_interceptor.dart
touch lib/core/routes/app_router.dart

echo "Estrutura criada com sucesso!"
