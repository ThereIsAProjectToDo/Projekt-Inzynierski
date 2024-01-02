import json
from flask import Blueprint, render_template , request, redirect, url_for , session , jsonify , flash
from datetime import timedelta
from flask_paginate import Pagination, get_page_parameter
import psycopg2
import boto3
import os
import itertools
import ast
views = Blueprint('views', __name__)
# db_params = {
#     'dbname': 'postgres',
#     'user': 'postgres',
#     'password': 'postgres',
#     'host': 'bookstore.cshzuj1alait.eu-north-1.rds.amazonaws.com',
#     'port': '5432'
# }
db_params = {
    'dbname': 'postgres',
    'user': 'postgres',
    'password': 'postgres',
    'host': 'ksiengarnia-db.cshzuj1alait.eu-north-1.rds.amazonaws.com',
    'port': '5432'
}
# Shopping_list = list()
lambda_client = boto3.client('lambda', region_name='eu-north-1')



swear_words = ['chuj','chuja', 'chujek', 'chuju', 'chujem', 'chujnia',
'chujowy', 'chujowa', 'chujowe', 'cipa', 'cipę', 'cipe', 'cipą',
'cipie', 'dojebać','dojebac', 'dojebie', 'dojebał', 'dojebal',
'dojebała', 'dojebala', 'dojebałem', 'dojebalem', 'dojebałam',
'dojebalam', 'dojebię', 'dojebie', 'dopieprzać', 'dopieprzac',
'dopierdalać', 'dopierdalac', 'dopierdala', 'dopierdalał',
'dopierdalal', 'dopierdalała', 'dopierdalala', 'dopierdoli',
'dopierdolił', 'dopierdolil', 'dopierdolę', 'dopierdole', 'dopierdoli',
'dopierdalający', 'dopierdalajacy', 'dopierdolić', 'dopierdolic',
'dupa', 'dupie', 'dupą', 'dupcia', 'dupeczka', 'dupy', 'dupe', 'huj',
'hujek', 'hujnia', 'huja', 'huje', 'hujem', 'huju', 'jebać', 'jebac',
'jebał', 'jebal', 'jebie', 'jebią', 'jebia', 'jebak', 'jebaka', 'jebal',
'jebał', 'jebany', 'jebane', 'jebanka', 'jebanko', 'jebankiem',
'jebanymi', 'jebana', 'jebanym', 'jebanej', 'jebaną', 'jebana',
'jebani', 'jebanych', 'jebanymi', 'jebcie', 'jebiący', 'jebiacy',
'jebiąca', 'jebiaca', 'jebiącego', 'jebiacego', 'jebiącej', 'jebiacej',
'jebia', 'jebią', 'jebie', 'jebię', 'jebliwy', 'jebnąć', 'jebnac',
'jebnąc', 'jebnać', 'jebnął', 'jebnal', 'jebną', 'jebna', 'jebnęła',
'jebnela', 'jebnie', 'jebnij', 'jebut', 'koorwa', 'kórwa', 'kurestwo',
'kurew', 'kurewski', 'kurewska', 'kurewskiej', 'kurewską', 'kurewska',
'kurewsko', 'kurewstwo', 'kurwa', 'kurwaa', 'kurwami', 'kurwą', 'kurwe',
'kurwę', 'kurwie', 'kurwiska', 'kurwo', 'kurwy', 'kurwach', 'kurwami',
'kurewski', 'kurwiarz', 'kurwiący', 'kurwica', 'kurwić', 'kurwic',
'kurwidołek', 'kurwik', 'kurwiki', 'kurwiszcze', 'kurwiszon',
'kurwiszona', 'kurwiszonem', 'kurwiszony', 'kutas', 'kutasa', 'kutasie',
'kutasem', 'kutasy', 'kutasów', 'kutasow', 'kutasach', 'kutasami',
'matkojebca', 'matkojebcy', 'matkojebcą', 'matkojebca', 'matkojebcami',
'matkojebcach', 'nabarłożyć', 'najebać', 'najebac', 'najebał',
'najebal', 'najebała', 'najebala', 'najebane', 'najebany', 'najebaną',
'najebana', 'najebie', 'najebią', 'najebia', 'naopierdalać',
'naopierdalac', 'naopierdalał', 'naopierdalal', 'naopierdalała',
'naopierdalala', 'naopierdalała', 'napierdalać', 'napierdalac',
'napierdalający', 'napierdalajacy', 'napierdolić', 'napierdolic',
'nawpierdalać', 'nawpierdalac', 'nawpierdalał', 'nawpierdalal',
'nawpierdalała', 'nawpierdalala', 'obsrywać', 'obsrywac', 'obsrywający',
'obsrywajacy', 'odpieprzać', 'odpieprzac', 'odpieprzy', 'odpieprzył',
'odpieprzyl', 'odpieprzyła', 'odpieprzyla', 'odpierdalać',
'odpierdalac', 'odpierdol', 'odpierdolił', 'odpierdolil',
'odpierdoliła', 'odpierdolila', 'odpierdoli', 'odpierdalający',
'odpierdalajacy', 'odpierdalająca', 'odpierdalajaca', 'odpierdolić',
'odpierdolic', 'odpierdoli', 'odpierdolił', 'opieprzający',
'opierdalać', 'opierdalac', 'opierdala', 'opierdalający',
'opierdalajacy', 'opierdol', 'opierdolić', 'opierdolic', 'opierdoli',
'opierdolą', 'opierdola', 'piczka', 'pieprznięty', 'pieprzniety',
'pieprzony', 'pierdel', 'pierdlu', 'pierdolą', 'pierdola', 'pierdolący',
'pierdolacy', 'pierdoląca', 'pierdolaca', 'pierdol', 'pierdole',
'pierdolenie', 'pierdoleniem', 'pierdoleniu', 'pierdolę', 'pierdolec',
'pierdola', 'pierdolą', 'pierdolić', 'pierdolicie', 'pierdolic',
'pierdolił', 'pierdolil', 'pierdoliła', 'pierdolila', 'pierdoli',
'pierdolnięty', 'pierdolniety', 'pierdolisz', 'pierdolnąć',
'pierdolnac', 'pierdolnął', 'pierdolnal', 'pierdolnęła', 'pierdolnela',
'pierdolnie', 'pierdolnięty', 'pierdolnij', 'pierdolnik', 'pierdolona',
'pierdolone', 'pierdolony', 'pierdołki', 'pierdzący', 'pierdzieć',
'pierdziec', 'pizda', 'pizdą', 'pizde', 'pizdę', 'piździe', 'pizdzie',
'pizdnąć', 'pizdnac', 'pizdu', 'podpierdalać', 'podpierdalac',
'podpierdala', 'podpierdalający', 'podpierdalajacy', 'podpierdolić',
'podpierdolic', 'podpierdoli', 'pojeb', 'pojeba', 'pojebami',
'pojebani', 'pojebanego', 'pojebanemu', 'pojebani', 'pojebany',
'pojebanych', 'pojebanym', 'pojebanymi', 'pojebem', 'pojebać',
'pojebac', 'pojebalo', 'popierdala', 'popierdalac', 'popierdalać',
'popierdolić', 'popierdolic', 'popierdoli', 'popierdolonego',
'popierdolonemu', 'popierdolonym', 'popierdolone', 'popierdoleni',
'popierdolony', 'porozpierdalać', 'porozpierdala', 'porozpierdalac',
'poruchac', 'poruchać', 'przejebać', 'przejebane', 'przejebac',
'przyjebali', 'przepierdalać', 'przepierdalac', 'przepierdala',
'przepierdalający', 'przepierdalajacy', 'przepierdalająca',
'przepierdalajaca', 'przepierdolić', 'przepierdolic', 'przyjebać',
'przyjebac', 'przyjebie', 'przyjebała', 'przyjebala', 'przyjebał',
'przyjebal', 'przypieprzać', 'przypieprzac', 'przypieprzający',
'przypieprzajacy', 'przypieprzająca', 'przypieprzajaca',
'przypierdalać', 'przypierdalac', 'przypierdala', 'przypierdoli',
'przypierdalający', 'przypierdalajacy', 'przypierdolić',
'przypierdolic', 'qrwa', 'rozjebać', 'rozjebac', 'rozjebie',
'rozjebała', 'rozjebią', 'rozpierdalać', 'rozpierdalac', 'rozpierdala',
'rozpierdolić', 'rozpierdolic', 'rozpierdole', 'rozpierdoli',
'rozpierducha', 'skurwić', 'skurwiel', 'skurwiela', 'skurwielem',
'skurwielu', 'skurwysyn', 'skurwysynów', 'skurwysynow', 'skurwysyna',
'skurwysynem', 'skurwysynu', 'skurwysyny', 'skurwysyński',
'skurwysynski', 'skurwysyństwo', 'skurwysynstwo', 'spieprzać',
'spieprzac', 'spieprza', 'spieprzaj', 'spieprzajcie', 'spieprzają',
'spieprzaja', 'spieprzający', 'spieprzajacy', 'spieprzająca',
'spieprzajaca', 'spierdalać', 'spierdalac', 'spierdala', 'spierdalał',
'spierdalała', 'spierdalal', 'spierdalalcie', 'spierdalala',
'spierdalający', 'spierdalajacy', 'spierdolić', 'spierdolic',
'spierdoli', 'spierdoliła', 'spierdoliło', 'spierdolą', 'spierdola',
'srać', 'srac', 'srający', 'srajacy', 'srając', 'srajac', 'sraj',
'sukinsyn', 'sukinsyny', 'sukinsynom', 'sukinsynowi', 'sukinsynów',
'sukinsynow', 'śmierdziel', 'udupić', 'ujebać', 'ujebac', 'ujebał',
'ujebal', 'ujebana', 'ujebany', 'ujebie', 'ujebała', 'ujebala',
'upierdalać', 'upierdalac', 'upierdala', 'upierdoli', 'upierdolić',
'upierdolic', 'upierdoli', 'upierdolą', 'upierdola', 'upierdoleni',
'wjebać', 'wjebac', 'wjebie', 'wjebią', 'wjebia', 'wjebiemy',
'wjebiecie', 'wkurwiać', 'wkurwiac', 'wkurwi', 'wkurwia', 'wkurwiał',
'wkurwial', 'wkurwiający', 'wkurwiajacy', 'wkurwiająca', 'wkurwiajaca',
'wkurwić', 'wkurwic', 'wkurwi', 'wkurwiacie', 'wkurwiają', 'wkurwiali',
'wkurwią', 'wkurwia', 'wkurwimy', 'wkurwicie', 'wkurwiacie', 'wkurwić',
'wkurwic', 'wkurwia', 'wpierdalać', 'wpierdalac', 'wpierdalający',
'wpierdalajacy', 'wpierdol', 'wpierdolić', 'wpierdolic', 'wpizdu',
'wyjebać', 'wyjebac', 'wyjebali', 'wyjebał', 'wyjebac', 'wyjebała',
'wyjebały', 'wyjebie', 'wyjebią', 'wyjebia', 'wyjebiesz', 'wyjebie',
'wyjebiecie', 'wyjebiemy', 'wypieprzać', 'wypieprzac', 'wypieprza',
'wypieprzał', 'wypieprzal', 'wypieprzała', 'wypieprzala', 'wypieprzy',
'wypieprzyła', 'wypieprzyla', 'wypieprzył', 'wypieprzyl', 'wypierdal',
'wypierdalać', 'wypierdalac', 'wypierdala', 'wypierdalaj',
'wypierdalał', 'wypierdalal', 'wypierdalała', 'wypierdalala',
'wypierdalać', 'wypierdolić', 'wypierdolic', 'wypierdoli',
'wypierdolimy', 'wypierdolicie', 'wypierdolą', 'wypierdola',
'wypierdolili', 'wypierdolił', 'wypierdolil', 'wypierdoliła',
'wypierdolila', 'zajebać', 'zajebac', 'zajebie', 'zajebią', 'zajebia',
'zajebiał', 'zajebial', 'zajebała', 'zajebiala', 'zajebali', 'zajebana',
'zajebani', 'zajebane', 'zajebany', 'zajebanych', 'zajebanym',
'zajebanymi', 'zajebiste', 'zajebisty', 'zajebistych', 'zajebista',
'zajebistym', 'zajebistymi', 'zajebiście', 'zajebiscie', 'zapieprzyć',
'zapieprzyc', 'zapieprzy', 'zapieprzył', 'zapieprzyl', 'zapieprzyła',
'zapieprzyla', 'zapieprzą', 'zapieprza', 'zapieprzy', 'zapieprzymy',
'zapieprzycie', 'zapieprzysz', 'zapierdala', 'zapierdalać',
'zapierdalac', 'zapierdalaja', 'zapierdalał', 'zapierdalaj',
'zapierdalajcie', 'zapierdalała', 'zapierdalala', 'zapierdalali',
'zapierdalający', 'zapierdalajacy', 'zapierdolić', 'zapierdolic',
'zapierdoli', 'zapierdolił', 'zapierdolil', 'zapierdoliła',
'zapierdolila', 'zapierdolą', 'zapierdola', 'zapierniczać',
'zapierniczający', 'zasrać', 'zasranym', 'zasrywać', 'zasrywający',
'zesrywać', 'zesrywający', 'zjebać', 'zjebac', 'zjebał', 'zjebal',
'zjebała', 'zjebala', 'zjebana', 'zjebią', 'zjebali', 'zjeby']




