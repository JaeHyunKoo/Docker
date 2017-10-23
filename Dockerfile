FROM ubuntu:14.04
MAINTAINER donothingdev <jaehyunkoo@gmail.com>

# Install dependencies
RUN apt-get update -y && apt-get install -y apt-file git wget curl unzip
RUN apt-file update -y
RUN apt-get install -y software-properties-common
RUN dpkg --add-architecture i386 && apt-get update -y && apt-get install -y --force-yes libc6-i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386
<<<<<<< HEAD

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
ENV PATH ${PATH}:${JAVA_HOME}/bin 
  
# Install Android SDK
ENV ANDROID_HOME /opt/android-sdk-linux
ENV SDK_TOOLS_VERSION 25.2.5

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN mkdir -p /opt/android-sdk-linux && cd /opt \
    && wget -q http://dl.google.com/android/repository/tools_r${SDK_TOOLS_VERSION}-linux.zip -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm -f android-sdk-tools.zip
=======

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
>>>>>>> f7f0cb30912f20595d0f3b4f3eabf9b53c62496f
	   
RUN echo y | android update sdk --no-ui --all -s --filter platform-tools
RUN echo y | android update sdk --no-ui --all -s --filter extra-android-m2repository,extra-android-support,extra-google-google_play_services,extra-google-m2repository 
RUN echo y | android update sdk --no-ui -a -s --filter android-26,android-25,android-24,android-23,android-22,android-21,android-19

RUN echo y | android update sdk --no-ui -a -s --filter build-tools-26.0.2,build-tools-26.0.1,build-tools-26.0.0
RUN echo y | android update sdk --no-ui -a -s --filter build-tools-25.0.3,build-tools-25.0.2,build-tools-25.0.1,build-tools-25.0.0
RUN echo y | android update sdk --no-ui -a -s --filter build-tools-24.0.3
RUN echo y | android update sdk --no-ui -a -s --filter build-tools-22.0.1,build-tools-22.0.0
RUN echo y | android update sdk --no-ui -a -s --filter build-tools-21.1.2,build-tools-21.1.1,build-tools-21.1,build-tools-21.0.2,build-tools-21.0.1,build-tools-21.0.0
RUN echo y | android update sdk --no-ui -a -s --filter build-tools-19.1.0,build-tools-19.0.3,build-tools-19.0.2,build-tools-19.0.1,build-tools-19

RUN echo y | android update sdk --no-ui -a -s --filter addon-google_apis-google-24
RUN echo y | android update sdk --no-ui -a -s --filter addon-google_apis-google-23
RUN echo y | android update sdk --no-ui -a -s --filter addon-google_apis-google-22
RUN echo y | android update sdk --no-ui -a -s --filter addon-google_apis-google-21
RUN echo y | android update sdk --no-ui -a -s --filter addon-google_apis-google-19

# Install Android NDK
ENV ANDROID_NDK /opt/android-ndk-linux
RUN cd /opt && wget -O android-ndk-r13b.zip -q https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip && \
               unzip -q android-ndk-r13b.zip && rm -f android-ndk-r13b.zip && ln -sf /opt/android-ndk-r13b /opt/android-ndk-linux
			  
			  
# Install Gradle
ENV GRADLE_HOME=/opt/gradle
ENV GRADLE_FOLDER=/root/.gradle
<<<<<<< HEAD
RUN mkdir -p /opt/tools
RUN echo '#!/bin/bash' >> /download_gradle.sh
RUN echo 'version=$1' >> /download_gradle.sh
RUN echo 'echo y | wget --no-check-certificate --no-cookies https://downloads.gradle.org/distributions/gradle-${version}-bin.zip && unzip gradle-${version}-bin.zip -d /opt/tools && rm -f gradle-${version}-bin.zip' >> /download_gradle.sh
RUN chmod a+x /download_gradle.sh

RUN /download_gradle.sh 2.14.1
RUN /download_gradle.sh 3.3

#make change gradle
RUN echo '#!/bin/bash' >> /usr/local/bin/setgradle
RUN echo 'version=$1' >> /usr/local/bin/setgradle
RUN echo 'rm -rf /opt/gradle && ln -s /opt/tools/gradle-${version} /opt/gradle' >> /usr/local/bin/setgradle
RUN chmod a+x /usr/local/bin/setgradle
RUN /usr/local/bin/setgradle 2.14.1
=======

RUN mkdir -p /opt/tools

# Download and extract gradle to /opt/tools folder
RUN wget --no-check-certificate --no-cookies https://downloads.gradle.org/distributions/gradle-2.14.1-bin.zip \
    && unzip gradle-2.14.1-bin.zip -d /opt/tools \
    && rm -f gradle-2.14.1-bin.zip

RUN ln -s /opt/tools/gradle-2.14.1 /opt/gradle
>>>>>>> f7f0cb30912f20595d0f3b4f3eabf9b53c62496f

# Add executables to path
RUN update-alternatives --install "/usr/bin/gradle" "gradle" "/opt/gradle/bin/gradle" 1 && \
    update-alternatives --set "gradle" "/opt/gradle/bin/gradle" 
	
<<<<<<< HEAD
=======
RUN wget --no-check-certificate --no-cookies https://downloads.gradle.org/distributions/gradle-3.3-bin.zip \
    && unzip gradle-3.3-bin.zip -d /opt/tools \
    && rm -f gradle-3.3-bin.zip

	
>>>>>>> f7f0cb30912f20595d0f3b4f3eabf9b53c62496f
ENTRYPOINT ["/bin/bash"]