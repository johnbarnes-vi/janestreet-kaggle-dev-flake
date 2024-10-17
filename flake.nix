{
  description = "Jane Street Real-Time Market Data Forecasting Kaggle Competition Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python311;
        pythonPackages = python.pkgs;
      in rec {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            (python.withPackages (ps: with ps; [
              pandas
              polars
              grpcio
              grpcio-tools
              pyarrow
              jupyterlab
              jupyter
              notebook
              ipykernel
              ipython
              kaggle
            ]))
            unzip
          ];

          shellHook = ''
            # Ensure Jupyter can find the kernel
            export JUPYTER_PATH="${pythonPackages.jupyter_core}/share/jupyter"
            export JUPYTERLAB_DIR="${pythonPackages.jupyterlab}/share/jupyter/lab"
            
            # Set up Jupyter notebook kernel
            ipython kernel install --user --name=nix-kernel
            
            # Download and extract Kaggle competition data if not already present
            COMPETITION_NAME="jane-street-real-time-market-data-forecasting"
            ZIP_FILE="$COMPETITION_NAME.zip"
            
            if [ ! -d "kaggle_evaluation" ]; then
              echo "Downloading Kaggle competition data..."
              kaggle competitions download -c $COMPETITION_NAME
              
              if [ -f "$ZIP_FILE" ]; then
                echo "Extracting competition data..."
                unzip -q "$ZIP_FILE"
                rm "$ZIP_FILE"
                echo "Kaggle competition data downloaded and extracted."
              else
                echo "Failed to download competition data. Please check your Kaggle credentials and internet connection."
              fi
            else
              echo "Kaggle competition data already present."
            fi
            
            echo "Jane Street Kaggle Competition environment activated!"
            echo "To start Jupyter Lab, run: jupyter lab"
          '';
        };
      }
    );
}