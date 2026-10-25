# 📝 TIL (Today I Learned)

TouchDesigner를 공부하면서 배운 것을 날짜별로 정리한다.

## ✍️ 작성 규칙

- 파일 이름: `YYYY-MM-DD-주제.md` (예: `2026-10-22-pulse-color-component.md`)
- 새 노트는 아래 스크립트로 만든다. [`_template.md`](_template.md)를 복사하고 제목 날짜를 채우고 노트 목록에 한 줄 추가하는 것까지 한 번에 한다.
- 스크립트가 넣어 준 목록 행의 키워드 칸은 직접 채운다.

스크립트는 저장소 루트에 있다. 어디서 실행해도 파일은 `TIL/` 안에 생긴다.

```bash
# macOS / Git Bash (저장소 루트에서)
./new_til.sh 주제

# Windows: new_til.bat 더블클릭(주제를 물어본다) 또는
.\new_til.ps1 주제
```

- 주제는 영문 슬러그를 권장한다. 공백은 `-`로 바뀐다.
- 주제를 비우면 `YYYY-MM-DD.md`로 만들고 제목의 주제 자리는 비워 둔다.
- 같은 이름의 파일이 있으면 덮어쓰지 않고 멈춘다.

## 📚 노트 목록

| 날짜 | 주제 | 키워드 |
|---|---|---|
| 2026-10-22 | [커스텀 컴포넌트 만들기: pulse_color](2026-10-22-pulse-color-component.md) | `Base COMP` `Custom Parameter` `LFO CHOP` `Constant TOP` |
| 2026-10-24 | [noise](2026-10-24-noise.md) |  |
| 2026-10-24 | [sop](2026-10-24-sop.md) |  |
| 2026-10-24 | [instancing](2026-10-24-instancing.md) |  |
| 2026-10-25 | [UV_map](2026-10-25-UV_map.md) |  |
