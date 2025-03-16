from flask import Flask
from datetime import timedelta

app = Flask(__name__)
app.secret_key = 'plyy_page'
app.permanent_session_lifetime = timedelta(minutes=30)

from views import api_mypage, api_signup, like_toggle
from route import main, plyy, curator, search, api_main, api_plyy, api_curator, api_c_plyy, api_search, api_like

app.register_blueprint(main, url_prefix='/')
app.register_blueprint(plyy, url_prefix='/plyy')
app.register_blueprint(curator, url_prefix='/curator')
app.register_blueprint(search, url_prefix='/search')
app.register_blueprint(api_search, url_prefix='/api/search')
app.register_blueprint(api_like, url_prefix='/api/like')
app.register_blueprint(api_main, url_prefix='/api/main')
app.register_blueprint(api_plyy, url_prefix='/api/plyy')
app.register_blueprint(api_curator, url_prefix='/api/curator/')
app.register_blueprint(api_c_plyy, url_prefix='/api/c_plyy')
app.register_blueprint(api_signup, url_prefix='/api')
app.register_blueprint(api_mypage, url_prefix='/api')
app.register_blueprint(like_toggle, url_prefix='/api/like_toggle')


if __name__ == "__main__":
    app.run()