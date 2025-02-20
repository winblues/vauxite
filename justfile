test-local:
  bluebuild rebase --tempdir /var/tmp recipes/recipe.yml

generate-iso:
  sudo bluebuild generate-iso --iso-name vauxite-latest.iso image ghcr.io/winblues/vauxite:latest
