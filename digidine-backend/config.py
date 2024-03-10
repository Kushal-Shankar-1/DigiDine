import os
class Config:
    """Set Flask configuration variables."""
    # Database connection parameters
    if "DB_HOST" in os.environ:
        DB_HOST = os.environ["DB_HOST"]
    else:
        DB_HOST = "localhost"
    DB_USER = "root"  # Database username
    DB_PASSWORD = "root"  # Database password
    DB_NAME = "digidine"  # Database name

    # You can add other configuration settings as needed, like secret keys, API keys, etc.
