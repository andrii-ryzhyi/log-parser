# notsobad-testcase
### Script search server.log file for failed records and generates report on the results of all failed transactions
## Environment: 
This script was designed to run on **CentOS Linux release 7.4.1708 (Core)** with **Python 2.7.5** version installed
## Dependency list:
Before running the script, please ensure you meet below requirements
1. Python 2.7.* version installed
2. psycopg2 package installed:
    ```sudo pip install psycopg2```
3. PyYaml package installed:
    ```sudo pip install pyyaml```
4. Change config.yaml file with your configuration parameters and place it within the same folder

Run the script: ```python parser.py```
