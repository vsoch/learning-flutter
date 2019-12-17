FROM vanessa/android-sdk

# docker build -f Dockerfile.android -t vanessa/android-sdk .
# docker build -t vanessa/learning-flutter .
# docker run --entrypoint bash -it vanessa/learning-flutter

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y git \
                                         bash \
                                         curl \
                                         unzip \
                                         xz-utils \
                                         libglu1-mesa \ 
                                         wget
                                 
RUN wget -O /flutter.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.5-stable.tar.xz
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || true && \
    apt --fix-broken -y install
WORKDIR /code
RUN tar xf /flutter.tar.xz
ENV PATH="$PATH:/code/flutter/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin"
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
## User 1000 is gradle in the container, maps to my user
RUN chown -R 1000 /code /usr/local/android-sdk /usr/bin/google-chrome /usr/lib/jvm && \
    chmod +x /usr/local/android-sdk/tools/bin/sdkmanager
USER 1000
