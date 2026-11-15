# kickstart.nixvim — minimal

A small Neovim configuration built on [nixvim](https://github.com/nix-community/nixvim):
one core module, six plugin modules, no plugin manager, no Mason, no `lazy.nvim`.
Every plugin and grammar is a Nix derivation from the pinned nixpkgs, so a fresh
machine reproduces the editor exactly.

## Use it

As a Home Manager module (nixpkgs input follows are the consumer's business):

```nix
{
  inputs.kickstart-nixvim.url = "github:shaoyanji/kickstart.nixvim";
  # ...
  imports = [inputs.kickstart-nixvim.homeManagerModules.default];
  programs.nixvim.enable = true;
}
```

`nixosModules.default` and `darwinModules.default` are the same module for the
other two hosts.

Standalone, with nothing else installed:

```bash
nix run github:shaoyanji/kickstart.nixvim
```

## What is in it

| Path | Contents |
| :--- | :--- |
| `nixvim.nix` | the import list, options, keymaps, yank highlight, diagnostics |
| `config/plugins/lsp.nix` | `nixd` (alejandra formatting) and `lua_ls`, plus lazydev |
| `config/plugins/cmp.nix` | blink.cmp on the Lua matcher, sources `lsp` `path` `snippets` |
| `config/plugins/treesitter.nix` | sixteen nixpkgs grammars, native indent |
| `config/plugins/telescope.nix` | picker with `fzf-native` and `ui-select` |
| `config/plugins/conform.nix` | format on save, stylua for Lua, LSP fallback |
| `config/plugins/ui.nix` | which-key, mini.statusline/pairs/surround, gitsigns |
| `config/plugins/custom/` | taste and machine-local: cloak, typst, local-model completion |

LSP keymaps are not defined here: Neovim 0.11 added `K`, `grn`, `gra`, `grr`,
`gri`, `gO`, and 0.12 keeps them. What is left is this config's own choices:

| Key | Action |
| :--- | :--- |
| `<leader>sf` / `sg` / `sd` / `sk` / `sh` | files, grep, diagnostics, keymaps, help |
| `<leader><leader>` | open buffers |
| `<leader>f` | format buffer |
| `<leader>q` | diagnostics to quickfix |
| `<leader>bd` | delete buffer |
| `]c` / `[c` | next / previous git hunk |
| `<C-hjkl>` | window focus |
| `<Esc>` | clear search highlight |
| `<A-a>` / `<A-l>` / `<A-]` / `<A-[>` | accept / accept line / next / previous ghost text |

## Completion from a local model

`config/plugins/custom/ai.nix` puts [minuet](https://github.com/milanglacier/minuet-ai.nvim)
ghost text in front of any OpenAI-compatible FIM server — no cloud account, no
token, no login. It reads two variables, so the endpoint is a per-machine fact
rather than a committed one:

```lua
vim.env.MINUET_ENDPOINT  -- default http://eisen.lan/v1/completions
vim.env.MINUET_MODEL     -- default qwen3.6-35b-a3b
```

With no server answering, one request fails and the editor works as if the
plugin were not installed. To route ghost text through blink.cmp's menu instead
of virtual text, add a provider named `minuet` with module `minuet.blink` to
`config/plugins/cmp.nix`; the two are independent.

## Check

```bash
nix flake check     # builds the editor, starts it headless, runs it as a test
nix fmt             # alejandra
```

CI runs `nix flake check` on push to `main` (`.github/workflows/ci.yml`).
