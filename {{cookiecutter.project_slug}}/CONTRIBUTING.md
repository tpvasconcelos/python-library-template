# Contributing

Thank you for your interest in contributing to {{cookiecutter.project_slug}}! 🚀

The contribution process for {{cookiecutter.project_slug}} should start with
[filing a GitHub issue](https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_slug}}/issues/new/choose)
. We define three main categories of issues, and each category has its own GitHub issue template

- ⭐ Feature requests
- 🐛 Bug reports
- 📚 Documentation fixes

After the implementation strategy has been agreed on by a {{cookiecutter.project_slug}} committer, the next
step is to introduce your changes as a pull request (see
[Submitting a Pull Request](#submitting-a-pull-request)) against the {{cookiecutter.project_slug}} repository.
Once your pull request is merged, your changes will be automatically included in the next
{{cookiecutter.project_slug}} release. Every change should be listed in the
{{cookiecutter.project_slug}} [Release Notes](CHANGES.md).

The following is a set of (slightly opinionated) rules and general guidelines for contributing to
{{cookiecutter.project_slug}}. Emphasis on **guidelines**, not _rules_. Use your best judgment, and feel free
to propose changes to this document in a pull request.

## Table of Contents

- [Development environment](#development-environment)
- [Submitting a Pull Request](#submitting-a-pull-request)
- [Continuous Integration](#continuous-integration)
    - [Running it locally](#running-it-locally)
        - [Tests and coverage reports](#tests-and-coverage-reports)
        - [Linting](#linting)
    - [GitHub Actions](#github-actions)
    - [Tools and software](#tools-and-software)
- [Project structure](#project-structure)
    - [Community health files](#community-health-files)
    - [Configuration files](#configuration-files)
- [Release process](#release-process)
    - [Release steps](#release-steps)
- [Code of Conduct](#code-of-conduct)

## Development environment

Here are some guidelines for setting up your development environment. Most of the steps have been abstracted
away using the [make](https://en.wikipedia.org/wiki/Make_(software)) build automation tool. Feel free to peak
inside [Makefile](Makefile) at any time to see exactly what is being run, and in which order.

First, you will need to
[clone](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo#step-2-create-a-local-clone-of-your-fork)
this repository. For this, make sure you have a [GitHub account](https://github.com/join), fork
{{cookiecutter.project_slug}} to your GitHub account by clicking the
[Fork](https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_slug}}/fork) button, and
clone the main repository locally (e.g. using SSH)

```shell
git clone git@github.com:{{cookiecutter.github_username}}/{{cookiecutter.project_slug}}.git
cd {{cookiecutter.project_slug}}
```

You will also need to add your fork as a remote to push your work to. Replace `{username}` with your GitHub
username.

```shell
git remote add fork git@github.com:{username}/{{cookiecutter.project_slug}}.git
```

The following command will 1) create a new virtual environment (under `.venv`), 2) install
{{cookiecutter.project_slug}} in
[editable mode](https://pip.pypa.io/en/stable/cli/pip_install/#install-editable) (along with all it's
dependencies), and 3) set up and install all [pre-commit hooks](https://pre-commit.com/). Make sure you always
work within this virtual environment (i.e., `$ source .venv/bin/activate`). On top of this, you should also
set up your IDE to always point to this python interpreter. In PyCharm, open
`Preferences -> Project: {{cookiecutter.project_slug}} -> Project Interpreter` and point the python
interpreter to `.venv/bin/python`.

```shell
make init
```

The default and **recommended** base python is `python3.7` . You can change this by exporting the
`BASE_PYTHON` environment variable. For instance, you could instead run:

```shell
BASE_PYTHON=python3.8 make init
```

If you need to use jupyter-lab, you can install all extra requirements, as well as set up the environment and
jupyter kernel with

```shell
make init-jupyter
```

**Bonus:** If you need to use
[plotly inside a jupyter-lab](https://plotly.com/python/getting-started/#jupyterlab-support)
notebook, just run

```shell
make jupyter-plotly
```

## Pull Request Workflow

1. Always confirm that you have properly configured your Git username and email.
   ```shell
   git config --global user.name 'Your real name'
   git config --global user.email 'Your email address'
   ```
2. Each release series has its own branch (i.e. `MAJOR.MINOR.x`). If submitting a documentation or bug fix
   contribution, branch off of the latest release series branch.
   ```shell
   git fetch origin
   git checkout -b <YOUR-BRANCH-NAME> origin/2.0.x
   ```
   Otherwise, if submitting a new feature or API change, branch off of the "master" branch
   ```shell
   git fetch origin
   git checkout -b <YOUR-BRANCH-NAME> origin/main
   ```
3. Apply and commit your changes.
4. Include tests that cover any code changes you make, and make sure the test fails without your patch.
5. Add an entry to [CHANGES.md](CHANGES.md) summarising the changes in this pull request. The entry should
   follow the same style and format as other entries, i.e.
   > `- Your summary here. (#XXX)`

   where `#XXX` should link to the relevant pull request. If you think that the changes in this pull request
   do not warrant a changelog entry, please state it in your pull request's description. In such cases, a
   maintainer should add a `skip news` label to make CI pass.
6. Make sure all integration approval steps are passing locally (i.e., `tox`).
7. Push your changes to your fork
   ```shell
   git push --set-upstream fork <YOUR-BRANCH-NAME>
   ```
8. [Create a pull request](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)
   . Remember to update the pull request's description with relevant notes on the changes implemented, and to
   [link to relevant issues](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue)
   (e.g., `fixes #XXX` or `closes #XXX`).
9. Wait for all remote CI checks to pass and for a {{cookiecutter.project_slug}} contributor to approve your
   pull request.

## Continuous Integration

From GitHub's
[Continuous Integration and Continuous Delivery (CI/CD) Fundamentals](https://resources.github.com/ci-cd/):
> _Continuous Integration (CI) automatically builds, tests, and **integrates** code changes within a shared
> repository._

The first step to Continuous Integration (CI) is having a version control system (VCS) in place. Luckily, you
don't have to worry about that! As you have already noticed, we use [Git](https://git-scm.com/) and host
on [GitHub](https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_slug}}).

On top of this, we also run a series of integration approval steps that allow us to ship code changes faster
and more reliably. In order to achieve this, we run automated tests and coverage reports, as well as syntax
(and type) checkers, code style formatters, and dependency vulnerability scans.

### Running it locally

Our tool of choice to configure and reliably run all integration approval steps is
[Tox](https://github.com/tox-dev/tox), which allows us to run each step in reproducible isolated virtual
environments. To trigger all checks, simply run

```shell
tox
```

It's that simple 🙌 !! Note only that this will take a while the first time you run the command, since it will
have to create all the required virtual environments (along with their dependencies) for each CI step.

The configuration for Tox can be found in [tox.ini](tox.ini).

#### Tests and coverage reports

We use [pytest](https://github.com/pytest-dev/pytest) as our testing framework,
and [pytest-cov](https://pytest-cov.readthedocs.io/en/latest/) to track and measure code coverage. You can
find all configuration details in [tox.ini](tox.ini). To trigger all tests, simply run

```shell
tox -e py
```

You can also run your tests against any other supported python versions (e.g., `tox -e py38`). If you need
more control over which tests are running, or which flags are being passed to pytest, you can also
invoke `pytest` directly which will run on your current virtual environment. Configuration details can be
found in [tox.ini](tox.ini).

#### Linting

This project uses [pre-commit hooks](https://pre-commit.com/) to check and automatically fix any formatting
rules. These checks are triggered before creating any git commit. To manually trigger all linting steps (i.e.,
all pre-commit hooks), run

```shell
tox -e lint
```

For more information on which hooks will run, have a look inside the
[.pre-commit-config.yaml](.pre-commit-config.yaml) configuration file. If you want to manually trigger
individual hooks, you can invoke the `pre-commit` script directly. If you need even more control over the
tools used you could also invoke them directly (e.g., `isort .`). Remember however that this is **not** the
recommended approach.

### GitHub Actions

We use [GitHub Actions](https://github.com/features/actions) to automatically run all integration approval
steps defined with Tox on every push or pull request event. These checks run on all major operating systems
and all supported Python versions. Finally, the generated coverage reports are uploaded to
[Codecov](https://about.codecov.io/) and [Codacy](https://www.codacy.com/).
Check [.github/workflows/ci.yaml](.github/workflows/ci.yaml) for more details.

### Tools and software

Here is a quick overview of all CI tools and software in use, some of which have already been discussed in the
sections above.

| Tool                                                                       | Category         | config files                                             | Details      |
| -------------------------------------------------------------------------- | ---------------- | -------------------------------------------------------  | ------------ |
| [Tox](https://github.com/tox-dev/tox)                                      | 🔧 Orchestration | [tox.ini](tox.ini)                                     | We use Tox to reliably run all integration approval steps in reproducible isolated virtual environments. |
| [GitHub Actions](https://github.com/features/actions)                      | 🔧 Orchestration | [.github/workflows/ci.yaml](.github/workflows/ci.yaml) | Workflow automation for GitHub. We use it to automatically run all integration approval steps defined with Tox on every push or pull request event. |
| [Git](https://git-scm.com/)                                                | 🕰 VCS           | [.gitignore](.gitignore)                               | Projects version control system software of choice. |
| [pytest](https://github.com/pytest-dev/pytest)                             | 🧪 Testing       | [tox.ini](tox.ini)                                     | Testing framework for python code. |
| [pytest-cov](https://pytest-cov.readthedocs.io/en/latest/)                 | 📊 Coverage      | [tox.ini](tox.ini)                                     | Coverage plugin for pytest. |
| [Codecov](https://about.codecov.io/) and [Codacy](https://www.codacy.com/) | 📊 Coverage      |                                                          | Two great services for tracking, monitoring, and alerting on code coverage and code quality. |
| [pre-commit hooks](https://pre-commit.com/)                                | 💅 Linting       | [.pre-commit-config.yaml](.pre-commit-config.yaml)     | Used to to automatically check and fix any formatting rules on every commit. |
| [mypy](https://github.com/python/mypy)                                     | 💅 Linting       | [mypy.ini](mypy.ini)                                   | A static type checker for Python. We use quite a strict configuration here, which can be tricky at times. Feel free to ask for help from the community by commenting on your issue or pull request. |
| [black](https://github.com/psf/black)                                      | 💅 Linting       | [pyproject.toml](pyproject.toml)                       | "The uncompromising Python code formatter". We use `black` to automatically format Python code in a deterministic manner. We use a maximum line length of 120 characters. |
| [flake8](https://github.com/pycqa/flake8)                                  | 💅 Linting       | [setup.cfg](setup.cfg)                                 | Used to check the style and quality of python code. |
| [isort](https://github.com/pycqa/isort)                                    | 💅 Linting       | [setup.cfg](setup.cfg)                                 | Used to sort python imports. |
| [EditorConfig](https://editorconfig.org/)                                  | 💅 Linting       | [.editorconfig](.editorconfig)                         | This repository uses the `.editorconfig` standard configuration file, which aims to ensure consistent style across multiple programming environments. |

## Project structure

### Community health files

GitHub's community health files allow repository maintainers to set contributing guidelines to help
collaborators make meaningful, useful contributions to a project. Read more on this official
[reference](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions).

- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) - A CODE_OF_CONDUCT file defines standards for how to engage in a
  community. For more information, see
  "[Adding a code of conduct to your project.](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/adding-a-code-of-conduct-to-your-project)"
- [CONTRIBUTING.md`(CONTRIBUTING.md) - A CONTRIBUTING file communicates how people should contribute to your
  project. For more information, see
  "[Setting guidelines for repository contributors.](https://docs.github.com/en/articles/setting-guidelines-for-repository-contributors)"

### Configuration files

For more context on some of the tools referenced below, refer to the sections
on [Continuous Integration](#continuous-integration).

- [.github/workflows/ci.yaml](.github/workflows/ci.yaml) - Workflow definition for our CI GitHub Actions
  pipeline.
- [.pre-commit-config.yaml](.pre-commit-config.yaml) - List of pre-commit hooks.
- [.editorconfig](.editorconfig) -
  [EditorConfig](https://editorconfig.org/) standard configuration file.
- [mypy.ini](mypy.ini) - Configuration for the `mypy` static type checker.
- [pyproject.toml](pyproject.toml) -
  [build system](https://setuptools.readthedocs.io/en/latest/build_meta.html) requirements (probably won't
  need to touch these!) and [black](https://github.com/psf/black) configurations.
- [setup.cfg](setup.cfg) - Here, we specify the package metadata, requirements, as well as configuration
  details for [flake8](https://github.com/pycqa/flake8) and [isort](https://github.com/pycqa/isort).
- [tox.ini](tox.ini) - Configuration for [tox](https://github.com/tox-dev/tox),
  [pytest](https://github.com/pytest-dev/pytest), and
  [coverage](https://coverage.readthedocs.io/en/latest/index.html).

## Release process

- {{cookiecutter.project_slug}} uses the [SemVer](https://semver.org/) (`MAJOR.MINOR.PATCH`) versioning
  standard.
- You can determine the latest release version by running `git describe --tags --abbrev=0` on the master
  branch.

### Release steps

1. Review the `## Unreleased changes` section in [CHANGES.md](CHANGES.md) by checking for consistency in
   format and, if necessary, refactoring related entries into relevant subsections (e.g. Features, Docs,
   Bugfixes, Security, etc).
    - Submit a pull request with these changes. You may use the `"Update release notes for X.X.X release"`
      template for the pull request title.
2. Use the [bumpversion](https://github.com/peritus/bumpversion) utility to bump the current version. This
   utility will automatically bump the current version, and issue a relevant commit and git tag. E.g.,
   ```shell
   # Bump MAJOR version (e.g., 0.4.2 -> 1.0.0)
   bumpversion major

   # Bump MINOR version (e.g., 0.4.2 -> 0.5.0)
   bumpversion minor

   # Bump PATCH version (e.g., 0.4.2 -> 0.4.3)
   bumpversion patch
   ```
   You can always perform a dry-run to see what will happen under the hood.
   ```shell
   bumpversion --dry-run --verbose [--allow-dirty] [major,minor,patch]
   ```
3. Push your changes along with all tag references:
   ```shell
   git push --tags
   ```
4. Open a pull request titled `"Release version X.X.X"`
5. Wait for all CI checks to pass.
6. A {{cookiecutter.project_slug}} main contributor should sign off and merge this pull requests.
7. Create a new release using the GitHub UI.
    - Copy the raw markdown section in `CHANGES.md` corresponding to this release and use it as the
      description of the GitHub Release.
    - Use the same `X.X.X` tag used in the release.
8. At this point a GitHub Actions workflow will be triggered which will build and publish new wheels to PyPI.
   Be sure to check whether all workflows passed successfully.

## Code of Conduct

Please remember to read and follow our [Code of Conduct](CODE_OF_CONDUCT.md). 🤝
