# Sequoia-Client Build and Deployment

## Scope

Sequoia-Client is the native C++ client/test application built with CMake and
Ninja. The root `Makefile` supports a host build under `build/native`, an ARM64
Docker/QEMU build under `build/cross`, local test-app execution, and deployment
of the cross-built `lib/` and `bin/` trees to two configured devices. The CMake
project enables tests with `-DBUILD_TESTS=ON` and also references the sibling
Sequoia-HAL repository.

## 1. Prerequisites

- Native: CMake, Ninja, a C++ compiler, `nproc`, and the project dependencies.
- Quality/docs: `clang-format`, `cmake-format`, `cppcheck`, Doxygen, and
  Graphviz as applicable to the selected target.
- Docker path: Docker with permission to run containers; the target image is
  `sequoia` and the recipes use ARM64 emulation. `make docker-install` may use
  `sudo apt` when Docker is absent.
- Deployment: `sshpass`, SSH/SCP access to the target, and credentials. The
  defaults are `nvidia`/`nvidia`; override with `USER`, `PASS`, `IP_A`, and
  `IP_B` or use the configured lab values. **Credential/device required.**

## 2. Setup

Run commands from this repository root. `make help` lists the Makefile groups.
Optional Bash completion is installed into `~/.bashrc` by `make setup-completion`.

## 3. Build

```sh
make configure                 # CMake/Ninja in build/native
make build                     # native build; also configures
make docker-install            # conditional: installs Docker with sudo
make docker-image              # conditional: builds image sequoia
make docker-configure          # ARM64 cross configuration
make docker-build              # ARM64 cross build in build/cross
```

`make all` is the default alias for the native `build` target. `JOBS=N` controls
native parallelism; Docker jobs are capped by the Makefile for QEMU stability.

## 4. Test and lint

```sh
make test                      # native CTest serializer/runner tests
make docker-test               # cross CTest under ARM64 Docker/QEMU
make format                    # clang-format and CMake formatting in place
make cppcheck                  # static analysis
make doc                       # Doxygen output via ninja doc_doxygen
```

The quality targets require their named host tools and `format` modifies source
formatting. Run them only when that change is intended.

## 5. Artifacts

This leaf has no package target. Native artifacts are under `build/native/`; the
cross build places libraries and executables under `build/cross/lib/` and
`build/cross/bin/`. The Docker image is tagged `sequoia`.

## 6. Deploy, install, and run

```sh
make deploy-a IP_A=192.168.1.3 USER=nvidia PASS='...'  # credential/device required
make deploy-b IP_B=192.168.1.13 USER=nvidia PASS='...' # credential/device required
make run-a [APP] [ARGS...]                             # deploy then remote run
make run-b [APP] [ARGS...]                             # deploy then remote run
make list                                               # list native/cross apps
make run [APP] [ARGS...]                                # run locally after build
```

Deployment clears `/tmp/acu-test` on the target and copies `lib/` and `bin/`.
Remote execution assumes the copied binaries and compatible target runtime;
successful SSH/SCP is not a substitute for functional device verification.

## 7. Cleanup

```sh
make clean                  # remove build/native and build/cross
make docker-clean           # remove cross artifacts through the image
```

## 8. Verification caveats

The Docker path is emulated ARM64 and does not prove behavior on the physical
Sequoia device. `deploy*` and `run-*` are conditional on reachable configured
targets and valid credentials; inspect the target logs and application behavior
manually. No cloud deployment target is defined in this Makefile.