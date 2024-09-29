import db_postgre as db
# import db_sqlite as db
from flask import session


def curator_info(id):
    curator_info = []
    curator_tags = []

    curator = db.get_query('SELECT * FROM CURATOR WHERE id = ?', (id,), mul=False)
    curator_info.extend([curator[i] for i in range(len(curator))])
    
    ctags = db.get_query('''
                        SELECT TAG.name
                        FROM CURATOR
                        JOIN C_TAG ON CURATOR.id = C_TAG.c_id
                        JOIN TAG ON C_TAG.t_id = TAG.id
                        WHERE CURATOR.id = ?
                        ''', (id,))
    
    curator_tags.extend([f"#{ctags[i]['name']}" for i in range(len(ctags))])
    curator_info.append(curator_tags)

    cPlyyCount = db.get_query('SELECT COUNT(*) FROM PLYY WHERE c_id = ?',(id,), mul=False)[0]
    curator_info.append(cPlyyCount)

    cLikesCount = db.get_query('SELECT COUNT(*) FROM C_LIKE WHERE c_id = ?',(id,), mul=False)[0]
    curator_info.append(cLikesCount)
    
    return curator_info


def cu_plyy_tag(id, pid):
    plyy_tags = []
    
    cu_pgtag = db.get_query('''
                SELECT GENRE.name
                FROM GENRE
                JOIN PLYY ON PLYY.g_id = GENRE.id
                WHERE PLYY.c_id = ? and PLYY.id = ?
                ''', (id, pid))
    
    for pgtag in cu_pgtag:
        plyy_tags.append(pgtag['name'])
    
    cu_ptag = db.get_query('''    
            SELECT tag.name
            FROM PLYY
            JOIN P_TAG ON PLYY.id = P_TAG.p_id
            JOIN TAG ON P_TAG.t_id = TAG.id
            WHERE PLYY.c_id = ? and PLYY.id = ?''', (id, pid))

    for t in cu_ptag:
        plyy_tags.append(t['name'])

    return plyy_tags


def cu_plyy(id):
    plyy_list = []

    plyy = db.get_query('SELECT * FROM PLYY WHERE c_id = ?', (id,))

    for p in plyy:  # 플리 객체
        each_plyy = [p[i] for i in range(len(p))]
        each_plyy.append(cu_plyy_tag(id, each_plyy[0]))
        plyy_list.append(each_plyy)

    return plyy_list


def curatorlike_status(cidlist, u_id):
    
    clikestatus = []

    for cid in cidlist:
        likes = db.get_query('SELECT * FROM C_LIKE WHERE c_id = ? and u_id = ?', (cid, u_id),mul=False)
        clikestatus.append(bool(likes))

    return dict(zip(cidlist, clikestatus))


def curator_like(c_id, u_id):
    try:
        row = db.get_query('SELECT * FROM C_LIKE WHERE u_id = ? AND c_id = ?', (u_id,c_id),mul=False)
        if not row:
            db.execute_query('INSERT INTO C_LIKE (u_id, c_id) VALUES (?, ?)', (u_id, c_id))
        return True
    except Exception as e:
        print(f"Error inserting like: {e}")
        db.roll()
        return False


def curator_unlike(c_id, u_id):
    try:
        row = db.get_query('SELECT * FROM C_LIKE WHERE u_id = ? AND c_id = ?', (u_id, c_id),mul=False)
        
        if row:
            db.execute_query('DELETE FROM C_LIKE WHERE u_id = ? AND c_id = ?', (u_id, c_id))
        return True
    
    except Exception as e:
        print(f"Error deleting like: {e}")
        db.roll()
        return False


def plyylike_status(pidlist, u_id):
    plikestatus = []
    for pid in pidlist:
        likes = db.get_query('SELECT * FROM P_LIKE WHERE p_id = ? and u_id = ?', (pid, u_id),mul=False)
        plikestatus.append(bool(likes))

    return dict(zip(pidlist, plikestatus))


def plyy_like(p_id, u_id):
    try:
        row = db.get_query('SELECT * FROM P_LIKE WHERE u_id = ? AND p_id = ?', (u_id, p_id),mul=False)
        if not row:
            db.execute_query('INSERT INTO P_LIKE (u_id, p_id) VALUES (?, ?)', (u_id, p_id))

        return True
    
    except Exception as e:
        print(f"Error inserting like: {e}")
        db.roll()
        return False


