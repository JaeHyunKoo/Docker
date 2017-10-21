FROM ubuntu:14.04
MAINTAINER donothingdev <jaehyunkoo@gmail.com>

# Install dependencies
RUN apt-get update -y && apt-get install -y apt-file git wget curl unzip
RUN apt-file update -y
RUN apt-get install -y software-properties-common
RUN dpkg --add-architecture i386 && apt-get update -y && apt-get install -y --force-yes libc6-i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386

# Java 8 setup
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update -y && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Setup additional environments
ENV JAVA8_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
  
# Install Android SDK
ENV ANDROID_HOME /opt/android-sdk-linux
ENV SDK_TOOLS_VERSION 25.2.5
ENV API_LEVELS android-25,android-24,android-23,android-22,android-21,android-19

ENV ANDROID_EXTRAS extra-android-m2repository,extra-android-support,extra-google-google_play_services,extra-google-m2repository
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${JAVA_HOME}/bin 

RUN mkdir -p /opt/android-sdk-linux && cd /opt \
    && wget -q http://dl.google.com/android/repository/tools_r${SDK_TOOLS_VERSION}-linux.zip -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm -f android-sdk-tools.zip
	   
RUN echo y | android update sdk --no-ui -a --filter \
       platform-tools,${ANDROID_EXTRAS},${API_LEVELS} --no-https

RUN echo y | android update sdk --no-ui -a --filter build-tools-25.0.3,build-tools-25.0.2,build-tools-25.0.1,build-tools-25.0.0 --no-https
RUN echo y | android update sdk --no-ui -a --filter build-tools-24.0.3 --no-https
RUN echo y | android update sdk --no-ui -a --filter build-tools-22.0.1,build-tools-22.0.0 --no-https
RUN echo y | android update sdk --no-ui -a --filter build-tools-21.1.2,build-tools-21.1.1,build-tools-21.1,build-tools-21.0.2,build-tools-21.0.1,build-tools-21.0.0 --no-https
RUN echo y | android update sdk --no-ui -a --filter build-tools-19.1.0,build-tools-19.0.3,build-tools-19.0.2,build-tools-19.0.1,build-tools-19 --no-https
	   
# Install Android NDK
ENV ANDROID_NDK /opt/android-ndk-linux
RUN cd /opt && wget -O android-ndk-r13b.zip -q https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip && \
               unzip -q android-ndk-r13b.zip && rm -f android-ndk-r13b.zip && ln -sf /opt/android-ndk-r13b /opt/android-ndk-linux