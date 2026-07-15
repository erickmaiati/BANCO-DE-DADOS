Deploy recomendado (Render.com) — Backend Java

1) Preparar repositório
- Garanta que o `Dockerfile` esteja em `erp-system/erp-system/Dockerfile` (já incluído).

2) Criar serviço no Render
- Tipo: "Web Service"
- Environment: Docker
- Conecte o repo GitHub e selecione o diretório `erp-system/erp-system` como root (ou use o caminho padrão se o repo apontar direto para o módulo).
- Build command: (quando usar Docker, Render fará "docker build .")
- Start command: (usado apenas se não usar Docker) `java -jar target/erp-system-0.0.1-SNAPSHOT.jar`

3) Variáveis de ambiente necessárias
- `SPRING_DATASOURCE_URL` = e.g. `jdbc:postgresql://<HOST>:5432/<DBNAME>`
- `SPRING_DATASOURCE_USERNAME` = `<db_user>`
- `SPRING_DATASOURCE_PASSWORD` = `<db_pass>`
- `JWT_SECRET` = chave secreta forte
- `SPRING_PROFILES_ACTIVE` = `prod`
- `PORT` = `8080` (opcional, o provedor pode sobrescrever)

4) Banco de dados
- Crie um banco PostgreSQL gerenciado (Render, Supabase, ElephantSQL, Heroku Postgres).
- Aponte `SPRING_DATASOURCE_URL` para o banco criado.

5) CORS / Frontend
- No Netlify, defina `VITE_API_BASE_URL` para a URL do serviço Render (ex: `https://erp-backend.onrender.com`).

6) Teste local com Docker
- Build localmente:

```bash
cd erp-system/erp-system
docker build -t erp-backend .
```

- Executar com banco local (exemplo PostgreSQL local):

```bash
docker run -e SPRING_DATASOURCE_URL=jdbc:postgresql://host:5432/db -e SPRING_DATASOURCE_USERNAME=user -e SPRING_DATASOURCE_PASSWORD=pass -p 8080:8080 erp-backend
```

7) Observações
- Em produção, troque H2 por Postgres e remova `ddl-auto: update` (use Flyway/Liquibase e `ddl-auto: validate`).
- Defina `JWT_SECRET` forte e não deixe padrão.
- Recomendo usar HTTPS e configurar um domínio personalizado no Netlify apontando para o domínio do backend via CORS/variáveis.
