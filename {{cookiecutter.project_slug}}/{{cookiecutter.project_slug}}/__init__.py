import logging

from {{cookiecutter.project_slug}}._version import __version__

__all__ = [
    "__version__",
]


logging.getLogger(__name__).addHandler(logging.NullHandler())
