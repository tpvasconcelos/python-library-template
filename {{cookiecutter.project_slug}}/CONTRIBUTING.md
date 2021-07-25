# Contributing

Thanks for taking the time and considering contributing to `{{cookiecutter.project_slug}}`! 🚀

The following is a set of (slightly opinionated) rules and general guidelines for contributing to
`{{cookiecutter.project_slug}}`. Emphasis on **guidelines**, not _rules_. Use your best judgment, and feel
free to propose changes to this document in a pull request.

Examples of contributions include:

- Code patches
- Documentation improvements
- Bug reports and patch reviews

## Code of Conduct

Please remember to read and follow our [Code of Conduct](CODE_OF_CONDUCT.md). 🤝

## Development environment

Here are some guidelines for setting up your development environment. Most of the steps have been abstracted
away using the [`make`](https://en.wikipedia.org/wiki/Make_(software)) build automation tool. Feel free to
peak inside [`Makefile`](Makefile) at any time to see exactly what is being run, and in which order.

First, you will need to clone this repository. For instance (using SSH)

```shell
git clone git@github.com:{{cookiecutter.github_username}}/{{cookiecutter.project_slug}}.git
cd {{cookiecutter.project_slug}}
```

The following command will 1) create a virtual environment, 2) install `{{cookiecutter.project_slug}}`
in [editable mode](https://pip.pypa.io/en/stable/cli/pip_install/#install-editable) (along with all it's
requirements), and 3) set up and install all [pre-commit hooks](https://pre-commit.com/).

```shell
make init
```

The default and **recommended** base python is `python3.7` and the default path to the virtual environment
is `.venv`. You can change both by exporting the `BASE_PYTHON` and `VENV_PATH` environment variables. For
instance, you could run

```shell
BASE_PYTHON=python3.8 VENV_PATH=env make init
```

If you need to use jupyter-lab, you can install all extra requirements, as well as set up the environment and
jupyter kernel with

```shell
make jupyter-init
```

**Bonus:** If you need to use
[plotly inside a jupyter-lab](https://plotly.com/python/getting-started/#jupyterlab-support)
notebook, just run

```shell
make jupyter-plotly
```

## Continuous Integration

The first step to Continuous Integration (CI) is having a version control system (VCS) in place. Luckily, you
don't have to worry about that! As you have already noticed, we use [Git](https://git-scm.com/) and host
on [GitHub](https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_slug}}).

On top of this, we also run a series of integration approval steps that aim at maximising code quality and
minimizing breaking code changes. In order to achieve this, we run automated tests and coverage reports, as
well as syntax (and type) checkers, code style formatters, and dependency vulnerability scans. You can read
more on this in the upcoming sections.

### GitHub Actions

