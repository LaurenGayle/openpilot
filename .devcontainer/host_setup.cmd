:: pull base image
IF NOT DEFINED USE_LOCAL_IMAGE ^
echo "Updating openpilot_base image if needed..." && ^
docker pull ghcr.io/commaai/openpilot-base:579b131a6efe67463d5b2d06abe743302c9cdc08

:: setup .host dir
mkdir .devcontainer\.host

:: setup host env file
echo "" > .devcontainer\.host\.env