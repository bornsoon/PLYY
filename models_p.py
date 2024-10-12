import db_p as db
from flask import session


def like_status(category, id, u_id):
    try:
        if category == 'plyy':
            likes = db.get_query('SELECT 1 FROM P_LIKE WHERE p_id = %s and u_id = %s', (id, u_id), mul=False)
        elif category == 'curator':
            likes = db.get_query('SELECT 1 FROM C_LIKE WHERE c_id = %s and u_id = %s', (id, u_id), mul=False)
    
        return likes
    
    except Exception as e:
        print(f"Error inserting like: {e}")
        return None


def user_like(category, u_id, id):
    try:
        if category == 'plyy':
            result = db.get_query('SELECT 1 FROM P_LIKE WHERE u_id = %s AND p_id = %s', (u_id, id), mul=False)
            if not result:
                db.execute_query('INSERT INTO P_LIKE (u_id, p_id) VALUES (%s, %s)', (u_id, id))   
        elif category == 'curator':
            result = db.get_query('SELECT 1 FROM C_LIKE WHERE u_id = %s AND c_id = %s', (u_id, id), mul=False)
            if not result:
                db.execute_query('INSERT INTO C_LIKE (u_id, c_id) VALUES (%s, %s)', (u_id, id))   
        return True
        
    except Exception as e:
        print(f"Error inserting like: {e}")
        db.roll()
        return False


def user_unlike(category, u_id, id):
    try:
        if category == 'plyy':
            result = db.get_query('SELECT 1 FROM P_LIKE WHERE u_id = %s AND p_id = %s', (u_id, id), mul=False)
            if result:
                db.execute_query('DELETE FROM P_LIKE WHERE u_id = %s AND p_id = %s', (u_id, id))
        elif category == 'curator':
            result = db.get_query('SELECT 1 FROM C_LIKE WHERE u_id = %s AND c_id = %s', (u_id, id), mul=False)
            if result:
                db.execute_query('DELETE FROM C_LIKE WHERE u_id = %s AND c_id = %s', (u_id, id))
        return True
    
    except Exception as e:
        print(f"Error deleting like: {e}")
        db.roll()
        return False
    

def extract_user(id):
    u_id = db.get_query('SELECT id FROM PUBLIC.USER WHERE id = %s', (id,), mul=False)
    return u_id['id'] if u_id else None


def extract_user2(email, password):
    user = db.get_query('SELECT id FROM PUBLIC.USER WHERE email = %s and pw = %s', (email, password), mul=False)
    return user if user else None


def extract_user3(id, password):
    user = db.get_query('SELECT id, email, pw, nickname, img FROM PUBLIC.USER WHERE email = %s and pw = %s', (id, password), mul=False)
    return user if user else None


def user_sign(email):
    try:
        return bool(db.get_query('SELECT 1 FROM PUBLIC.USER WHERE email = %s', (email,), mul=False))
    except Exception as e:
        print(f"Error occurred: {e}")
        return False


def user_sign_aka(nickname):
    try:
        return bool(db.get_query('SELECT 1 FROM PUBLIC.USER WHERE nickname = %s', (nickname,), mul=False))
    except Exception as e:
        print(f"Error occurred: {e}")
        return False


def user_signup(email,pw,nickname):
    try:
        # 새로운 사용자 추가
        db.execute_query("INSERT INTO PUBLIC.USER (email,pw,nickname) VALUES(%s, %s, %s)", (email,pw,nickname))
        return True
    except Exception as e:
        print(f"회원가입 처리 중 오류 발생: {e}")
        db.roll()
        return False


def current_pw(id, pw):
    # 비밀번호 조회
    user = db.get_query('SELECT id, pw FROM PUBLIC.USER WHERE id = %s', (id,), mul=False)
    if user and user['pw'] == pw:
        return id
    return None


def change_pw(id,pw):
    query = 'UPDATE PUBLIC.USER SET pw = %s WHERE id = %s'
    params = (pw, id)
    try:
        db.execute_query(query, params)
        return True
    except Exception as e:
        print(f"Error updating password: {e}")
        return False
    
    
def change_img(id,filename):
    query = 'UPDATE PUBLIC.USER SET img = %s WHERE id = %s'
    params = (filename, id)
    try:
        db.update_query(query, params)
        return True
    except Exception as e:
        print(f"Error updating password: {e}")
        return False
    
    
