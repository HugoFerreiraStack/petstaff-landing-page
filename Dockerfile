FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash flutter

USER flutter
WORKDIR /home/flutter

RUN git clone https://github.com/flutter/flutter.git -b 3.32.6 --depth 1

ENV PATH="/home/flutter/flutter/bin:${PATH}"

RUN flutter doctor

RUN flutter config --enable-web

WORKDIR /app

COPY --chown=flutter:flutter pubspec.yaml pubspec.lock ./

RUN flutter pub get

COPY --chown=flutter:flutter . .

RUN flutter build web --release

EXPOSE 8080

CMD ["flutter", "build", "web", "--release"]