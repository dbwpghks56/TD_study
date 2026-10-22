# 2026-10-22 · 커스텀 컴포넌트 만들기: pulse_color

> Base COMP에 커스텀 파라미터를 달고, LFO CHOP 값으로 TOP 색을 움직이는 컴포넌트를 만든다.

## 🎯 오늘 배운 것

- 자주 쓰는 네트워크를 **Base COMP** 하나로 묶어 `.tox`로 저장하면 다른 프로젝트에서 재사용할 수 있다.
- COMP에 **커스텀 파라미터**를 추가하면 안쪽 노드를 열지 않고 밖에서 값을 조절할 수 있다.
- 안쪽 노드는 `parent().par.이름`으로 바깥 COMP의 커스텀 파라미터를 읽는다.
- CHOP 값을 다른 노드 파라미터에 넣으면 값이 시간에 따라 움직인다.

## 🧱 사용한 노드

| 노드 | 종류 | 역할 |
|---|---|---|
| `pulse_color` | Base COMP | 전체를 감싸는 컴포넌트, 커스텀 파라미터 `Speed` · `Color` 보유 |
| `lfo1` | LFO CHOP | 0 ~ 1 사이를 오가는 사인파 생성 |
| `constant1` | Constant TOP | 색이 칠해진 1280x720 이미지 |
| `out1` | Out TOP | 컴포넌트 밖으로 이미지를 내보내는 출구 |

```
lfo1 (CHOP) ··값 참조··▶ constant1 (TOP) ──▶ out1 (TOP)
```

## 💡 핵심 정리

### 1. 커스텀 파라미터 추가

COMP 우클릭 → **Customize Component...** 에서 페이지(`Pulse`)를 만들고 파라미터를 추가한다.

| 이름 | 타입 | 기본값 | 범위 |
|---|---|---|---|
| `Speed` | Float | 1 | 0 ~ 10 |
| `Color` | RGBA | (0.2, 0.6, 1, 1) | 0 ~ 1 |

- 파라미터 이름은 **첫 글자만 대문자**여야 한다. (`Speed` O, `speed` X, `SPEED` X)
- RGBA 파라미터는 `Colorr` `Colorg` `Colorb` `Colora` 4개로 나뉜다.

### 2. LFO CHOP을 0 ~ 1로 맞추기

LFO 기본 출력은 -1 ~ 1이라 색에 바로 곱하면 음수가 나온다.

| 파라미터 | 값 | 이유 |
|---|---|---|
| Frequency | `parent().par.Speed` | 바깥 `Speed`로 속도 조절 |
| Amplitude | `0.5` | 진폭을 절반으로 |
| Offset | `0.5` | 가운데를 0.5로 올림 → 결과 0 ~ 1 |

### 3. CHOP 값을 TOP 파라미터에 연결

Constant TOP의 색 파라미터를 Expression 모드로 바꾸고 아래처럼 쓴다.

```python
# Color R / G / B
parent().par.Colorr * op('lfo1')[0].eval()
parent().par.Colorg * op('lfo1')[0].eval()
parent().par.Colorb * op('lfo1')[0].eval()

# Alpha
parent().par.Colora
```

- `op('lfo1')[0]`은 lfo1의 첫 번째 채널이다. `.eval()`로 현재 값을 숫자로 꺼낸다.
- CHOP을 파라미터에 드래그해서 **CHOP Reference**로 연결해도 같은 결과가 나온다.

### 4. .tox로 저장

COMP 우클릭 → **Save Component .tox...** → `components/` 폴더에 저장한다.

## 🧯 막혔던 점

- LFO 출력을 그대로 곱하면 -1 ~ 0 구간에서 색이 음수가 되어 반 주기 동안 검게 잘린다 → Amplitude 0.5, Offset 0.5로 0 ~ 1에 맞춘다

## 🚀 다음에 해볼 것

- [ ] `Wavetype` 커스텀 파라미터 추가해서 사인 / 삼각 / 사각파 고르기
- [ ] 해상도를 커스텀 파라미터로 빼기
- [ ] Noise CHOP으로 바꿔서 불규칙하게 깜빡이게 하기

## 🔗 참고

- [Base COMP](https://docs.derivative.ca/Base_COMP)
- [Custom Parameters](https://docs.derivative.ca/Custom_Parameters)
- [LFO CHOP](https://docs.derivative.ca/LFO_CHOP)
- [Constant TOP](https://docs.derivative.ca/Constant_TOP)
