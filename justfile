test-local:
  bluebuild rebase --tempdir /var/tmp recipes/vauxite.yml

build recipe="vauxite":
  bluebuild build --tempdir /var/tmp recipes/{{recipe}}.yml

generate-iso:
  sudo bluebuild generate-iso --iso-name vauxite-latest.iso image ghcr.io/winblues/vauxite:latest

generate-local-iso:
  sudo bluebuild generate-iso --tempdir /var/tmp --iso-name vauxite-latest.iso recipe recipes/vauxite-base.yml
