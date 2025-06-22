### Gitea

### Setup server and database (postgres)

- docker-compose.yml

```yml
version: "3"

networks:
  gitea:
    external: false

services:
  server:
    image: docker.gitea.com/gitea:1.24.1-rootless
    container_name: gitea
    environment:
      - USER_UID=1000
      - USER_GID=1000
      - GITEA__database__DB_TYPE=postgres
      - GITEA__database__HOST=db:5432
      - GITEA__database__NAME=gitea
      - GITEA__database__USER=gitea
      - GITEA__database__PASSWD=gitea
    restart: always
    networks:
      - gitea
    volumes:
      - ./gitea:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - "3000:3000"
      - "2222:2222"
    depends_on:
      - db

  db:
    image: postgres
    restart: always
    environment:
      - POSTGRES_USER=gitea
      - POSTGRES_PASSWORD=gitea
      - POSTGRES_DB=gitea
    networks:
      - gitea
    volumes:
      - ./postgres:/var/lib/postgresql/data

  runner:
    image: docker.io/gitea/act_runner:latest
    environment:
      CONFIG_FILE: /config.yaml
      GITEA_INSTANCE_URL: "http://gitea:3000"
      GITEA_RUNNER_REGISTRATION_TOKEN: "<TOKEN>"
      GITEA_RUNNER_NAME: "Gitea Runner"
    depends_on:
      - server
      - db
    networks:
      - gitea
    volumes:
      - ./runner-config.yml:/config.yml
      - ./runner:/data
      - /var/run/docker.sock:/var/run/docker.sock

```

### Setup Runner

- generate ```.runner-config.yml``` file

```bash
docker run --entrypoint="" --rm -it docker.io/gitea/act_runner:latest act_runner generate-config > runner-config.yml
```

### Example of action (using dotnet)

The files needs to be inside the ```<project-folder>/.gitea/workflows/```

- build-test.yml

```yml
name: Build and Test
run-name: ${{ gitea.actor }} is building and testing the ${{ gitea.repository }}
on: [push, pull_request]

jobs:
  Build-Test:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🎉 The job was automatically triggered by a ${{ gitea.event_name }} event."
      - run: echo "🐧 This job is now running on a ${{ runner.os }} server hosted by Gitea!"
      - run: echo "🔎 The name of your branch is ${{ gitea.ref }} and your repository is ${{ gitea.repository }}"
      - name: Check out repository code
        uses: actions/checkout@v4
      - run: echo "💡 The ${{ gitea.repository }} repository has been cloned to the runner."
      - name: Setup dotnet
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: 9.x
      - run: echo "🖥️ The workflow is now ready to restore the code on the runner."
      - name: Restore dependencies
        run: dotnet restore --verbosity detailed
      - name: Build (Solution)
        run: dotnet build --no-restore --verbosity detailed
      - name: Test
        run: dotnet test --no-build --verbosity detailed
      - run: echo "Test completed!"

```

- deploy.yml (TBD)
