FROM test

RUN echo y | android update sdk --no-ui -a --filter \
       platform-tools,${ANDROID_EXTRAS},${API_LEVELS} --no-https

ENV BUILD_TOOLS_VERSIONS build-tools-25.0.3,build-tools-25.0.2,build-tools-25.0.1,build-tools-25.0.0,build-tools-24.0.3,build-tools-23.0.3,build-tools-23.0.2,build-tools-23.0.1,build-tools-23.0.0,build-tools-22.0.1,build-tools-22.0.0,build-tools-21.1.2,build-tools-21.1.1,build-tools-21.1,build-tools-21.0.2,build-tools-21.0.1,build-tools-21.0.0,build-tools-20.0.0,build-tools-19.1.0,build-tools-19.0.3,build-tools-19.0.2,build-tools-19.0.1,build-tools-19
RUN echo y | android update sdk --no-ui -a --filter \
            ${BUILD_TOOLS_VERSIONS} --no-https
	   
# Install Android NDK
ENV ANDROID_NDK /opt/android-ndk-linux
RUN cd /opt && wget -O android-ndk-r13b.zip -q https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip && \
               unzip -q android-ndk-r13b.zip && rm -f android-ndk-r13b.zip && ln -sf /opt/android-ndk-r13b /opt/android-ndk-linux