1. Install the [Cookiecutter](https://github.com/cookiecutter/cookiecutter) utility
   ```shell
   pip install -U cookiecutter
   ```
2. Generate a project from this template using the `cookiecutter` utility
   ```shell
   cookiecutter gh:tpvasconcelos/python-library-template
   ```
3. Run `git init` to initialise a new git repository
4. Run `make init` to install a new virtual environment and all it's dependencies
5. Make sure you always work within this virtual environment (`source .venv/bin/activate`). Alternatively, you
   can also set up your IDE to always point to the correct python interpreter.
    - In PyCharm, open `Preferences -> Project -> Project Interpreter` and point the python interpreter
      to `.venv/bin/python`.

## API Tokens

You will need to generate and/or define some API tokens required to run a few automated GitHub Actions
workflows.

### PyPi

You will need to generate API tokens for [PyPi](https://pypi.org/manage/account/token/) and
[TestPyPi](https://test.pypi.org/manage/account/token/). You should define the scope to include only
{{cookiecutter.project_slug}}! We also suggest that you name this token
`github_actions_{{cookiecutter.project_slug}}` as to distinguish it from other tokens you might use locally.
Save `PYPI_TOKEN` and `PYPI_TOKEN_TEST` as [Action secrets](TODO).

You might also want to generate PyPi tokens for local use. Read more on how you can configure your
[~/.pypirc](https://packaging.python.org/specifications/pypirc/) file.

## Customizations:

[] This project uses the Apache Software License 2.0 by default. If you want to use a different license,
update the `LICENSE` and `setup.cfg` files accordingly.
[] Go through the `setup.cfg` file. You might want to review fields such as
`license` and `classifiers` or fill in fields like `install_requires` or
`keywords`.
[]

## Todo

- <https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file>
