#Functions sheet 
def read_data():

    return 


def add_id_column(csv_file):
    """
    Esta función lee archivo csv y agrega la columna id_player, generando los id de cada jugador.
    """
    import pandas as pd
    # Leer el archivo CSV
    df = pd.read_csv(csv_file)
    
    # Crear la columna 'id_player' con una sucesión de números enteros concatenados con 'ID_'
    df.insert(0, 'id_player', ['ID_' + str(i) for i in range(1, len(df) + 1)])
    
    # Guardar el DataFrame modificado en un nuevo archivo CSV
    output_file = csv_file.split('.')[0] + '_modified.csv'
    df.to_csv(output_file, index=False)
    
    return output_file


def add_id_to_file():
    import pandas as pd
    # Leer los dos archivos CSV
    files=["Data\data_attacking.csv","Data\data_attempts.csv","Data\defending.csv","Data\disciplinary.csv","Data\distributon.csv","Data\goalkeeping.csv","Data\goals.csv"]
    output_files = []  # Lista para almacenar los nombres de los archivos generados
    for file2 in files:
        file1="Data\key_stats_modified.csv"
        df1 = pd.read_csv(file1)  # Contiene la columna 'id_player'
        df2 = pd.read_csv(file2)  # Necesita agregar la columna 'id_player'
        
        # Realizar un merge entre los dos DataFrames utilizando 'player_name', 'club' y 'position'
        merged_df = pd.merge(df2, df1[['player_name', 'club', 'position', 'id_player']], 
                            on=['player_name', 'club', 'position'], 
                            how='left')
        
        # Reordenar las columnas para que 'id_player' esté al principio
        cols = ['id_player'] + [col for col in merged_df.columns if col != 'id_player']
        merged_df = merged_df[cols]

        # Eliminar las columnas 'player_name', 'club', 'position', 
        merged_df.drop(columns=['player_name', 'club', 'position','match_played'], inplace=True)

            # Verificar la cantidad de filas antes de la limpieza
        rows_before = len(merged_df)
        
        # Eliminar filas con valores nulos
        df_cleaned = merged_df.dropna()
        
        # Verificar la cantidad de filas después de la limpieza
        rows_after = len(df_cleaned)
        
        # Imprimir el reporte
        print(f"Cantidad de filas antes de la limpieza: {rows_before}")
        print(f"Cantidad de filas después de la limpieza: {rows_after}")
        
        # Si hubo filas eliminadas, mostrar un mensaje
        if rows_before != rows_after:
            print("Se eliminaron filas con valores nulos.")
        else:
            print("No se eliminaron filas con valores nulos.")
        
        # Guardar el DataFrame resultante con la nueva columna 'id_player' en un nuevo archivo CSV
        output_file = file2.split('.')[0] + '_fmodified.csv'
        df_cleaned.to_csv(output_file, index=False)
        output_files.append(output_file)
    
    # Retornar la lista de archivos generados
    return output_files