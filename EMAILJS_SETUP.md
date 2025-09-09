# Configuração do EmailJS

## Passos para configurar o envio de emails:

### 1. Criar conta no EmailJS
- Acesse https://www.emailjs.com/
- Crie uma conta gratuita

### 2. Configurar serviço de email
- No painel do EmailJS, vá em "Email Services"
- Adicione um novo serviço (Gmail, Outlook, etc.)
- Configure com suas credenciais de email
- Anote o **Service ID**

### 3. Criar template de email
- Vá em "Email Templates"
- Crie um novo template
- Use as seguintes variáveis no template:
  - `{{from_name}}` - Email do remetente
  - `{{from_email}}` - Email do remetente
  - `{{subject}}` - Assunto da mensagem
  - `{{message}}` - Conteúdo da mensagem
- **IMPORTANTE:** Configure o destinatário fixo no template como `hugo.flutterdev@gmail.com`
- Anote o **Template ID**

**Exemplo de template:**
```
De: {{from_name}} ({{from_email}})
Assunto: {{subject}}

Mensagem:
{{message}}
```

### 4. Obter chaves de API
- Vá em "Account" > "General"
- Anote o **Public Key**
- (Opcional) Anote o **Private Key** para maior segurança

### 5. Ativar API para apps não-browser
- Vá em "Account" > "Security"
- Marque "Allow EmailJS API for non-browser applications"
- **IMPORTANTE:** Esta etapa é obrigatória para apps Flutter!

### 6. Atualizar o código
No arquivo `lib/pages/contact_page.dart`, substitua os seguintes valores:

```dart
// Linha 137-140: Configuração global (já implementada)
emailjs.init(const emailjs.Options(
  publicKey: 'msPJ93QWu5VsWtWai', // ← Já configurado
  // privateKey: 'YOUR_PRIVATE_KEY', // ← Adicione se tiver
));

// Linha 181-185: Envio do email (já implementado)
await emailjs.send(
  'service_hg2cs4v', // ← Já configurado
  'template_s1ko309', // ← Já configurado
  templateParams,
);
```

**Se quiser usar Private Key (recomendado):**
- Descomente a linha `privateKey` na configuração global
- Substitua `YOUR_PRIVATE_KEY` pela sua chave privada

### 7. Testar
- Execute o app
- Preencha o formulário de contato
- Clique em "Enviar"
- Verifique se o email chegou em personaldogjr@gmail.com

## Limitações do plano gratuito:
- 200 emails por mês
- 2 serviços de email
- 2 templates de email
