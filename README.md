# Learning Flutter

Note that I'm following the [tutorial here](https://flutter.dev/docs/get-started/codelab-web),
but I've built container bases to provide the dependencies instead of installing on my host.

## Build Containers

First, build the base android-sdk container, and then the flutter container.

```bash
docker build -f Dockerfile.android -t vanessa/android-sdk .
docker build -t vanessa/learning-flutter .
```

You could then shell into the image:

```bash
docker run --entrypoint bash -it vanessa/learning-flutter
```

## Check Installs

Once inside the image, check the installation and devices with `flutter doctor`

```bash
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel beta, v1.12.13+hotfix.6, on Linux, locale C.UTF-8)
 
[✓] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
[✓] Chrome - develop for the web
[!] Android Studio (not installed)
[✓] Connected device (2 available)

! Doctor found issues in 1 category.
```

And you can also ensure that Chrome is installed:

```bash
$ flutter devices
2 connected devices:

Chrome     • chrome     • web-javascript • Google Chrome 79.0.3945.79
Web Server • web-server • web-javascript • Flutter Tools
```

## Export to Singularity

We could finagle around changing permissions and getting a display working with 
Docker, but it's a bit of a hassle, and easier to convert to Singularity.

```bash
singularity build flutter.sif docker-daemon://vanessa/learning-flutter:latest
```

This also required me to map flutter to the host, I couldn't bind the version file:

```bash
git clone git@github.com:flutter/flutter.git
```

We can then launch Google Chrome using the image, and still have our present
working directory (with write) findable in the image. Let's shell inside.

```bash
singularity shell --bind $PWD/flutter:/code/flutter --home /home/gradle --bind $HOME:/home/gradle flutter.sif
```

And then run the content of `./setup_flutter.sh` to install the beta (with web support)
You can also run the commands verbatim:

```bash
flutter channel beta
flutter upgrade
flutter config --enable-web
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
/usr/local/android-sdk/tools/bin/sdkmanager --update
yes | flutter doctor --android-licenses
```

What you are basically doing is updating the flutter install bound on your local
machine. This will ensure that when you exit from the container, starting
again will bind the same install. It's a little bit different than Docker where
you'd have complete isolation. You should then be able to run `flutter doctor` to see more details:

```bash
flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel beta, v1.12.13+hotfix.6, on Linux, locale C.UTF-8)
 
[✓] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
[✓] Chrome - develop for the web
[!] Android Studio (not installed)
[✓] Connected device (2 available)

! Doctor found issues in 1 category.
```

If you don't see connected devices, try to run the `flutter config --enable-web` again.
You should also be able to see `flutter devices` directly.

```bash
$ flutter devices
2 connected devices:

Chrome     • chrome     • web-javascript • Google Chrome 79.0.3945.79
Web Server • web-server • web-javascript • Flutter Tools
```

## Create a Project

Let's create a new flutter project. I saw a recent post on an R package named
`shrute` that included data exported from The Office, so this seems like a good
fun idea :)

```bash
flutter create shrute
cd shrute
flutter run -d chrome
```

This should launch the development compiler in a chrome browser! 

![learning-flutter](img/learning-flutter.png)

I'll do more
work / continue with this README.md on another day.
