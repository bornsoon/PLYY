from flask import Blueprint, jsonify, render_template, session, request
from models import plyylike_status, tag_list, plyy_query, plyy_detail_query, curator_query, extract_user, song_detail_query

main = Blueprint('main', __name__)
plyy = Blueprint('plyy', __name__)
search = Blueprint('search', __name__)
likes = Blueprint('like', __name__)
api_main = Blueprint('api_main', __name__)
api_plyy = Blueprint('api_plyy', __name__)
api_c_plyy = Blueprint('api_c_plyy', __name__)
api_search = Blueprint('api_search', __name__)
api_like = Blueprint('api_like', __name__)

@main.route('/')
def index():
    return render_template('main.html')


@likes.route('/<id>')
def like(id):
    return render_template('like.html')


@plyy.route('/<id>')
def plyy_detail(id):
    return render_template('plyy.html')


@plyy.route('/<id>/<song_index>')
def song_detail(id, song_index):
    return render_template('song.html')

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


@api_like.route('/plyy/<id>')
def like_plyy(id):
    result = plyy_query('uid', id)
    return jsonify(result)
    

@api_like.route('/curator/<id>')
def like_curator(id):
    result = curator_query('uid', id)
    return jsonify(result)


@api_main.route('/curator')
def api_main_curator():
    result = curator_query()
    return jsonify(result)


@api_plyy.route('/<id>')
def api_plyy_detail(id):
    plyy, tracks, tags = plyy_detail_query(id)

    pidlist = [id]
    if 'id' in session and session['id']:
        u_id = extract_user(session['id'])
        if u_id:
            p_isliked = plyylike_status(pidlist, u_id) #키는 현재 유저
            plyy.update({'p_isliked':p_isliked})


    return jsonify({'plyy': plyy, 'tracks': tracks, 'tags': tags})


@api_plyy.route('/<id>/<song_num>')
def api_song(id, song_num):
    result = song_detail_query(id, song_num) 
    return jsonify(result)