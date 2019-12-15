FROM vanessa/android-sdk

# docker build -f Dockerfile.android -t vanessa/android-sdk .
# docker build -t vanessa/learning-flutter .

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y git \
                                         bash \
                                         curl \
                                         unzip \
                                         xz-utils \
                                         libglu1-mesa \ 
                                         wget
                                         
RUN wget -O /flutter.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.5-stable.tar.xz
WORKDIR /code
RUN tar xf /flutter.tar.xz
ENV PATH="$PATH:/code/flutter/bin"
