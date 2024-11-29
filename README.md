# Player Scouting Analysis ⚽📈

**Hello there!** 🚂🚂  I'm Gerardo Jiménez (www.linkedin.com/in/gerardo-jimenez-islas), a mining and metallurgy engineer exploring the coding world.

This work presents a graphical review of the performance records of football players who participated in the 2021/2022 UEFA Champions League season, with the aim of recommending some of them for a potential transfer. The data used in this analysis was obtained from Kaggle, contributed by Ali Sultanov.

##  Overview

###  Data 💻

To conduct the analysis, the CSV files containing the data are processed in Python to explore and clean the information. As a result, new CSV files are generated, which are then used to populate a MySQL database.
Link to Kaggle article: https://www.kaggle.com/code/alisultanov/eda-champions-league-21-22/input
![A1](a1.jpg)

**Quick view of the estructure of the function used to export MySQL queries to Python**

```python

#---------------------------------Reading queries from MySQL to python--------------------------------------
def read_query():
    '''
    This function reads mySQL queries from the ucl21_22 database.
    It returns a list with dataframes from each query result.
    '''
    import os
    from dotenv import load_dotenv
    import pandas as pd
    from sqlalchemy import create_engine
    from urllib.parse import quote_plus

    # Load the .env file with the db_pass password
    load_dotenv()

    # Get the password securely
    db_pass = os.getenv("db_pass")
    if not db_pass:
        raise ValueError("The 'db_pass' environment variable is not defined in the .env file.")

    # Database name
    bd = "ucl21_22"

    # Escape special characters in the password and the database name
    escaped_db_pass = quote_plus(db_pass)  # Escape password
    escaped_bd = quote_plus(bd)            # Escape database name

    # Create the connection string
    connection_string = f'mysql+pymysql://root:{escaped_db_pass}@localhost/{escaped_bd}'
    engine = create_engine(connection_string)

    # Read the SQL query from the file
    data_frames = []
    for query in range(1, 5):
        sql_file_path = f"queries/query{query}.sql"  # Ensure the file path is correct
        with open(sql_file_path, 'r', encoding='utf-8') as file:
            query_content = file.read()

        # Print the query for debugging (if necessary)
        # print(f"SQL Query: {query_content[:100]}...")

        # Execute the SQL query and return the result as a DataFrame
        df = pd.read_sql(query_content, con=engine)
        data_frames.append(df)

    return data_frames
```


### 💡 Experience during development

- Creation of a MySQL database from CSV files, with a star schema.
- Data retrieval through the development of queries and subqueries, joins, and CTEs in MySQL.
- Importing MySQL queries into Python, and performing graphical analysis of the data.
---

![A2](a2.jpg)
