# import psycopg2
# from psycopg2 import sql
# db_params = {
#     'dbname': 'ksiegarnia',
#     'user': 'postgres',
#     'password': 'postgres',
#     'host': 'localhost',
#     'port': '5432'
# }
# try:
#     connection = psycopg2.connect(**db_params)
#     cursor = connection.cursor()

#     # Przykładowe zapytanie SQL
#     query = sql.SQL("SELECT * FROM ksiazki")
    
#     # Wykonaj zapytanie
#     cursor.execute(query)

#     # Pobierz wyniki
#     results = cursor.fetchall()

#     # Wyświetl wyniki
#     for row in results:
#         print(row)

# except psycopg2.Error as e:
#     print("Błąd połączenia z bazą danych:", e)