from flask import Flask
def create_app():
    app  = Flask(__name__)
    app.config['SECRET_KEY'] = 'secretkey'

    from .views import views
    from .user import user

    app.register_blueprint(views, url_prefix='/')
    app.register_blueprint(user, url_prefix='/konto')

    return app
