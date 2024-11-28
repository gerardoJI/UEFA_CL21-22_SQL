#Functions2: for data_analysis notebook

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


#---------------------------------Function to creat bubble chart--------------------------------------

def bubble_chart(df, x_data, y_data, bub_size_data, title):
    '''
    This function creates a bubble chart from data in a dataframe.
    Arguments:
    - df: Dataframe to be read
    - x_data: X axis data column from dataframe
    - y_data: Y axis data column from dataframe
    - bub_size_data: Data column from dataframe to choose bubble size
    - title: Title for the chart

    Returns: Bubble chart
    '''
    import plotly.express as px
    
    # Create the bubble chart
    fig = px.scatter(df, 
                    x=x_data, 
                    y=y_data, 
                    size=bub_size_data,  
                    color='player_name',  # Differentiates the bubbles based on the player's position
                    hover_name='player_name',  # Displays the player's name when the mouse hovers over
                    title=title,
                    labels={x_data: x_data.capitalize().replace("_"," "), 
                            y_data: y_data.capitalize().replace("_"," "), 
                            bub_size_data: bub_size_data.capitalize().replace("_"," ")},
                    template='plotly_dark'  # Dark theme
                    )

    # Configure layout to improve visualization
    fig.update_layout(
        xaxis_title=x_data.capitalize().replace("_"," "),
        yaxis_title=y_data.capitalize().replace("_"," "),
        title_font=dict(size=20),
        title_x=0.5  # Center the title
    )

    # Show the chart
    fig.show()


#---------------------------------Function to creat bars chart--------------------------------------------

def bar_chart(df,x_data,val_bars,title_chart):

    '''
    This function creates a bubble chart from data in a dataframe.
    Arguments:
    - df: Dataframe to be read
    - x_data: X axis data column from dataframe
    - val_bars: List with columns to include in each bar
    - title_chart: Title for the chart

    Returns: bars chart
    '''

    import plotly.express as px
    import pandas as pd

    # Assuming you already have a dataframe `df` with the necessary columns

    # Create a new dataframe for the bar chart where each player has multiple metrics (cross_accuracy, pass_accuracy, balls_recoverd, total_attempts)
    df_long = pd.melt(df, 
                    id_vars=[x_data],  # Keep player_name as the identifier
                    value_vars=val_bars,  # List with metrics to be represented as bars
                    var_name='Metric',  # New column that will indicate the type of metric
                    value_name='Value')  # New column for the values of each metric

    # Create the stacked bar chart
    fig = px.bar(df_long, 
                x=x_data, 
                y='Value', 
                color='Metric',  # Differentiate the stacked bars by metric
                title=title_chart,  # Title for the chart
                labels={x_data: x_data.capitalize().replace("_"," "), 
                        'Value': 'Performance Value', 
                        'Metric': 'Metrics'},
                template='plotly_dark',  # Dark theme for the chart
                barmode='stack')  # Stack the bars for each player

    # Customize layout
    fig.update_layout(
        title_font=dict(size=20),
        title_x=0.5,  # Center the title
        xaxis_title=x_data.capitalize().replace("_"," "),
        yaxis_title='Performance Value',
        xaxis_tickangle=-45  # Rotate player names to avoid overlap
    )

    # Show the chart
    fig.show()