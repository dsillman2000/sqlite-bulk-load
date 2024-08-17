# sqlite-bulk-load

This is a simple example of how to bulk load data into a SQLite database using Shell.

## Requirements

Ensure the following are installed on your system.

1. Curl:
    - On linux, install with `sudo apt-get install curl`. Verify that it is installed with `curl --version`.
    - Purpose: ability to download public dataset for testing using Shell.

2. SQLite3:
    - On linux, install with `sudo apt-get install sqlite3`. Verify that it is installed with `sqlite3 --version`.
    - Purpose: database engine for storing & operating on data.

3. Python 3:
    - On linux, install with `sudo apt-get install python3`. Verify that it is installed with `python3 --version`.
    - Purpose: installing the next dependency.

4. Jinja CLI:
    - Install with `pip install jinja-cli`. Verify that it is installed with `jinja --version`.
    - Purpose: templating engine for generating SQL statements from Shell.

## Usage

1. Clone the repository:
    ```bash
    git clone <repository url>
    ```

2. Change into the project directory:
    ```bash
    cd sqlite-bulk-load
    ```

3. Download public dataset to disk, giving it a filename:
    ```bash
    sh download.sh <file name>
    ```

4. Execute the entrypoint script to load the data into a local SQLite database, additionally opening a sqlite CLI session:
    ```bash
    sh entrypoint.sh <file name>
    ```

## Docker file

If you have Docker installed, feel free to test using the Docker file provided.

## Acknowledgements

Author(s):

- David Sillman <dsillman2000@gmail.com>
- Jacob Sillman