We use [GitHub Actions](https://github.com/features/actions) to automatically run all integration approval
steps on every push or pull request. Python tests and coverage reports run on all major operating systems and
all supported Python versions. In addition to this, code style and lint checks are also run against the lowest
supported Python 3 version. Check [`.github/workflows/ci.yaml`](.github/workflows/ci.yaml) for more details.

### Running it locally

We use [Tox](https://github.com/tox-dev/tox) to reliably run all integration approval steps in reproducible
isolated virtual environments. This is the recommended mechanism for running all integration approval steps
locally! You can read more about these checks in the next sections. However, if you are in a hurry... simply
run

```shell
tox
```

It's that simple! Note that this will take a while the first time you run it, since it will have to create all
the required isolated virtual environments (along with its dependencies) for each CI step.

### Tests and coverage reports

We use [`pytest`](https://github.com/pytest-dev/pytest) as our testing framework,
and [`pytest-cov`](https://pytest-cov.readthedocs.io/en/latest/) to track and measure code coverage. You can
find all configuration details in [`tox.ini`](tox.ini). To trigger all tests, simply run

```shell
# Standard invocation, using pytest:
pytest

# Alternatively, using Tox:
tox -e py37
```

With Tox, you can also run your tests against other supported python versions (e.g., `tox -e py38`).

### Linting

This project uses [pre-commit hooks](https://pre-commit.com/) to check and automatically fix any formatting
rules before creating a git commit. For more information on which hooks will run (e.g.,
[`black`](https://github.com/psf/black), [`isort`](https://github.com/pycqa/isort),
[`flake8`](https://github.com/pycqa/flake8), and [`mypy`](https://github.com/python/mypy)), have a look inside
the [`.pre-commit-config.yaml`](.pre-commit-config.yaml) configuration file. To manually trigger all linting
steps (i.e., all pre-commit hooks), run

```shell
# Standard invocation, using pre-commit:
pre-commit run --all-files

# Alternatively, using Tox:
tox -e lint
```

### Tools

In this section, we try to give more context on each of the tools used in CI.

- [Tox](https://github.com/tox-dev/tox) 👉 [`tox.ini`](tox.ini)
    - We use [Tox](https://github.com/tox-dev/tox) to reliably run all integration approval steps in
      reproducible isolated virtual environments. This is the recommended mechanism for running all
      integration approval steps locally!
- [`black`](https://github.com/psf/black) 👉 [`pyproject.toml`](pyproject.toml)
    - _"The uncompromising Python code formatter"_. We use `black` to automatically format Python code in a
      deterministic manner. We use a maximum line length of 120 characters.
- [`flake8`](https://github.com/pycqa/flake8) 👉 [`setup.cfg`](setup.cfg)
    - Used to check the style and quality of python code.
- [`isort`](https://github.com/pycqa/isort) 👉 [`setup.cfg`](setup.cfg)
    - Used to sort python imports.
- [`mypy`](https://github.com/python/mypy) 👉 [`mypy.ini`](mypy.ini)
    - A static type checker for Python. We use quite a strict configuration here, which can be tricky at
      times. Feel free to ask for help from the community by commenting on your issue or pull request.
- [`pytest`](https://github.com/pytest-dev/pytest) 👉 [`tox.ini`](tox.ini)
    - Testing framework for python code.
- [`pytest-cov`](https://pytest-cov.readthedocs.io/en/latest/) 👉 [`tox.ini`](tox.ini)
    - Coverage plugin for pytest.
- [EditorConfig](https://editorconfig.org/) 👉 [`.editorconfig`](.editorconfig)
    - This repository uses the [`.editorconfig`](.editorconfig)
      standard configuration file, which aims to ensure consistent style across multiple programming
      environments.

## Project structure

### Configuration files

For more context on some of the tools referenced below, refer to the sections
on [Continuous Integration](#continuous-integration).

- [`.github/workflows/ci.yaml`](.github/workflows/ci.yaml) - Workflow definition for our CI GitHub Actions
  pipeline.
- [`.pre-commit-config.yaml`](.pre-commit-config.yaml) - List of pre-commit hooks.
- [`.editorconfig`](.editorconfig) -
  [EditorConfig](https://editorconfig.org/) standard configuration file.
- [`mypy.ini`](mypy.ini) - Configuration for the `mypy` static type checker.
- [`pyproject.toml`](pyproject.toml) -
  [build system](https://setuptools.readthedocs.io/en/latest/build_meta.html) requirements (probably won't
  need to touch these!) and [`black`](https://github.com/psf/black) configurations.
- [`setup.cfg`](setup.cfg) - Here, we specify the package metadata, requirements, as well as configuration
  details for [`flake8`](https://github.com/pycqa/flake8) and [`isort`](https://github.com/pycqa/isort).
- [`tox.ini`](tox.ini) - Configuration for [`tox`](https://github.com/tox-dev/tox),
  [`pytest`](https://github.com/pytest-dev/pytest), and
  [`coverage`](https://coverage.readthedocs.io/en/latest/index.html).

