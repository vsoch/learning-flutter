# Learning Flutter

First, build the base android-sdk container, and then the flutter container.

```bash
docker build -f Dockerfile.android -t vanessa/android-sdk .
docker build -t vanessa/learning-flutter .
```

You could then shell into the image:

```bash
docker run --entrypoint bash -it vanessa/learning-flutter
```


**under development**
