# kickstart.nixvim

Personal fork of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) translated into Nixvim.

This repo aims to stay:

- simple
- legible
- reproducible
- easy to extend
- conservative in behavior

The shared base config is always-on and keeps the current plugin split without extra feature-selection layers.

## Supported Use Cases

| Use case | What you get |
| --- | --- |
| Standalone | A bundled `nvim` executable from this flake |
| NixOS module | `programs.nixvim` configuration for NixOS |
| Home Manager | `programs.nixvim` configuration for Home Manager |
| nix-darwin | `programs.nixvim` configuration for nix-darwin |

## External Dependencies

- `git`
- A clipboard provider appropriate for your platform
- A [Nerd Font](https://www.nerdfonts.com/) if you want icon support
- Language toolchains you actually use, for example `go`, `npm`, or `cargo`

## Standalone

Run directly from GitHub:

```sh
nix run github:shaoyanji/kickstart.nixvim -- <FILE>
```

Build locally:

```sh
nix build .#
./result/bin/nvim <FILE>
```

For standalone tweaks, edit [`config/default.nix`](/workspaces/kickstart.nixvim/config/default.nix).

## Module Usage

Add the input to your flake:

```nix
inputs.kickstart-nixvim.url = "github:shaoyanji/kickstart.nixvim";
```

### NixOS

```nix
{
  imports = [
    inputs.kickstart-nixvim.nixosModules.default
  ];

  programs.nixvim = {
    enable = true;
  };
}
```

### Home Manager

```nix
{
  imports = [
    inputs.kickstart-nixvim.homeManagerModules.default
  ];

  programs.nixvim = {
    enable = true;
  };
}
```

### nix-darwin

```nix
{
  imports = [
    inputs.kickstart-nixvim.darwinModules.default
  ];

  programs.nixvim = {
    enable = true;
  };
}
```

Example for a local checkout:

```nix
inputs.kickstart-nixvim.url = "path:/absolute/path/to/kickstart.nixvim";
```

## Shared Base

- The shared base is the module exported by this flake and imported through [`nixvim.nix`](/workspaces/kickstart.nixvim/nixvim.nix).
- It is expected to `nix build`, `nix flake check`, and start headlessly without local machine assumptions.
- Local-only plugins are not imported there by default.

## Local-Only Modules

- Put machine-specific plugins in a host-local or Home Manager module and import them yourself.
- Copy from [`examples/local/obsidian.nix`](/workspaces/kickstart.nixvim/examples/local/obsidian.nix) and [`examples/local/supermaven.nix`](/workspaces/kickstart.nixvim/examples/local/supermaven.nix) for minimal local-only patterns.
- The shared base does not import `examples/` or user-specific plugins such as Obsidian or Supermaven.

Example:

```nix
{
  imports = [
    inputs.kickstart-nixvim.homeManagerModules.default
    ./local/obsidian.nix
    ./local/supermaven.nix
  ];

  programs.nixvim.enable = true;
}
```

## Validation

```sh
nix build .#
nix flake check
XDG_DATA_HOME=/tmp/kickstart-nixvim-data \
XDG_STATE_HOME=/tmp/kickstart-nixvim-state \
XDG_CACHE_HOME=/tmp/kickstart-nixvim-cache \
./result/bin/nvim --headless '+quit'
```

## Notes

- Core kickstart-style editing defaults remain enabled.
- This repo stays Nix-first. It does not pull in Mason, Lazy, or another external plugin manager.
- If you already have another Neovim setup, use `NVIM_APPNAME` to keep configs separate.
- Included UX additions stay thin and always-on: Trouble under `<leader>x`, Toggleterm under `<leader>t`, and persistence session restore under `<leader>S`.
- Extra editor UX stays conservative: `yanky` adds `<leader>sy` plus yank-ring cycling on `[y`/`]y`, `flash` adds jump/search under `<leader>sj` and `<leader>sJ`, `treesj` adds syntax-aware split/join on `gS`/`gJ`, `mini-surround` keeps the upstream `sa`/`sd`/`sr` surround motions, `mini-ai` adds the upstream `a`/`i` textobjects, `illuminate` adds low-noise symbol highlighting, `diffview` adds `<leader>gd` and `<leader>gH` for repo/file diff views, `neogit` adds `<leader>gg` for git status, and `dressing` lightly polishes `vim.ui`.
- `blink-cmp-git` is wired into Blink completion for `gitcommit` buffers without changing the default source list elsewhere.
