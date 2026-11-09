# ATELIER — rotina pessoal (PWA + Supabase)

## O que esta versão faz
- Interface responsiva Old Money para desktop e iPhone.
- Login e cadastro com e-mail e senha pelo Supabase Auth.
- Tarefas, hábitos, XP, níveis, moedas, recompensas e histórico salvos no Supabase.
- Cada conta só pode acessar a própria linha de dados (RLS).
- Salvamento automático na nuvem e cópia local para recuperação/uso temporário.
- Instalação como PWA no iPhone e no Windows.

## 1. Criar o projeto Supabase
1. Crie um projeto em https://supabase.com/dashboard.
2. Abra SQL Editor > New query.
3. Copie e execute todo o conteúdo de `supabase/schema.sql`.
4. Em Project Settings > API Keys (ou no botão Connect), copie a Project URL e a Publishable key.
5. Cole os dois valores em `config.js` nos campos correspondentes. Não use a Secret key nem a service_role key.
6. Em Authentication > URL Configuration, defina Site URL como a URL de produção da Vercel (ex.: https://atelier-seuusuario.vercel.app) e adicione também essa URL em Redirect URLs. Durante testes, adicione `http://localhost:5500/**` se usar Live Server.
7. Em Authentication > Providers > Email, mantenha Email habilitado. Para o primeiro cadastro, confirme o e-mail recebido antes de entrar. O serviço padrão de e-mail do Supabase tem limites; para uso contínuo, configure SMTP próprio.

## 2. Publicar pelo GitHub + Vercel
1. Extraia o ZIP. A pasta `atelier-pwa` contém `index.html`, `config.js`, `manifest.webmanifest`, `sw.js`, `icon.svg` e `supabase/schema.sql`.
2. Crie um repositório no GitHub, por exemplo `atelier-rotina`.
3. Envie TODOS os arquivos e a pasta `supabase` para a raiz do repositório (não envie apenas o index.html).
4. Entre em https://vercel.com, escolha Add New > Project e importe `atelier-rotina`.
5. Em Framework Preset escolha Other. Root Directory `./`. Build Command deixe vazio (sem build). Output Directory `.`. Install Command deixe vazio.
6. Clique Deploy. A Vercel vai hospedar os arquivos estáticos e fornecer um endereço `*.vercel.app`.
7. Copie esse endereço e atualize Site URL e Redirect URLs no Supabase (passo 1.6).
8. Se mudar `config.js` depois de publicar, envie o commit ao GitHub; a Vercel fará novo deploy automaticamente.

## 3. Testar
1. Abra a URL Vercel e crie sua conta com e-mail e senha (mínimo 8 caracteres).
2. Confirme o e-mail, se solicitado, e entre.
3. Crie uma tarefa e marque-a como concluída; aguarde aparecer “Tudo salvo”.
4. Abra a mesma URL em outro navegador/dispositivo e entre com a mesma conta. Os dados devem aparecer.

## 4. Instalar
- iPhone: Safari > Compartilhar > Adicionar à Tela de Início.
- Windows 11: Edge > menu ⋯ > Aplicativos > Instalar este site como aplicativo.

## Segurança e limites
- `config.js` contém apenas Project URL e Publishable key, que são próprias para cliente/browser. A segurança dos dados é aplicada pelas políticas RLS criadas no SQL.
- Nunca publique `service_role` ou Secret key.
- Esta versão sincroniza o conjunto de dados da conta como um único documento JSON. Para uso pessoal em um usuário, é simples e adequado; não é um sistema multiusuário colaborativo.
- A cópia local serve como apoio, mas a nuvem Supabase é a fonte principal depois do login.
- Se o e-mail de confirmação não chegar, confira spam e os limites do serviço de e-mail padrão do Supabase. Para produção, configure SMTP.
