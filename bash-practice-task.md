# Docker Automation Bash Script

## Description
This Bash script automates the process of building a Docker image, uploading it to a repository, and running a local container using that image. It also includes functions for checking whether the image was uploaded successfully and whether the container runs locally without any problems.

## Features
- Builds a Docker image.
- Runs a local container using the uploaded image.
- Uploads the Docker image to a specified registry (only if local checks are passed)
- checking the success of image upload and container local execution (e.g. curl command for web app).
- Utilizes error handling and parameterization for flexibility.
- Use functions as much as possible
- Paramatrize as much as possible (image name, tag, registry credentials etc.)
- Handling credentials (as local env, sourcing from other file, other way)
