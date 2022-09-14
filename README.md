# f90wrap-wheels

**NOW DEUFUNCT** Wheels are now build directly in the [f90wrap](https://github.com/jameskermode/f90wrap) repo


Wheel builder for [f90wrap](https://github.com/jameskermode/f90wrap)

This repository uses [multibuild](https://github.com/matthew-brett/multibuild)
to build wheels for Mac OS X and manylinux.  Builds are trigged on every commit,
but wheels are only deployed to GitHub on tags.

## Making a release

There are 3 steps:
1. Making a source release of `f90wrap` to PyPI
2. Trigger the wheel build
3. Release wheels to PyPI

### Source release of `f90wrap`

The `f90wrap` source distribution is fetched from PyPI, so you need to do a
standard `sdist` release first, e.g.:

```bash
cd f90wrap
git tag v0.x.y
git push --tags
python3 -m build                            # build source distribution
python3 -m twine dist/f90wrap-0.x.y.tar.gz  # upload to PyPI
```
### Triggering the wheel build

Now change to the `f90wrap-wheels` repo, and change the `F90WRAP_VERSION`
environment variable in `.github/workflows/build.yml` to match the just-released version plus a
release candidate suffix such as `-rc1` for the first attempt, create a matching
tag and push to trigger the build:

```bash
cd f90wrap-wheels
emacs .travis.yml # change F90WRAP_VERSION to v0.x.y-rc1
git add .travis.yml
git commit -m 'release v0.x.z-rc1'
git tag v0.x.y-rc1
git push --tags
```

If all goes well, the `.whl` files will show up as assets within a new GitHub
release. The installation process can now be tested locally, e.g. on Mac OS X
with Python 3.9:

```bash
pip install https://github.com/jameskermode/f90wrap-wheels/releases/download/v0.x.y-rc1/f90wrap-0.2.5-cp39-cp39-macosx_10_9_x86_64.whl
```

If there are problems with the build, the `test.sh` script can be useful to
debug  within a local Docker container.

### Release wheels to PyPI

Once everything works correctly, make a full release (i.e. create a tag named
just `v0.x.y` without the `-rc1` suffix). This will trigger the upload of wheels
to PyPI.
