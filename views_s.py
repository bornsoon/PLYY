# views.py
from flask import Blueprint, request, session, render_template, redirect, url_for, jsonify
from models_s import db, curator_like, curator_unlike, plyy_like,plyy_unlike,\
                     extract_user, user_sign, user_signup, user_sign_aka,\
                     current_pw, change_pw, change_nickname, change_img
from route import main
import os
# from app import app``

### 블루프린트 정리하기

mypage = Blueprint('mypage', __name__)
api_mypage = Blueprint('api_mypage',__name__)
api_signup = Blueprint('api_signup',__name__)
like_toggle = Blueprint('like_toggle', __name__)

########################################## app.config 역할???? 블루프린트??
# app.config['UPLOAD_FOLDER'] = 'static/cardimage'
# mypage_edit_img.config['UPLOAD_FOLDER'] = 'static/cardimage'

@main.route('/login', methods=['GET', 'POST'])
def login_view():
    if request.method == 'POST':
        Id = request.form['userid']
        Pw = request.form['userpw']
        user = db.get_query('SELECT id, email, pw, nickname, img FROM USER WHERE email = ? and pw = ?', (Id, Pw), mul=False)
        if user:
            session['id'] = user['id']
            session['nickname'] = user['nickname']
            if user['img']:
                session['img'] = user['img']
            else:
                session['img'] ='U.jpg'
            return redirect(url_for('main.index'))
        else:
            session['id'] = None
            return render_template('login.html', login_failed=True)
        
    return render_template('login.html', login_failed=False)

@main.route('/logout', methods=['POST'])
def logout_view():
    session.pop('id', None)
    session.pop('nickname',None)
    session.pop('img',None)
    return redirect(url_for('main.index'))

@main.route('/mypage')
def mypage_view():
    if not session:
        return redirect(url_for('main.login_view'))
    return render_template('mypage.html')

@main.route('/edit')
def edit_view():
    if not session:
        return redirect(url_for('main.login_view'))
    return render_template('test_mypage_edit.html')

@main.route('/api_img', methods=['POST'])
def upload_file():
    file = request.files['file']
    if file:
        user_id = session.get('id')
        filepath = os.path.join('static/cardimage/', f'U{user_id}.jpg')  ######## app.config
        file.save(filepath)
        change_img(id, file.filename)
        return redirect(url_for('main.edit_view'))
    else:
        return jsonify({'success': False})

@api_mypage.route('/pw', methods=['POST'])
def mypage_pw():
    data = request.get_json()
    pw = data.get('password')
    
    if not pw:
        return jsonify({'valid': False, 'message': '비밀번호를 입력해 주세요.'}), 400

    user_id = current_pw(session.get('id'), pw)
    
    if user_id:
        return jsonify({'valid': True})
    else:
        return jsonify({'valid': False, 'message': '비밀번호가 올바르지 않습니다.'}), 401

@api_mypage.route('/change-password', methods=['POST'])
def change_password():
    data = request.get_json()
    new_password = data.get('newPassword')

    if not new_password:
        return jsonify({'success': False, 'message': 'New password is required.'}), 400

    # 현재 사용자의 ID가 세션에 저장되어 있는지 확인
    user_id = session.get('id')
    if not user_id:
        return jsonify({'success': False, 'message': 'User not authenticated.'}), 403

    # 비밀번호 변경
    success = change_pw(user_id, new_password)

    if success:
        return jsonify({'success': True, 'message': 'Password updated successfully.'})
    else:
        return jsonify({'success': False, 'message': 'Failed to update password.'}), 500

@api_mypage.route('/change-nickname', methods=['POST'])
def edit_nickname():
    data = request.get_json()
    new_nickname = data.get('newNickname')

    if not new_nickname:
        return jsonify({'success': False, 'message': 'New Nickname is required.'}), 400

    # 현재 사용자의 ID가 세션에 저장되어 있는지 확인
    user_id = session.get('id')
    if not user_id:
        return jsonify({'success': False, 'message': 'User not authenticated.'}), 403

    # 비밀번호 변경
    success = change_nickname(user_id, new_nickname)

    if success:
        session['nickname'] = new_nickname
        return jsonify({'success': True, 'message': 'Nickname updated successfully.'})
    else:
        return jsonify({'success': False, 'message': 'Failed to update Nickname.'}), 5
    
@main.route('/signup')
def signup_view():
    return render_template('signup.html')

@api_signup.route('/<email>',methods=['post'])
def signup_email_view(email):
    try:
        status = user_sign(email)
        return jsonify({'exists': status}), 200
    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({'exists': False}), 500

@api_signup.route('/nickname/<nickname>',methods=['post'])
def signup_nickname_view(nickname):
    try:
        status = user_sign_aka(nickname)
        return jsonify({'exists': status}), 200
    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({'exists': False}), 500

@api_signup.route('/signup',methods=['post'])
def signup_final_view():
    try:
        # 클라이언트로부터 이메일과 비밀번호를 JSON 형식으로 받음
        data = request.get_json()
        email = data.get('email')
        password = data.get('password')
        nickname = data.get('nickname')
        # user_signup 함수 호출하여 데이터베이스에 사용자 추가
        result = user_signup(email, password, nickname)
        if result:
            user = db.get_query('SELECT id FROM USER WHERE email = ? and pw = ?', (email,password),mul=False)
            session['id'] = user['id']
            session['nickname'] = user['nickname']
            return jsonify({'success': True, 'message': '회원가입이 완료되었습니다!'}), 200
        else:
            return jsonify({'success': False, 'message': '회원가입에 실패했습니다.'}), 500
    
    except Exception as e:
        print(f"오류 발생: {e}")
        return jsonify({'success': False, 'message': '서버 오류가 발생했습니다.'}), 500


@like_toggle.route('/<category>/<u_id>/<c_id>', methods=['POST'])
def like_view(category, u_id, c_id):
    u_id = extract_user(u_id)
    if category == 'cl':
        success = curator_like(c_id, u_id)
        print(1111111111)
    elif category == 'pl':
        success = plyy_like(c_id, u_id)
        print(22222222222)

    if success:
        return jsonify({'success': True}), 200
    else:
        return jsonify({'success': False}), 500
    

@like_toggle.route('/<category>/<u_id>/<c_id>', methods=['DELETE'])
def unlike_view(category, u_id, c_id):
    u_id = extract_user(u_id)
    if category == 'cul':
        success = curator_unlike(c_id, u_id)
        print(3333333333333)
    elif category == 'pul':
        success = plyy_unlike(c_id, u_id)
        print(4444444444)
    
    success = curator_unlike(c_id, u_id)
    if success:
        return jsonify({'success': True}), 200
    else:
        return jsonify({'success': False}), 500