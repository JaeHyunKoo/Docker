FROM ubuntu:14.04
MAINTAINER donothingdev <jaehyunkoo@gmail.com>

# Install dependencies
RUN apt-get update -y && apt-get install -y apt-file git wget curl unzip
RUN apt-file update -y
RUN apt-get install -y software-properties-common
RUN dpkg --add-architecture i386 && apt-get update -y && apt-get install -y --force-yes libc6-i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386

# Java 8 setup
RUN apt-add-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get -y install openjdk-8-jdk

# Clean Up Apt-get
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

# Setup additional environments
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA8_HOME /usr/lib/jvm/java-8-openjdk-amd64
  
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
			  
			  
# Install Gradle
ENV GRADLE_HOME=/opt/gradle
ENV GRADLE_FOLDER=/root/.gradle

RUN mkdir -p /opt/tools

# Download and extract gradle to /opt/tools folder
RUN wget --no-check-certificate --no-cookies https://downloads.gradle.org/distributions/gradle-2.14.1-bin.zip \
    && unzip gradle-2.14.1-bin.zip -d /opt/tools \
    && rm -f gradle-2.14.1-bin.zip

RUN ln -s /opt/tools/gradle-2.14.1 /opt/gradle

# Add executables to path
RUN update-alternatives --install "/usr/bin/gradle" "gradle" "/opt/gradle/bin/gradle" 1 && \
    update-alternatives --set "gradle" "/opt/gradle/bin/gradle" 
	
RUN wget --no-check-certificate --no-cookies https://downloads.gradle.org/distributions/gradle-3.3-bin.zip \
    && unzip gradle-3.3-bin.zip -d /opt/tools \
    && rm -f gradle-3.3-bin.zip

	
ENTRYPOINT ["/bin/bash"]