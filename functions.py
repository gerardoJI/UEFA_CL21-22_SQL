#Functions sheet 

def add_id_to_file():

    '''
    The function reads multiple CSV files (data_attacking.csv, data_attempts.csv, etc.).
    Merges each of them with another file (key_stats_modified.csv) using common columns (player_name, club, and position).
    It adds the id_player from the merged data, removes the player_name, club, position, and match_played columns, and cleans up any rows with null values.
    The cleaned and modified data is saved to new CSV files with _fmodified appended to the file name.
    '''

    import pandas as pd
    # Read the two CSV files
    files = ["Data/data_attacking.csv", "Data/data_attempts.csv", "Data/defending.csv", 
             "Data/disciplinary.csv", "Data/distributon.csv", "Data/goalkeeping.csv", "Data/goals.csv"]
    output_files = []  # List to store the names of the generated files
    for file2 in files:
        file1 = "Data/key_stats_modified.csv"
        df1 = pd.read_csv(file1)  # Contains the 'id_player' column
        df2 = pd.read_csv(file2)  # Needs to add the 'id_player' column
        
        # Perform a merge between the two DataFrames using 'player_name', 'club', and 'position'
        merged_df = pd.merge(df2, df1[['player_name', 'club', 'position', 'id_player']], 
                             on=['player_name', 'club', 'position'], 
                             how='left')
        
        # Reorder the columns so that 'id_player' is at the beginning
        cols = ['id_player'] + [col for col in merged_df.columns if col != 'id_player']
        merged_df = merged_df[cols]

        # Remove the columns 'player_name', 'club', 'position', 
        merged_df.drop(columns=['player_name', 'club', 'position', 'match_played'], inplace=True)

        # Check the number of rows before cleaning
        rows_before = len(merged_df)
        
        # Remove rows with null values
        df_cleaned = merged_df.dropna()
        
        # Check the number of rows after cleaning
        rows_after = len(df_cleaned)
        
        # Print the report
        print(f"Number of rows before cleaning: {rows_before}")
        print(f"Number of rows after cleaning: {rows_after}")
        
        # If rows were deleted, show a message
        if rows_before != rows_after:
            print("Rows with null values were deleted.\n")
        else:
            print("No rows with null values were deleted.\n")
        
        # Save the resulting DataFrame with the new 'id_player' column to a new CSV file
        output_file = file2.split('.')[0] + '_fmodified.csv'
        df_cleaned.to_csv(output_file, index=False, encoding='latin-1', sep=';', errors='replace')
        output_files.append(output_file)
    
    # Return the list of generated files
    return output_files

def main_file():
    '''
    Reads the key_stats_modified.csv file.
    Keeps only the columns id_player, player_name, club, and position.
    Outputs the first 12 rows (though head(12) won't change the DataFrame, it is useful for previewing data).
    Saves the filtered DataFrame into a new CSV file main3.csv under the Data folder, with specified encoding (latin-1) and separator (;).
    Returns the output file path.
    '''
    import pandas as pd
    df=pd.read_csv("Data\key_stats_modified.csv")
    keep=["id_player","player_name","club","position"]
    df=df[keep]
    df.head(12)
    output_file=df.to_csv(r'Data\main3.csv', index=False, encoding='latin-1',sep=';',errors='replace')
    return output_file