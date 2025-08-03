# Inova+ App Challenge 🚀

**Inova+** é uma solução mobile multiplataforma desenvolvida em Flutter para a Eurofarma, criada pela equipe **MIT (Made in Technology)** da FIAP – 5º semestre de Sistemas de Informação.

---

## 📄 Sumário

- [Visão Geral](#visão-geral)  
- [Problema & Relevância](#problema--relevância)  
- [Solução Proposta](#solução-proposta)  
- [Funcionalidades Principais](#funcionalidades-principais)  
- [Tecnologias Utilizadas](#tecnologias-utilizadas)  
- [Público-Alvo](#público-alvo)  
- [Estrutura do Projeto](#estrutura-do-projeto)  
- [Como Rodar](#como-rodar)  
- [Time](#time)  
- [Contato](#contato)  

---

## 🔍 Visão Geral

O **Inova+** é um aplicativo focado em **Engajamento e Cultura de Inovação**. Ele permite que colaboradores de todos os níveis da Eurofarma:

- Submetam ideias inovadoras  
- Acompanhem o status das propostas em tempo real  
- Acumulem pontos e resgatem recompensas  
- Registrem presença em eventos via QR Code  
- Explorem ideias públicas de colegas  

---

## 🚩 Problema & Relevância

Colaboradores de grandes empresas frequentemente se sentem **desconectados** dos processos de inovação internos, seja por falta de canal único de comunicação, baixa percepção de pertencimento ou dificuldades de acesso. 

Segundo a FGV-EAESP (2023), **60%** dos profissionais brasileiros não se sentem engajados nos programas de inovação de suas empresas. O **Inova+** visa reverter esse cenário, democratizando o acesso e oferecendo recompensas claras e tangíveis.

---

## 💡 Solução Proposta

Aplicativo mobile (Flutter) com versão web responsiva, que oferece:

1. **Submissão de ideias** via texto (e futuro suporte a áudio)  
2. **Acompanhamento em tempo real** do status (em análise, aprovado, implementado)  
3. **Gamificação**: pontos, ranking e trocar por recompensas  
4. **Registro por QR Code** de participação em eventos  
5. **Exploração de ideias públicas** para feedback e interação  

---

## 🛠️ Funcionalidades Principais

- **Tela de Login** com autenticação simples  
- **Dashboard**: resumo de ideias, status e pontos  
- **Formulário “Submeter Ideia”** com título, descrição, categoria e upload de arquivo  
- **QR Code** para registrar presença em eventos  
- **Tela de Explorar**: lista scrollável de ideias de colegas, com curtidas e comentários  
- **Sistema de navegação** com `BottomNavigationBar` e animações suaves  
- **Feed de recompensas** para resgate de pontos  

---

## ⚙️ Tecnologias Utilizadas

- **Flutter & Dart** – UI multiplataforma  
- **CustomPainter** – Fundo de partículas animadas  
- **AnimationController** – Efeitos de toque e hover  
- **File Picker** (planejado) – Upload de arquivos  
- **Firebase** (futuro) – Autenticação, Firestore e notificações  
- **Rive / flare_flutter** (desejável) – Animações vetoriais  
- **simple_animations** – Transições suaves  

---

## 👥 Público-Alvo

- **Colaboradores administrativos** – fácil acesso via smartphone/web  
- **Equipes operacionais** – totens interativos e formulários simplificados  
- **Profissionais externos** – app leve, offline-friendly  

---

## 📂 Estrutura do Projeto

```
lib/
├── main.dart
├── pages/
│   ├── login_screen.dart
│   ├── inova_plus_page.dart
│   ├── submit_idea_page.dart
│   ├── qr_code_page.dart
│   ├── points_page.dart
│   └── explore_page.dart
└── widgets/
    ├── background_scaffold.dart
    ├── animated_logo_image.dart
    ├── touch_animated_button.dart
    └── app_bottom_nav.dart
assets/
└── images/
    ├── avatar.png
    ├── inova_logo.png
    ├── robo1.png … robo7.png
pubspec.yaml
```

---

## ▶️ Como Rodar

1. **Clone** este repositório  
2. Instale o Flutter SDK (stable) e adicione ao `PATH`  
3. No terminal, na raiz do projeto:
   ```bash
   flutter pub get
   flutter run
   ```
4. Escolha seu emulador ou dispositivo  
5. **Hot reload** a cada alteração para iterar rapidamente  

---

## 👩‍💻 Time MIT

- **Diogo Makoto Mano** – RM 98446  
- **Gabriel Valério Gouveia** – RM 552041  
- **Pablo S. R. Q. Aguayo** – RM 551548  
- **Thiago Ratão Passerini** – RM 551351  
- **Victor Espanhol Henrique Santos** – RM 552532  

---

## ✉️ Contato

Para dúvidas ou sugestões, entre em contato:

- 📧 **email@inovaplus.com**  
- 🌐 Intranet Eurofarma – seção “Inovação”  
- 📱 WhatsApp Group “Inova+ Challenge”

---

> Desenvolvido com ❤️ pela equipe **MIT** – FIAP (5º semestre, Sistemas de Informação)  
> São Paulo, 2025  
