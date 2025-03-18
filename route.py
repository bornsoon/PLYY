from flask import Blueprint, jsonify, render_template, session, request
from models_p import tag_list, plyy_query, plyy_info, curator_info, curator_query, song_detail_query

main = Blueprint('main', __name__)
plyy = Blueprint('plyy', __name__)
curator = Blueprint('curator', __name__)
search = Blueprint('search', __name__)
api_main = Blueprint('api_main', __name__)
api_plyy = Blueprint('api_plyy', __name__)
api_c_plyy = Blueprint('api_c_plyy', __name__)
api_curator = Blueprint('api_curator', __name__)
api_search = Blueprint('api_search', __name__)
api_like = Blueprint('api_like', __name__)

@main.route('/')
def index():
    return render_template('main.html')

@main.route('/like')
def like():
    return render_template('like.html')

@main.route('/notification')
def notification():
    return render_template('notification.html')

@plyy.route('/<id>')
def plyy_detail(id):
    return render_template('plyy.html')

@plyy.route('/<id>/<song_index>')
def song_detail(id, song_index):
    return render_template('song.html')

@curator.route('/<id>')
def curator_detail(id):
    return render_template('curator.html')

@search.route('/plyy')
def search_plyy():
    return render_template('search_plyy.html')

@search.route('/curator')
def search_curator():
    return render_template('search_curator.html')

@api_main.route('/tag')
def api_main_tag():
    result = tag_list()
    return jsonify(result)


@api_main.route('/plyy')
def api_main_plyy():
    result = plyy_query()
    return jsonify(result)


@api_main.route('/curator')
def api_main_curator():
    result = curator_query()
    return jsonify(result)


@api_c_plyy.route('/<id>')
def api_curator_plyy(id):
    result = plyy_query('cid', id)
    return jsonify(result)


@api_search.route('/plyy')
def search_plyy():
    param = request.args.get('q')
    if param and param[0]=='#':
        result = plyy_query('tag', param[1:].strip())
    else:
        result = plyy_query('title', param.strip())
    return jsonify(result)


@api_search.route('/curator')
def search_curator():
    param = request.args.get('q')
    if param and param[0]=='#':
        result = curator_query('tag', param[1:].strip())
    else:    
        result = curator_query('name', param.strip())
    return jsonify(result)


@api_like.route('/plyy')
def like_plyy():
    id = session['id']
    result = plyy_query('uid', id)
    return jsonify(result)
    

@api_like.route('/curator')
def like_curator():
    id = session['id']
    result = curator_query('uid', id)
    return jsonify(result)


@api_plyy.route('/<id>')
def api_plyy_info(id):
    plyy, tracks, tags = plyy_info(id)
    return jsonify({'plyy': plyy, 'tracks': tracks, 'tags': tags})


@api_plyy.route('/<id>/<song_num>')
def api_song(id, song_num):
    result = song_detail_query(id, song_num) 
    return jsonify(result)


@api_curator.route('/<id>', methods=['GET'])
def api_curator_info(id):
    curator = curator_info(id)
    return jsonify(curator)