@views.route('/')
def home():
    # if "user" in session:
    #     with psycopg2.connect(**db_params) as connection:
    #                 with connection.cursor() as cursor:
    #                     query = "SELECT COUNT(ksiazka_id) FROM koszyk WHERE klient_id = %s"
    #                     cursor.execute(query, (str(session["user"])))
    #                     koszyk = cursor.fetchall()
    #                     session["koszyk"] = koszyk[0][0];   
    return render_template('base.html')

@views.route('/ksiazki')
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

@views.route('/produkt',methods=['GET','POST'])
def item(item_info=None):
    item_info = request.args.get('item_info', None)
    if item_info != None:
        session["item"] = item_info
    book = session["item"]
    connection = psycopg2.connect(**db_params)
    cursor = connection.cursor()
    try:
        query = f"SELECT * FROM ksiazki WHERE ksiazka_id = {item_info}"
        cursor.execute(query,item_info)
        info = cursor.fetchall()

        query1 = f"select op.ocena, op.ocena_tekst, kl.imie, kl.nazwisko FROM opinie AS op JOIN klienci AS kl ON op.klient_id = kl.klient_id JOIN ksiazki AS ks ON ks.ksiazka_id = op.ksiazka_id WHERE ks.ksiazka_id = {item_info} ORDER BY op.data_dodania ASC"
        cursor.execute(query1,item_info)
        comments= cursor.fetchall()
        cursor.close()
        connection.close()

        return render_template('item.html',info=info,comments=comments,item_info=item_info)
    except Exception as e:
        print(e)
        return redirect(url_for('views.books'))
    
