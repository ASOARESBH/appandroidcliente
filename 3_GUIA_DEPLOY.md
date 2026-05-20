# Guia de Deploy - ChoppOn App (Flutter)

Este guia descreve os passos necessários para compilar e publicar o aplicativo ChoppOn nas lojas Google Play Store (Android) e Apple App Store (iOS).

## Pré-requisitos

1.  **Flutter SDK** instalado (versão 3.19 ou superior).
2.  **Android Studio** instalado e configurado.
3.  **Xcode** instalado (apenas para macOS, necessário para compilar para iOS).
4.  Conta de desenvolvedor ativa na **Google Play Console**.
5.  Conta de desenvolvedor ativa na **Apple Developer Program**.

---

## 1. Configuração do Ambiente (Firebase)

Antes de compilar, certifique-se de que o Firebase está configurado corretamente para ambos os ambientes:

1.  Instale o Firebase CLI: `npm install -g firebase-tools`
2.  Faça login: `firebase login`
3.  Ative o FlutterFire CLI: `dart pub global activate flutterfire_cli`
4.  Configure o projeto: `flutterfire configure --project choppon-app-id`
    *(Isso irá gerar o arquivo `lib/firebase_options.dart`)*

---

## 2. Deploy para Android (Google Play Store)

### 2.1. Configurar Assinatura (Keystore)

1.  Gere uma chave de upload (se ainda não tiver):
    ```bash
    keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
    ```
2.  Crie o arquivo `android/key.properties` com as credenciais:
    ```properties
    storePassword=sua_senha_aqui
    keyPassword=sua_senha_aqui
    keyAlias=upload
    storeFile=/caminho/absoluto/para/upload-keystore.jks
    ```
3.  O arquivo `android/app/build.gradle` já está configurado para ler este arquivo no projeto base.

### 2.2. Atualizar Versão

No arquivo `pubspec.yaml`, atualize a versão antes de cada build:
```yaml
version: 1.0.1+2 # 1.0.1 é a versão visível, +2 é o build number (deve ser incrementado a cada envio)
```

### 2.3. Gerar o App Bundle (AAB)

Execute o comando no terminal na raiz do projeto:
```bash
flutter build appbundle --release
```
O arquivo gerado estará em: `build/app/outputs/bundle/release/app-release.aab`

### 2.4. Publicar na Play Console

1.  Acesse o [Google Play Console](https://play.google.com/console).
2.  Selecione o app ChoppOn.
3.  Vá em **Produção** > **Criar nova versão**.
4.  Faça o upload do arquivo `.aab` gerado.
5.  Preencha as notas de lançamento e envie para revisão.

---

## 3. Deploy para iOS (Apple App Store)

*Nota: É obrigatório usar um Mac com Xcode para esta etapa.*

### 3.1. Configurar Certificados e Provisioning Profiles

1.  Abra o projeto no Xcode: `open ios/Runner.xcworkspace`
2.  Vá em **Runner** > **Signing & Capabilities**.
3.  Marque "Automatically manage signing".
4.  Selecione seu Team (sua conta Apple Developer).
5.  Certifique-se de que o Bundle Identifier está correto (ex: `br.com.choppon.app`).

### 3.2. Atualizar Versão

A versão do iOS também é lida do `pubspec.yaml`. Certifique-se de ter atualizado conforme o passo 2.2.

### 3.3. Gerar o Arquivo IPA

Execute o comando no terminal na raiz do projeto:
```bash
flutter build ipa --release
```
O arquivo gerado estará em: `build/ios/ipa/choppon_app.ipa`

### 3.4. Publicar no App Store Connect

1.  Abra o aplicativo **Transporter** no seu Mac (baixe na Mac App Store se não tiver).
2.  Faça login com sua conta Apple Developer.
3.  Arraste o arquivo `.ipa` gerado para o Transporter e clique em **Deliver**.
4.  Acesse o [App Store Connect](https://appstoreconnect.apple.com/).
5.  Vá em **Meus Apps** > ChoppOn.
6.  Crie uma nova versão, selecione a build que você acabou de enviar, preencha as informações e envie para revisão.

---

## 4. Dicas de Performance e Segurança

*   **Ofuscação de Código**: O Flutter já ofusca o código Dart por padrão no modo release. Para ofuscar o código nativo Android, adicione `--obfuscate --split-debug-info=./debug-info` ao comando de build.
*   **Permissões**: Verifique se todas as permissões necessárias (Bluetooth, Localização, Câmera) estão declaradas no `AndroidManifest.xml` e `Info.plist` com as devidas justificativas.