def plyy_unlike(p_id, u_id):
    try:
        row = db.get_query('SELECT * FROM P_LIKE WHERE u_id = ? AND p_id = ?', (u_id, p_id),mul=False)
        if row:
            db.execute_query('DELETE FROM P_LIKE WHERE u_id = ? AND p_id = ?', (u_id, p_id))
        return True
    
    except Exception as e:
        print(f"Error deleting like: {e}")
        db.roll()
        return False
    

def extract_user(id):
    u_id = db.get_query('SELECT id FROM USER WHERE id = ?', (id,),mul=False)

    return u_id['id'] if u_id else None

def user_sign(email):
    try:
        return bool(db.get_query('SELECT 1 FROM USER WHERE email = ?', (email,), mul=False))
    except Exception as e:
        print(f"Error occurred: {e}")
        return False
    
def user_sign_aka(nickname):
    try:
        return bool(db.get_query('SELECT 1 FROM USER WHERE nickname = ?', (nickname,), mul=False))
    except Exception as e:
        print(f"Error occurred: {e}")
        return False
    
def user_signup(email,pw,nickname):
    try:
        # 새로운 사용자 추가
        db.execute_query("INSERT INTO USER (email,pw,nickname) VALUES(?,?,?)", (email,pw,nickname))
        return True
    except Exception as e:
        print(f"회원가입 처리 중 오류 발생: {e}")
        db.roll()
        return False
    

def current_pw(id, pw):
    # 비밀번호 조회
    user = db.get_query('SELECT id, pw FROM USER WHERE id = ?', (id,), mul=False)
    if user and user['pw'] == pw:
        return id
    return None

def change_pw(id,pw):
    query = 'UPDATE USER SET pw = ? WHERE id = ?'
    params = (pw, id)
    try:
        db.execute_query(query, params)
        return True
    except Exception as e:
        print(f"Error updating password: {e}")
        return False
    
def change_nickname(id,nickname):
    query = 'UPDATE USER SET nickname = ? WHERE id = ?'
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

        return tags
    
    except:
        print('태그 목록을 불러오는데 실패했습니다.')


def tag_query(category, id, mul=True):
    try:
        if category.lower() == 'plyy':
            query = '''
                    SELECT
                    t.name 
                    FROM TAG t 
                    JOIN P_TAG pt ON t.id=pt.t_id
                    WHERE pt.p_id=?
                    '''

        elif category.lower() == 'curator':
            query = '''
                    SELECT
                    t.name
                    FROM TAG t
                    JOIN C_TAG ct ON t.id=ct.t_id
                    WHERE ct.c_id=?
                    '''
            
        tags = db.get_query(query, (id,), mul)
        
        return tags
    
    except:
        print('태그 목록을 불러오는데 실패했습니다.')


def plyy_detail_query(id):
    try:
        plyy_query = '''
                    SELECT
                    p.title,
                    STRFTIME('%Y-%m-%d', p.gen_date) AS 'generate',
                    STRFTIME('%Y-%m-%d', p.up_date) AS 'update',
                    c.name AS curator, 
                    g.name AS genre,
                    p.cmt AS comment  
                    FROM PLYY p 
                    JOIN CURATOR c ON p.c_id=c.id
                    JOIN GENRE g ON p.g_id=g.id 
                    WHERE p.id=? GROUP BY p.id;
                    '''
        plyy = dict(db.get_query(plyy_query, (id,), mul=False))

        heart_query = '''
                    SELECT
                    COUNT(*) AS heart
                    FROM p_LIKE
                    WHERE p_id=?;
                    '''
        heart = dict(db.get_query(heart_query, (id,), mul=False))
        plyy['heart'] = heart['heart']

        tracks_query = '''
                    SELECT t.id,
                    t.title,
                    t.img,
                    t.album,
                    t.artist,
                    s.num,
                    t.rtime
                    FROM TRACK t 
                    JOIN SONG s ON t.id=s.tk_id
                    JOIN PLYY p ON s.p_id=p.id 
                    WHERE p.id=?
                    ORDER BY s.num;
                    '''
        tracks = db.get_query(tracks_query,(id,))
        #tracks = [dict(row) for row in tracks]

        tags = tag_query('plyy', id)
        #tags = [dict(row) for row in tags]

        return plyy, tracks, tags

    except:
        print('해당 플레이리스트의 상세정보를 불러오는데 실패했습니다.')

