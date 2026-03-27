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

## Notes

- Core kickstart-style editing defaults remain enabled.
- This repo stays Nix-first. It does not pull in Mason, Lazy, or another external plugin manager.
- If you already have another Neovim setup, use `NVIM_APPNAME` to keep configs separate.
