from flask import Blueprint, render_template , request, redirect, url_for , session
from datetime import timedelta
from flask_paginate import Pagination, get_page_parameter
import psycopg2
views = Blueprint('views', __name__)
# db_params = {
#     'dbname': 'postgres',
#     'user': 'postgres',
#     'password': 'postgres',
#     'host': 'bookstore.cshzuj1alait.eu-north-1.rds.amazonaws.com',
#     'port': '5432'
# }
db_params = {
    'dbname': 'ksiegarnia',
    'user': 'postgres',
    'password': 'postgres',
    'host': 'localhost',
    'port': '5432'
}


@views.route('/')
def home():
    return render_template('base.html')

@views.route('/books')
def books():
    page = request.args.get(get_page_parameter(), type=int, default=1)
    per_page = 16
    offset = (page - 1) * per_page
    
    connection = psycopg2.connect(**db_params)
    cursor = connection.cursor()
    query = """
    SELECT * FROM ksiazki
    ORDER BY ksiazka_id
    LIMIT %s OFFSET %s
    """
    cursor.execute(query, (per_page, offset))
    results = cursor.fetchall()
    cursor.execute("SELECT COUNT(*) FROM ksiazki")
    total_records = cursor.fetchone()[0]
    pagination = Pagination(
        page=page, 
        per_page=per_page, 
        total=total_records,
        css_framework='bootstrap5',
        prev_label='Poprzednia',
        next_label='Następna',)
    cursor.close()
    connection.close()
    print(f"Page: {page}, Per Page: {per_page}, Offset: {offset}, total: {total_records}")
    return render_template('books.html', results=results, pagination=pagination)

@views.route('/item')
def item(item_info=None):
    item_info = request.args.get('item_info', None)
    connection = psycopg2.connect(**db_params)
    cursor = connection.cursor()
    try:
        query = f"SELECT * FROM ksiazki WHERE ksiazka_id = {item_info}"
        cursor.execute(query,item_info)
        info = cursor.fetchall()
        print(info)

        query1 = f"select op.ocena, op.ocena_tekst, kl.imie, kl.nazwisko FROM opinie AS op JOIN klienci AS kl ON op.klient_id = kl.klient_id JOIN ksiazki AS ks ON ks.ksiazka_id = op.ksiazka_id WHERE ks.ksiazka_id = {item_info} "
        cursor.execute(query1,item_info)
        comments= cursor.fetchall()
        print(comments)
        cursor.close()
        connection.close()

        return render_template('item.html',info=info,comments=comments)
    except Exception as e:
        print(e)
        return redirect(url_for('views.books'))
    

@views.route('/about_us')
def about_us():
    return render_template('about_us.html')