def plyy_query(condition=None, param=None):
    try:
        query1 = '''
                SELECT
                p.id,
                p.title,
                p.img,
                STRFTIME('%Y-%m-%d', p.gen_date) AS 'generate',
                STRFTIME('%Y-%m-%d', p.up_date) AS 'update',
                c.name AS curator,
                g.name AS genre,
                COUNT(s.num) AS tracks,
                SUM(t.rtime) AS times
                FROM PLYY p
                JOIN CURATOR c ON p.c_id=c.id
                JOIN GENRE g ON p.g_id=g.id
                JOIN SONG s ON p.id=s.p_id
                JOIN TRACK t ON s.tk_id=t.id
                '''
        query2 = ' GROUP BY p.id;'
        
        if condition:
            if condition.lower() == 'cid':
                add_query = 'WHERE c.id=?'
                query = query1 + add_query + query2
                result = db.get_query(query, (param,))    
            elif condition.lower() == 'title':
                add_query = "WHERE p.title LIKE '%'||?||'%'"
                query = query1 + add_query + query2
                restul = db.get_query(query, (param,))    
            elif condition.lower() == 'uid':
                add_query = "JOIN P_LIKE pl ON pl.p_id=p.id WHERE pl.u_id=?"
                query = query1 + add_query + query2
                result = db.get_query(query, (param,))    
            elif condition.lower() == 'tag':
                add_query = '''
                            JOIN P_TAG pt ON p.id=pt.p_id
                            JOIN TAG tg ON pt.t_id=tg.id
                            WHERE tg.name LIKE '%'||?||'%'
                            OR genre LIKE '%'||?||'%'
                            '''
                query = query1 + add_query + query2
                result = db.get_query(query, (param, param, ))      

        if not condition:
            query = query1 + query2
            result = db.get_query(query)

        for i in result:
            tag = tag_query('plyy', i['id'], mul=False)
            if tag:
                print('tagtag')
                print(tag)
                i['tag'] = tag['name']
            else:
                i['tag'] = ''

        pidlist = [i['id'] for i in result]                


        if 'id' in session and session['id']:
            u_id = extract_user(session['id'])
            if u_id:
                p_isliked = plyylike_status(pidlist, u_id)
                for i in result:
                    i['pliked'] = p_isliked.get(i['id'], False)
        return result
    
    except:
        print('플레이리스트 목록을 불러오는데 실패했습니다.')


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
                    JOIN SONG s ON t.id=s.tk_id 
                    WHERE s.p_id=? AND s.num=?
                    '''
        result = dict(db.get_query(song_query, (id,song_num), mul=False))

        total_query = '''
                    SELECT
                    COUNT(id) AS total
                    FROM SONG
                    WHERE p_id=?
                    '''
        total_index = dict(db.get_query(total_query, (id,), mul=False))
        result['total_num'] = total_index['total']
        return result
    
    except:
        print('해당 곡의 상세정보 페이지가 존재하지 않습니다.')
        

def curator_query(condition=None, param=None):
    try:
        query = '''
                SELECT
                c.id,
                c.name,
                img,
                intro
                FROM CURATOR c
                '''
        curators = db.get_query(query)

        if condition:
            if condition.lower() == 'name':
                query = query + " WHERE c.name LIKE '%'||?||'%';"         
            elif condition.lower() == 'uid':
                query = query + " JOIN C_LIKE cl ON c.id=cl.c_id WHERE cl.u_id=?;"
            elif condition.lower() == 'tag':
                query = query + '''
                                JOIN C_TAG ct ON c.id=ct.c_id 
                                JOIN TAG tg ON ct.t_id=tg.id
                                WHERE tg.name LIKE '%'||?||'%';
                                '''
            curators = db.get_query(query,(param,))
        result = [dict(row) for row in curators]
        
        for i in result:
            tags = tag_query('curator', i['id'])
            tag = []
            for j in tags[:2]:
                tag.append(j['name'])
            i['tag'] = tag

        date_query = '''
                    SELECT
                    MAX(STRFTIME('%Y-%m-%d', p.gen_date)) AS generate,
                    MAX(STRFTIME('%Y-%m-%d', p.up_date)) AS 'update'
                    FROM PLYY p
                    JOIN CURATOR c ON p.c_id=c.id
                    GROUP BY c.id
                    HAVING c.id=?;
                    '''
        for i in result:
            date = db.get_query(date_query, (i['id'],), mul=False)
            i.update(dict(date))
        
        cidlist = [i['id'] for i in result]

        if 'id' in session and session['id']:
            u_id = extract_user(session['id'])
            if u_id:
                c_isliked = curatorlike_status(cidlist, u_id)
                for i in result:
                    i['cliked'] = c_isliked.get(i['id'], False)
        return result
    except:
        print('큐레이터 목록을 불러오는데 실패했습니다.')
