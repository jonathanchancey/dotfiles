return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://kubernetes-schemas.pages.dev/helm.toolkit.fluxcd.io/helmrelease_v2.json"] = "**/helmrelease.yaml",
              ["https://kubernetes-schemas.pages.dev/source.toolkit.fluxcd.io/ocirepository_v1.json"] = "**/ocirepository.yaml",
              ["https://kubernetes-schemas.pages.dev/kustomize.toolkit.fluxcd.io/kustomization_v1.json"] = "ks.yaml",
              ["https://json.schemastore.org/kustomization"] = "kustomization.yaml",
            },
          },
        },
      },
    },
  },
}
