<div align="center">

# 🎛️ TD_study

**TouchDesigner 공부 기록 저장소**

Mac 💻 ↔ Windows 🖥️ 를 오가며 공부하고, 그 과정을 버전으로 남긴다.

![TouchDesigner](https://img.shields.io/badge/TouchDesigner-000000?style=for-the-badge&logoColor=white)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)

</div>

---

## 📌 About

- 🎨 TouchDesigner 기능과 노드(TOP · CHOP · SOP · DAT · COMP · MAT) 공부
- 🔄 Mac과 Windows PC 사이에서 GitHub로 작업 동기화
- 🕘 공부 과정을 커밋으로 남겨 언제든 이전 상태로 돌아가기

## 📁 Structure

```
TD_study/
├── projects/        # TouchDesigner 프로젝트 (.toe)
├── components/      # 직접 만든 커스텀 컴포넌트 (.tox)
├── TIL/             # 공부 노트 (Today I Learned)
├── .gitignore
├── .gitattributes
└── README.md
```

## 🧩 Components

`.tox` 파일을 TouchDesigner 네트워크 창으로 드래그 앤 드롭하면 바로 쓸 수 있다.

| 컴포넌트 | 설명 | 파라미터 |
|---|---|---|
| [`pulse_color.tox`](components/pulse_color.tox) | 지정한 색이 일정한 속도로 밝아졌다 어두워지는 TOP을 출력 | `Speed` 깜빡이는 속도 (Hz) · `Color` 색상 (RGBA) |

## 📝 TIL

공부한 내용은 [`TIL/`](TIL/)에 날짜별 마크다운 노트로 남긴다. 새 노트는 [`_template.md`](TIL/_template.md)를 복사해서 쓴다.

## 🔄 Mac ↔ Windows Workflow

> 작업 **시작 전엔 pull**, **끝나면 push** — 이것만 지키면 된다.

```bash
# 1. 작업 시작 전: 다른 PC에서 한 작업 받아오기
git pull

# 2. TouchDesigner로 공부 ✨

# 3. 작업 끝: 저장하고 올리기
git add .
git commit -m "[study] 오늘 공부한 내용"
git push
```

<details>
<summary>🖥️ 새 PC에서 처음 시작할 때</summary>

```bash
git clone https://github.com/dbwpghks56/TD_study.git
cd TD_study
```

- **Windows**: [Git for Windows](https://git-scm.com/download/win)를 설치하면 Git Credential Manager가 함께 깔려서 첫 push 때 GitHub 로그인 창이 뜬다.
- **macOS**: 첫 push 때 GitHub 아이디와 Personal Access Token을 입력하면 키체인에 저장된다.

</details>

## ⚠️ Notes

| | 주의할 점 |
|---|---|
| 🧱 | `.toe`는 바이너리 파일이라 **병합(merge)이 안 된다.** 두 PC에서 같은 파일을 동시에 고치지 않기. |
| 💾 | TouchDesigner는 저장할 때 `NewProject.1.toe`, `.2.toe`처럼 번호를 붙여 새로 저장한다. 버전은 git이 관리하니 정리해도 된다. |
| 📂 | 이미지·영상 같은 외부 파일은 프로젝트 폴더 안에 두고 **상대 경로**로 불러오기. 절대 경로는 다른 PC에서 깨진다. |
| 🔢 | 두 PC의 TouchDesigner **버전을 맞춰** 두면 파일 호환 문제를 피할 수 있다. |

## 🔗 References

- [TouchDesigner 공식 사이트](https://derivative.ca/)
- [TouchDesigner 공식 문서 (Wiki)](https://docs.derivative.ca/)
- [Derivative 커뮤니티 · 튜토리얼](https://derivative.ca/community-post)
