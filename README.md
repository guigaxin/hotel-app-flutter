# Controle de Hóspedes - Hotel App

Aplicativo Flutter desenvolvido para gerenciamento local de registros de hóspedes na disciplina CMP2304 - Tecnologia de Construção de Software I.

## Funcionalidades

- Listagem de hóspedes em memória exibindo nome, quarto e tipo de acomodação
- Cadastro de novos registros em formulário dedicado
- Edição de registros existentes sem duplicação
- Exclusão de registros com caixa de confirmação
- Validação de campos obrigatórios contra entradas vazias ou apenas espaços

## Estrutura do Projeto

- `lib/main.dart`: Código-fonte principal da aplicação (telas, gerenciamento de estado com `StatefulWidget` e navegação)
- `pubspec.yaml`: Configuração e dependências do projeto Flutter
- `test/widget_test.dart`: Testes de widget do aplicativo

## Como Executar

1. Certifique-se de ter o SDK do Flutter instalado.
2. Na pasta raiz do projeto, baixe as dependências:
   ```bash
   flutter pub get