@views.route('/dodaj_komentarz',methods=['GET','POST'])
def dodaj_komentarz():
    book = session["item"]
    user = session["user"]
    data = request.form
    komentarz = data['komentarz']
    ocena = data['ocena']
    payload = {
            "text": komentarz,
            "swear_words": swear_words
        }
    response = lambda_client.invoke(
        FunctionName='Filtrowanie',
        InvocationType='RequestResponse',
        Payload=json.dumps(payload)
    )

        # Odczytanie odpowiedzi z Lambda
    response_payload = response['Payload'].read()
    print("wykonwanie funkcji lambda")
    print(response_payload)
    if response_payload == b'false':
        print("LAMBDA0")
        with psycopg2.connect(**db_params) as connection:
            with connection.cursor() as cursor:
                query = "INSERT INTO opinie (klient_id, ksiazka_id, ocena, ocena_tekst) VALUES (%s,%s,%s,%s)"
                cursor.execute(query, (user,book,ocena,komentarz))
        mes = flash("Komentarz dodany")
        return redirect(url_for('views.item', item_info = book))
    else:
        print("LAMBDA1")
        mes = flash("Komentarz nie może zostać dodany ponieważ zawiera nieodpowiednie słowa")
        return redirect(url_for('views.item', item_info = book))





@views.route('/dodaj_produkt',methods=['GET','POST'])
def dodaj_produkt():
    print("FUNKCJA DODAJ PROUKT")
    book = session["item"]
    print(book)
    if "user" in session:
        user_id = session["user"]
        data = request.form
        ilosc = data['ilosc']
        if book == None:
            print("JAK TO JEST NONE")
        else:
            print("SUKCES")
            with psycopg2.connect(**db_params) as connection:
                with connection.cursor() as cursor:
                    query = "INSERT INTO koszyk (ksiazka_id, klient_id, ilosc) VALUES (%s,%s,%s)"
                    cursor.execute(query, (book,user_id,ilosc))
                    print("wykonuje querry")
                    return redirect(url_for('views.books'))
    else:
        print("Routuje na user.login")
        return redirect(url_for('user.login'))

    