def change_nickname(id,nickname):
    query = 'UPDATE PUBLIC.USER SET nickname = %s WHERE id = %s'
    params = (nickname, id)
    try:
        db.execute_query(query, params)
        return True
    except Exception as e:
        print(f"Error updating password: {e}")
        return False


def tag_list():
    try:
        query = '''
        SELECT
        name AS tag
        FROM TAG
        UNION
        SELECT
        name AS tag
        FROM GENRE
        '''
        tags = db.get_query(query)

        if tags:
            return tags
        else:
            return None
    
    except Exception as e:
        print(f"QueryError of a list of tags: {e}")
        return None


def tag_query(category, id, mul=True):
    try:
        if category.lower() == 'plyy':
            query = '''
                    SELECT
                    t.name 
                    FROM TAG t 
                    JOIN P_TAG pt ON t.id = pt.t_id
                    WHERE pt.p_id = %s
                    '''

        elif category.lower() == 'curator':
            query = '''
                    SELECT
                    t.name
                    FROM TAG t
                    JOIN C_TAG ct ON t.id = ct.t_id
                    WHERE ct.c_id = %s
                    '''
        tags = db.get_query(query, (id,), mul)
        
        return tags
    
    except Exception as e:
        print(f"QueryError of tags: {e}")
        return None


def plyy_info(id):
    try:
        plyy_query = '''
                    SELECT
                    p.title,
                    TO_CHAR(p.gen_date, 'yyyy-mm-dd') AS generate,
                    TO_CHAR(p.up_date, 'yyyy-mm-dd') AS update,
                    c.name AS curator, 
                    g.name AS genre,
                    p.cmt AS comment  
                    FROM PLYY p 
                    JOIN CURATOR c ON p.c_id = c.id
                    JOIN GENRE g ON p.g_id = g.id 
                    WHERE p.id = %s GROUP BY p.id, c.id, g.id;
                    '''   # postgresql
        plyy = db.get_query(plyy_query, (id,), mul=False)

        heart_query = '''
                    SELECT
                    COUNT(1) AS heart
                    FROM p_LIKE
                    WHERE p_id = %s;
                    '''
        heart = db.get_query(heart_query, (id,), mul=False)
        plyy['heart'] = heart['heart']

        tracks_query = '''
                    SELECT t.*,
                    s.num
                    FROM TRACK t 
                    JOIN SONG s ON t.id = s.tk_id
                    JOIN PLYY p ON s.p_id = p.id 
                    WHERE p.id = %s
                    ORDER BY s.num;
                    '''
        tracks = db.get_query(tracks_query,(id,))
        tags = tag_query('plyy', id)
        
        if 'id' in session and session['id']:
            u_id = extract_user(session['id'])
            plyy['pliked'] = bool(like_status('plyy', id, u_id)) #키는 현재 유저
        
        return plyy, tracks, tags

    except Exception as e:
        print(f"QueryError of details of playlist: {e}")


def plyy_query(condition=None, param=None):
    try:
        query1 = '''
                SELECT
                p.id,
                p.title,
                p.img,
                TO_CHAR(p.gen_date, 'yyyy-mm-dd') AS generate,
                TO_CHAR(p.up_date, 'yyyy-mm-dd') AS update,
                c.name AS curator,
                g.name AS genre,
                COUNT(s.num) AS tracks,
                SUM(t.rtime) AS times
                FROM PLYY p
                JOIN CURATOR c ON p.c_id = c.id
                JOIN GENRE g ON p.g_id = g.id
                JOIN SONG s ON p.id = s.p_id
                JOIN TRACK t ON s.tk_id = t.id
                '''
        query2 = ' GROUP BY p.id, c.id, g.id;'  # postgresql
        
        if condition:
            if condition.lower() == 'cid':
                add_query = 'WHERE c.id = %s'
                query = query1 + add_query + query2
                result = db.get_query(query, (param,))    
            elif condition.lower() == 'title':
                add_query = "WHERE p.title LIKE '%'||%s||'%'"
                query = query1 + add_query + query2
                result = db.get_query(query, (param,))    
            elif condition.lower() == 'uid':
                add_query = "JOIN P_LIKE pl ON pl.p_id = p.id WHERE pl.u_id = %s"
                query = query1 + add_query + query2
                result = db.get_query(query, (param,))    
            elif condition.lower() == 'tag':
                add_query = '''
                            JOIN P_TAG pt ON p.id = pt.p_id
                            JOIN TAG tg ON pt.t_id = tg.id
                            WHERE tg.name LIKE '%'||%s||'%'
                            OR genre LIKE '%'||%s||'%'
                            '''
                query = query1 + add_query + query2
                result = db.get_query(query, (param, param))      

        if not condition:
            query = query1 + query2
            result = db.get_query(query)

        for i in result:
            tag = tag_query('plyy', i['id'], mul=False)
            if tag:
                i['tag'] = tag['name']
            elif tag is None:
                i['tag'] = ''

        if 'id' in session and session['id']:
            u_id = extract_user(session['id'])
            if u_id:
                for i in result:
                    i['pliked'] = bool(like_status('plyy', i['id'], u_id))

        return result
    
    except Exception as e:
        print(f"QueryError of a playlist: {e}")


