from website import create_app

app = create_app()
app.secret_key = "SECRET_KEY"
if __name__ == '__main__':
    app.run(debug=True)