FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN git clone https://github.com/flutter/flutter.git -b 3.32.6 --depth 1

ENV PATH="/root/flutter/bin:${PATH}"

RUN flutter doctor

RUN flutter config --enable-web

WORKDIR /app

COPY pubspec.yaml pubspec.lock ./

RUN flutter pub get

COPY . .

RUN flutter build web --release

EXPOSE 8080

CMD ["flutter", "build", "web", "--release"]