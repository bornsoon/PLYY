<div align="center">

# 🎧🎵PLYY🎵🎧
##### Youtube API와 Spotify API를 활용해서 플레이리스트를 제공하는 웹 서비스
###### 🌟 Youtube Embed Player 통해 플레이리스트를 감상하고
###### 🌟 큐레이터가 제공하는 곡의 맞춤 소개글도 함께 제공하는 플레이리스트 제공 서비스
<br>

## 👉👉👉 [ click! 🎶【 PLYY 둘러보기 】](https://plyyv.vercel.app/) 👈👈👈

<img src=https://github.com/user-attachments/assets/e4905c24-8c05-4128-abfc-68a5e13d25af>

</div>
<br>
<h2>📜 목차</h2>
01. <a href=#1>프로젝트 소개</a><br>
02. <a href=#2>ERD</a><br>
03. <a href=#3>Architecture</a><br>
04. <a href=#4>담당 역할</a><br>
05. <a href=#5>상세 구현</a><br>
06. <a href=#6>회고</a><br>
<br><br>

<h2 id=1>📜 About</h2>

##### 🗓️ 작업기간 : 2024.07.01 ~ 2024.08.13
##### 👩🏻‍👧‍👦 참여인원 : 풀스택 본인 포함 2인, 디자이너, 퍼블리셔 각각 1인
##### 🔧 기술스택
##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🖥️ 개발 환경
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://img.shields.io/badge/Vercel-000000?style=for-the-badge&logo=Vercel&logoColor=white"/> <img src="https://img.shields.io/badge/Visual Studio Code-007ACC?style=for-the-badge&logo=Visual Studio Code&logoColor=white"/>&nbsp;
##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🔧 도구 및 버전 관리
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white"> <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white">
<img src="https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white">
<img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white">
##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;📝 언어
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white"> <img src="https://img.shields.io/badge/HTML-E34F26?style=for-the-badge&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/CSS-1572B6?style=for-the-badge&logo=css3&logoColor=white"> <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"><br>
##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;🌱 프레임워크 & DB
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://img.shields.io/badge/flask-000000?style=for-the-badge&logo=flask&logoColor=white"/> <img src="https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=SQLite&logoColor=white"/> <img src="https://img.shields.io/badge/postgresql-4169E1?style=for-the-badge&logo=postgresql&logoColor=white"/>

<br>

<h2 id=2>✏️ ERD</h2>
  
![스크린샷 2025-03-07 173406](https://github.com/user-attachments/assets/0f36de92-5d78-4584-99ba-3528d6385d33)

<h2 id=3>✏️ Architecture</h2>

![Architecture](https://github.com/user-attachments/assets/e1b828fe-743e-4444-94c6-ebffb024a3f7)


<h2 id=4>📌 담당 역할</h2>

- **`  데이터베이스 구성   `** 
- **`  각 페이지 구현   `**
  - 메인 페이지
  - 검색 페이지
  - 플레이리스트 상세 페이지
  - 곡 상세 페이지 구현
- **`  검색 기능, 태그 기능  `**
  - 일반 검색 구현
  - 태그 검색 구현
 
#### 프로젝트 후, 추가 작업
- **`  SQLite에서 PostgreSQL로 데이터베이스 마이그레이션  `**
- **`  유지보수 향상을 위한 모듈화 및 클린 코드 작업  `**
- **`  Vercel 배포  `**
 
<br><br>

<h2 id=5>📌 상세 구현</h2>
<div align=center>
<img src=https://github.com/user-attachments/assets/3ead6d0e-a7df-4670-8cbb-22630fdb0790 width=600>
<br><br>

**`검색 기능`** → `해시태그 검색` & `일반 검색`
<br><img src=https://github.com/user-attachments/assets/3727c3de-0586-4944-bb25-cdf683bb74dc>
<br>

**`YoutubeAPI와 SpotiftAPI 활용`** → `플레이리스트 제공`
<br><img src=https://github.com/user-attachments/assets/20687608-0a45-4566-9a05-411ac3a5b243>
<br><br>

<img src=https://github.com/user-attachments/assets/0478c42c-d010-41cf-9819-6571486f3220 width=800>

</div>
  
<br>

<h2 id=6>💬 회고</h2>

###### *타 과정의 UI/UX 반과 협업하여 완성한 프로젝트였기에, 더욱 값진 경험이 되었다.*
###### *UI와 퍼블리싱 작업을 제외한 모든 개발을 두 명이서 진행하면서,<br> 다양한 기능을 직접 구현할 수 있는 좋은 기회였다.*
###### *프로젝트를 마친 후,<br>Vercel에 배포하기 위해 데이터베이스를 변경하면서 부족했던 부분을 보완하고,<br> 버그를 수정하며 전체 코드를 점검하는 시간을 가졌다.*
###### *이 과정에서 불필요한 코드와 비효율적인 데이터 조회 로직을 개선하고,<br> 내가 작성하지 않았던 코드도 수정하면서 개발 실력이 크게 향상되었다.*
###### *이번 프로젝트를 통해, 협업의 중요성을 다시 한번 깨닫게 되었으며,<br> 더 많은 인원이 참여하는 프로젝트에서는 구조적인 설계를 더욱 신경 써야 한다는 점을 느꼈다.*