def song_detail_query(id, song_num):
    try:
        song_query = '''
                    SELECT 
                    t.title,
                    t.artist,
                    t.img,
                    t.album,
                    s.cmt AS comment,
                    s.vid
                    FROM TRACK t 
                    JOIN SONG s ON t.id = s.tk_id 
                    WHERE s.p_id = %s AND s.num = %s
                    '''
        result = db.get_query(song_query, (id,song_num), mul=False)

        total_query = '''
                    SELECT
                    COUNT(id) AS total
                    FROM SONG
                    WHERE p_id = %s
                    '''
        total_index = db.get_query(total_query, (id,), mul=False)
        result['total_num'] = total_index['total']
        return result
    
    except Exception as e:
        print(f"QueryError of a song: {e}")
        

def curator_query(condition=None, param=None):
    try:
        query = 'SELECT c.* FROM CURATOR c'
        result = db.get_query(query)

        if condition:
            if condition.lower() == 'name':
                query = query + " WHERE c.name LIKE '%'||%s||'%';"         
            elif condition.lower() == 'uid':
                query = query + " JOIN C_LIKE cl ON c.id = cl.c_id WHERE cl.u_id = %s;"
            elif condition.lower() == 'tag':
                query = query + '''
                                JOIN C_TAG ct ON c.id = ct.c_id 
                                JOIN TAG tg ON ct.t_id = tg.id
                                WHERE tg.name LIKE '%'||%s||'%';
                                '''
            result = db.get_query(query,(param,))
        
        for i in result:
            tags = tag_query('curator', i['id'])
            tag = []
            for j in tags[:2]:
                tag.append(j['name'])
            i['tag'] = tag

        date_query = '''
                    SELECT
                    MAX(TO_CHAR(p.gen_date, 'yyyy-mm-dd')) AS generate,
                    MAX(TO_CHAR(p.up_date, 'yyyy-mm-dd')) AS update
                    FROM PLYY p
                    JOIN CURATOR c ON p.c_id = c.id
                    GROUP BY c.id
                    HAVING c.id = %s;
                    ''' # postgresql
        for i in result:
            date = db.get_query(date_query, (i['id'],), mul=False)
            i.update(date)
    

        if 'id' in session and session['id']:
            u_id = extract_user(session['id'])
            if u_id:
                for i in result:
                    i['cliked'] = bool(like_status('curator', i['id'], u_id))
        return result
    
    except Exception as e:
        print(f"QueryError of a list of curators: {e}")


def curator_info(id):
    try:
        curator_query = '''
                        SELECT
                        c.*,
                        COUNT(p.id) AS 'plyys'
                        FROM CURATOR c
                        JOIN PLYY p
                        ON c.id = p.c_id
                        WHERE c.id = &s
                        GROUP BY c.id
                        '''
        curator = db.get_query(curator_query, (id,), mul=False)
        likes = db.get_query('SELECT COUNT(1) count FROM C_LIKE WHERE c_id = &s',(id,), mul=False)

        curator['likes'] = likes['count']

        if 'id' in session and session['id']:
            u_id = extract_user(session['id'])
            if u_id:
                curator['cliked'] = bool(like_status('curator', id, u_id))

        return curator
    
    except Exception as e:
        print(f"QueryError of detail of curator: {e}")