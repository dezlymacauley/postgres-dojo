# Postgres Dojo
_______________________________________________________________________________

<img src="postgres_dojo.png" alt="Cover Image" height="250" width="250" />

A pre-built, terminal-centric setup for anyone who wants to practice Postgres
without the hassle of installing it locally.

All you need is Docker and you're ready to go.
_______________________________________________________________________________
### Usage

Run the setup scripts:
```sh
bash scripts/01_create_docker_image.sh
bash scripts/02_create_container_instance.sh
```

Make the main script executable
```sh
chmod +x postgres_dojo.sh
```

Start Postgres Dojo using pgcli
```sh
./postgres_dojo
```
_______________________________________________________________________________
### List of CLI tools used in `Postgres Dojo`

_______________________________________________________________________________
