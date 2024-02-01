import os
import pandas as pd
import psycopg2
from urllib.parse import urlparse


def lambda_handler(event, context):
    # Variabile d'ambiente
    # Probabile che vada cambiata per essere usata con dei secrets
    db_url = os.environ['DATABASE_URL']

    # Parse e split della variabile dell'URL
    parsed_url = urlparse(db_url)
    db_host = parsed_url.hostname
    db_port = parsed_url.port
    db_user = parsed_url.username
    db_password = parsed_url.password
    db_name = parsed_url.path.lstrip('/')

    # Ottieni il percorso del file CSV dal payload dell'evento
    s3_bucket = event['Records'][0]['s3']['bucket']['name']
    s3_key = event['Records'][0]['s3']['object']['key']

    # Crea l'URL S3
    s3_url = f's3://{s3_bucket}/{s3_key}'

    # Leggi i dati dal file CSV utilizzando pandas
    df = pd.read_csv(s3_url)

    # Connessione al database PostgreSQL
    conn = psycopg2.connect(
        host=db_host,
        port=db_port,
        user=db_user,
        password=db_password,
        database=db_name
    )

    try:
        with conn.cursor() as cursor:
            # Itera sul DataFrame e inserisci i dati nel database
            for index, row in df.iterrows():
                # Qua mancano i nomi della tabella e dei campi da popolare
                cursor.execute(
                    "INSERT INTO nome_tabella (colonna1, colonna2, colonna3)" +
                    "VALUES (%s, %s, %s)",
                    (row['colonna1'], row['colonna2'], row['colonna3']))

        # Commit delle modifiche
        conn.commit()

    except Exception as e:
        print(f"Errore durante l'inserimento dei dati nel database: {str(e)}")

    finally:
        # Chiudi la connessione
        conn.close()

    return {
        'statusCode': 200,
        'body': 'Dati inseriti nel database con successo!'
    }
