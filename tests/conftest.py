import os

import pytest
from click.testing import CliRunner


@pytest.fixture(autouse=True)
def _test_env():
    os.environ["SENTRY_DSN"] = "None"
    os.environ["WORKSPACE"] = "test"


@pytest.fixture
def runner():
    return CliRunner()