@views.route('/o_nas')
def about_us():
    text = "To jest przykładowy tekst z  i innymi słowami."
    cleaned_text = clean_vulgarities(text, swear_words, '')
    print(cleaned_text)
    return render_template('about_us.html')

def clean_vulgarities(text, swear_words, replacement="*"):
    words = text.split()
    cleaned_words = [replacement if word.lower() in swear_words else word for word in words]
    return ' '.join(cleaned_words)





@views.route('/test-lambda', methods=['GET'])
def test_lambda():
    try:
        # Dane wejściowe dla funkcji Lambda
        payload = {
            "text": "To jest przykładowy tekst z i innymi słowami.",
            "swear_words": swear_words
        }

        # Wywołanie funkcji Lambda
        response = lambda_client.invoke(
            FunctionName='Filtrowanie',
            InvocationType='RequestResponse',
            Payload=json.dumps(payload)
        )

        # Odczytanie odpowiedzi z Lambda
        response_payload = response['Payload'].read()

        # Zwrócenie odpowiedzi
        return response_payload

    except Exception as e:
        return jsonify({'error': str(e)})
    

@views.route('/bestsellery', methods=['GET'])
def bestsellery():
    page = request.args.get(get_page_parameter(), type=int, default=1)
    per_page = 16
    offset = (page - 1) * per_page
    
    connection = psycopg2.connect(**db_params)
    cursor = connection.cursor()
    query = """
    SELECT ks.ksiazka_id, ks.autor_id, ks.tytul, ks.opis, ks.kategoria, ks.rok_wydania, ks.zdjecie, count(zp.ksiazka_id) FROM ksiazki as ks
    INNER JOIN zamowienia_przedmioty as zp
    ON zp.ksiazka_id = ks.ksiazka_id
    GROUP BY ks.ksiazka_id, ks.autor_id, ks.tytul, ks.opis, ks.kategoria, ks.rok_wydania, ks.zdjecie
    ORDER BY count(zp.ksiazka_id)
    LIMIT %s OFFSET %s
    """
    cursor.execute(query, (per_page, offset))
    results = cursor.fetchall()
    cursor.execute("""SELECT COUNT(*) FROM (
        SELECT ks.ksiazka_id
        FROM ksiazki AS ks
        INNER JOIN zamowienia_przedmioty AS zp ON zp.ksiazka_id = ks.ksiazka_id
        GROUP BY ks.ksiazka_id) AS subquery""")
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
    return render_template('bestsellers.html', results=results, pagination=pagination)


