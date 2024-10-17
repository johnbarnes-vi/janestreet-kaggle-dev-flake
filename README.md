# Jane Street Real-Time Market Data Forecasting Environment

This repository contains a Nix flake for setting up the development environment for the Jane Street Real-Time Market Data Forecasting Kaggle competition. It does not contain any competition code or datasets.

## Important Notes

- This repository does not include any code solutions for the competition.
- No competition datasets are stored in this repository.
- You must set up your Kaggle API credentials before using this environment.

## Prerequisites

1. Install the Nix package manager:
   - On macOS, run the following command in your terminal:
     ```bash
     sh <(curl -L https://nixos.org/nix/install)
     ```
   - For other platforms, please refer to the [official Nix installation guide](https://nixos.org/download.html).

2. Enable Nix flakes by adding the following to your `~/.config/nix/nix.conf` (you may have to create `~/.config/nix/` and `nix.conf` on first install):
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

To use this flake, follow these steps:

1. Create a new directory for your project:
   ```bash
   mkdir jane-street-kaggle-project
   cd jane-street-kaggle-project
   ```

2. Enter the development environment using the flake directly from GitHub:
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

## Adding Additional Python Packages

If you need to add additional Python packages on top of the base environment, you can use the `--command` option with `nix-shell`:

```bash
nix develop github:johnbarnes-vi/janestreet-kaggle-dev-flake --command "nix-shell -p 'python3.withPackages(ps: with ps; [ package1 package2 ])' --run zsh"
```

Replace `package1 package2` with the names of the Python packages you want to add, and `zsh` with your preferred shell.

For example, to add `scikit-learn` and `xgboost`:

```bash
nix develop github:johnbarnes-vi/janestreet-kaggle-dev-flake --command "nix-shell -p 'python3.withPackages(ps: with ps; [ scikit-learn xgboost ])' --run zsh"
```

This will give you an environment with all the packages from the original flake, plus the additional Python packages you specified.

Alternatively, you can install additional Python packages using pip once inside the environment:

```bash
pip install package1 package2
```

Note that packages installed with pip will only persist for the current session.

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