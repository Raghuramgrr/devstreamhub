# Base Image
FROM ubuntu:22.04



RUN apt-get update  \
    && apt-get -y --no-install-recommends install  \
        # install any other dependencies you might need
        sudo curl git ca-certificates build-essential \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV MISE_DATA_DIR="/mise"
ENV MISE_CONFIG_DIR="/mise"
ENV MISE_CACHE_DIR="/mise/cache"
ENV MISE_INSTALL_PATH="/usr/local/bin/mise"
ENV PATH="/mise/shims:$PATH"
# ENV MISE_VERSION="..."

RUN curl https://mise.run | sh

# Create the .tool-versions file for your required tools
RUN echo "helm 3.13.1" >> /.tool-versions && \
    echo "helmfile 0.158.0" >> /.tool-versions && \
    echo "java openjdk-17.0.2" >> /.tool-versions && \
    echo "kubectl 1.28.3" >> /.tool-versions && \
    echo "maven 3.9.5" >> /.tool-versions && \
    echo "nodejs 18.18.2" >> /.tool-versions && \
    echo "pnpm 8.10.0" >> /.tool-versions && \
    echo "git 2.39.1" >> /.tool-versions


# Install tools using mise
RUN mise install

# Debug: Print PATH and check if tools are properly installed
RUN echo "Debugging: Checking PATH..." && \
    echo "PATH is $PATH" 
    #echo "Listing files in /root/.local/bin" && ls -al /root/.local/bin && \
    #echo "Checking installation paths for tools..." && \
    # which helm && helm version && \
    # which helmfile && helmfile --version && \
    # which java && java -version && \
    # which kubectl && kubectl version --client && \
    # which mvn && mvn -version && \
    # which node && node -v && \
    # which pnpm && pnpm -v

# Default command
CMD ["/bin/bash"]
