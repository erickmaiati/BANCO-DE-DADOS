Deploy recomendado (Render.com) — Backend Java

1) Preparar repositório
- O projeto já possui Dockerfile e agora também inclui o arquivo `render.yaml` para deploy direto no Render.

2) Criar serviço no Render
- Tipo: "Web Service"
- Environment: Docker
- Conecte o repositório GitHub e selecione a pasta `erp-system` como root do serviço.
- O Render usará o `Dockerfile` e o endpoint `/health` para checagem de saúde.

3) Variáveis de ambiente necessárias
- `SPRING_DATASOURCE_URL` = `jdbc:postgresql://<HOST>:5432/<DBNAME>`
- `SPRING_DATASOURCE_USERNAME` = `<db_user>`
- `SPRING_DATASOURCE_PASSWORD` = `<db_pass>`
- `JWT_SECRET` = chave secreta forte
- `SPRING_PROFILES_ACTIVE` = `prod`
- `PORT` = `8080`

4) Banco de dados
- Crie um banco PostgreSQL gerenciado (Render, Supabase, ElephantSQL ou outro).
- Aponte `SPRING_DATASOURCE_URL` para esse banco.

5) CORS / Frontend
- No frontend, defina `VITE_API_BASE_URL` para a URL do serviço Render (ex.: `https://erp-system-backend.onrender.com`).

6) Teste local com Docker
```bash
cd erp-system
docker build -t erp-backend .
docker run -e SPRING_DATASOURCE_URL=jdbc:postgresql://host:5432/db -e SPRING_DATASOURCE_USERNAME=user -e SPRING_DATASOURCE_PASSWORD=pass -p 8080:8080 erp-backend
```

7) Observações
- O endpoint `/health` deve responder com `{"status":"UP"}` quando o app estiver online.
- Em produção, use PostgreSQL e mantenha `ddl-auto: validate`.
- Defina `JWT_SECRET` forte e não deixe o padrão.