@views.route('/wyszukiwanie',methods=['POST','GET'])
def wyszukiwanie():
    with psycopg2.connect(**db_params) as connection:
        with connection.cursor() as cursor:
            query = "SELECT * FROM ksiazki"
            cursor.execute(query)
            results = cursor.fetchall()
    data = request.form
    szukaj = data['szukaj']
    payload = {
            "szukaj": szukaj,
            "lista": results
        }
    
    response = lambda_client.invoke(
            FunctionName='Wyszukiwanie',
            InvocationType='RequestResponse',
            Payload=json.dumps(payload)
        )

        # Odczytanie odpowiedzi z Lambda
    response_payload = response['Payload'].read()



    #results = [row for row in results if szukaj.lower() in row[2].lower()]
            
        

    return redirect(url_for('views.wyniki',results=response_payload))

@views.route('/wyniki',methods=['POST','GET'])
def wyniki():
    results = request.args.get('results', None)
    print(type(results))
    total_records = len(results)
    print(results)
    #print(part_of_results)
    result_table = ast.literal_eval(results)
    print(type(result_table))
    print(result_table)
    return render_template('search.html', results=result_table)


@views.route('/najwyzej_oceniane', methods=['GET'])
def naj_oceniane():
    page = request.args.get(get_page_parameter(), type=int, default=1)
    per_page = 16
    offset = (page - 1) * per_page
    
    connection = psycopg2.connect(**db_params)
    cursor = connection.cursor()
    query = """
    SELECT ks.ksiazka_id, ks.autor_id, ks.tytul, ks.opis, ks.kategoria, ks.rok_wydania, ks.zdjecie, avg(ocena) AS srednia FROM ksiazki as ks
    INNER JOIN opinie as op
    ON op.ksiazka_id = ks.ksiazka_id
    GROUP BY ks.ksiazka_id, ks.autor_id, ks.tytul, ks.opis, ks.kategoria, ks.rok_wydania, ks.zdjecie
    ORDER BY srednia DESC
    LIMIT %s OFFSET %s
    """
    cursor.execute(query, (per_page, offset))
    results = cursor.fetchall()
    total_records = len(results)
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
    return render_template('rates.html', results=results, pagination=pagination)