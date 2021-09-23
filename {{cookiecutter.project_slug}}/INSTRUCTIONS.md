# Setup Instructions

## First steps

First, you will want to get your development environment up and running. This includes integrating you local
repository with a remote GitHub repository. If you haven't already, create a
[new GitHub repository](https://github.com/new) to host your project. Name it `{{cookiecutter.project_slug}}`,
such that the final URL points to:
<https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.project_slug}}>

Using the [make](https://en.wikipedia.org/wiki/Make_(software)) build automation tool, with a single command
you can 1) initialise your local git repository and sync it with the remote on GitHub, 2) create a new virtual
environment (under `.venv`), 3) install your project in
[editable mode](https://pip.pypa.io/en/stable/cli/pip_install/#install-editable) (along with all dev
dependencies), and 4) set up and install all [pre-commit hooks](https://pre-commit.com/). Feel free to peak
inside the `Makefile` at any time to see exactly what is being run, and in which order. Then, simply run

```shell
make init
```

Make sure you always work within this virtual environment (i.e., `$ source .venv/bin/activate`). On top of
this, you should also set up your IDE to always point to this python interpreter. In PyCharm, open
`Preferences -> Project: {{cookiecutter.project_slug}} -> Project Interpreter` and point the python
interpreter to `.venv/bin/python`.

Before you start writing code and developing features, you should also run the
[Tox](https://github.com/tox-dev/tox) utility to confirm that all integration approval steps are passing
locally. This will take some time (>1 minute) the first time you run the command, since it will have to create
isolated environments for each CI step.

## Configuring your GitHub repository

- [ ] Set up automatic deletion of merged branches
  ([guide](https://docs.github.com/en/github/administering-a-repository/configuring-pull-request-merges/managing-the-automatic-deletion-of-branches))
- [ ] Set up the following branch protection rules to `develop` and `master` branches
  ([guide](https://docs.github.com/en/github/administering-a-repository/defining-the-mergeability-of-pull-requests/managing-a-branch-protection-rule)).
  You can use this ~pattern~
  [hack](https://stackoverflow.com/questions/53135414/how-to-apply-github-branch-rules-to-two-branches) to
  match both branches`[dm][ea][vs]*`
  - [ ] Require at least one pull request review from a code-owner before merging
  - [ ] Require status checks to pass before merging
  - [ ] Require conversation resolution before merging


## Publishing to PyPi

In order to reserve your library name in PyPi, I suggest publishing this initial (and featureless) version of
your package right away. This way, you avoid having to rename your project and reconfiguring some of the
integrated monitoring APIs. We also use the `make` build automation utility here.

Always test publishing your releases to Test PyPi first.

```shell
make release-test-pypi
```

Then, do the same for the main PyPi repository

```shell
make release-pypi
```

## API integrations

You might have noticed that the generated `README.md` comes pre-configured with several project metadata
badges. This includes a code-coverage badge from Codecov and a code-quality badge from Codacy, as well as
package metadata from PyPi. You will need to generate and/or define API tokens required to run some of the
automated GitHub Actions workflows. These API tokens should be saved as
[GitHub repository secret](https://docs.github.com/en/actions/reference/encrypted-secrets).

### Codacy

If you are new to Codacy, have a look at the
[Getting Started Guide](https://docs.codacy.com/getting-started/getting-started-with-codacy/). Once you have
successfully created a Codacy account and linked it to your GitHib account, you can programmatically enable
tracking for your repository with the following command. If you don't have an API Token, create on by
navigating to the [Access Management Settings](https://app.codacy.com/account/access-management).

```shell
curl -X POST https://app.codacy.com/api/v3/repositories \
  -H 'Content-Type: application/json' \
  -H 'api-token: <API_TOKEN>' \
  -d '{"provider":"gh", "repositoryFullPath":"{{cookiecutter.github_username}}/{{cookiecutter.project_slug}}"}'
```

Additionally, you will need to
[generate a project API token](https://docs.codacy.com/codacy-api/api-tokens/#project-api-tokens) and save it
as a repository secret named `CODACY_PROJECT_TOKEN`. This is required to send coverage metrics to Codacy in
CI.

### Codecov

If you are new to Codecov, have a look at the [Quick Start Guide](https://docs.codecov.com/docs/quick-start).
Once you have successfully created a Codecov account, navigate to your
[project page](https://app.codecov.io/gh/{{cookiecutter.github_username}}/{{cookiecutter.project_slug}}). From
this page, you will need to copy the project API token and save it as a GitHub repository secret and name
it `CODECOV_TOKEN`. This is required to send coverage metrics to Codecov in CI.

### PyPi

You will need to generate API tokens for [PyPi](https://pypi.org/manage/account/token/) and
[TestPyPi](https://test.pypi.org/manage/account/token/). You should define the scope to include only
{{cookiecutter.project_slug}}! We also suggest that you name this token
`gh_actions_{{cookiecutter.project_slug}}` as to distinguish it from other tokens you might use locally. Save
these tokens as repository secrets. Name them `PYPI_TOKEN` and `PYPI_TOKEN_TEST`, respectively.

This is not a requirement, but uou might also want to generate PyPi tokens for local use. Read more on how you
can configure and use a [~/.pypirc](https://packaging.python.org/specifications/pypirc/) file to manage this.

## Customizations:

- This project uses the Apache Software License 2.0 by default. If you want to use a different license, update
  the `LICENSE` file to include your preferred license instead. You should also update the values in
  the `metadata.license` and `metadata.classifiers` keys in the `setup.cfg` file.
- Go through the `setup.cfg` file. You might want to review fields such as
  `metadata.license`, `metadata.classifiers`, and `metadata.keywords`. You might also need to update
  `options.install_requires` and `options.extras_require` to account for your specific project requirements.

## Todo

- <https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file>
