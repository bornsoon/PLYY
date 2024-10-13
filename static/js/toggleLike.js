function ToggleLike(u_id, id, category, btn) {
    if (category == 'plyy') {
        likeStates = plyyLikeStates;
        btnId = `like-p${id}`;
    } else if (category == 'curator') {
        likeStates = curatorLikeStates;
        btnId = `like-c${id}`;
    }
    
    const likeButton = document.getElementById(btnId);
    const methodToggle = likeStates[id] ? 'DELETE' : 'POST';
    const url = likeStates[id] ? `/api/like_toggle/ul/${category}/${encodeURIComponent(u_id)}/${encodeURIComponent(id)}` : `/api/like_toggle/l/${category}/${encodeURIComponent(u_id)}/${encodeURIComponent(id)}`;
    fetch(url, { method: methodToggle })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            likeStates[id] = !likeStates[id]; // 좋아요 상태 토글
            if (likeStates[id]) {
                likeButton.classList.remove(`btn-${btn}--unfill`);
                likeButton.classList.add(`btn-${btn}--fill`);
            } else {
                likeButton.classList.remove(`btn-${btn}--fill`);
                likeButton.classList.add(`btn-${btn}--unfill`);
            }
        } else {
            console.error('Failed to toggle like:', data.error);
        }
    })
    .catch(error => {
        console.error('Error toggling like:', error);
    });

    if (likeStates[id]) {
        return 0;
    } else {
        return 1;
    }
}