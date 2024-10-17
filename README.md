# Jane Street Real-Time Market Data Forecasting Environment

This repository contains a Nix flake for setting up the development environment for the Jane Street Real-Time Market Data Forecasting Kaggle competition. It does not contain any competition code or datasets.

## Important Notes

- This repository does not include any code solutions for the competition.
- No competition datasets are stored in this repository.
- You must set up your Kaggle API credentials before using this environment.

## Prerequisites

1. Install Nix package manager: https://nixos.org/download.html
2. Enable Nix flakes by adding the following to your `~/.config/nix/nix.conf`:
   ```
   experimental-features = nix-command flakes
   ```
3. Set up your Kaggle API credentials:
   - Go to https://www.kaggle.com/settings/account
   - Create a new API token
   - Download the `kaggle.json` file
   - Place it in `~/.kaggle/kaggle.json`
   - Ensure the file permissions are secure: `chmod 600 ~/.kaggle/kaggle.json`

## Using the Flake

To enter the development environment using this flake directly from GitHub:

```bash
nix develop github:johnbarnes-vi/janestreet-kaggle-dev-flake
```

This command will:
1. Download and set up all required dependencies
2. Create a Python environment with all necessary packages
3. Set up Jupyter Lab
4. Download the competition data (if not already present)

Once in the environment, you can start Jupyter Lab by running:

```bash
jupyter lab
```

## Additional Flake Commands

- Update the flake: `nix flake update`
- Run a command in the environment without entering it:
  ```bash
  nix develop github:johnbarnes-vi/janestreet-kaggle-dev-flake -c <command>
  ```
  For example, to start Jupyter Lab directly:
  ```bash
  nix develop github:johnbarnes-vi/janestreet-kaggle-dev-flake -c jupyter lab
  ```