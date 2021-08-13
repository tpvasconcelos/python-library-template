def test_version() -> None:
    from {{cookiecutter.project_slug}} import __version__

    assert __version__ == "{{cookiecutter.version}}"
