## 참고 사이트 : civit ai 
    - stable diffusion 예시

### 스테이블 디퓨전 사용 시 필요한 필수 지식
- webui 사용법 익히기

### 스테이블 디퓨전 로라 사용법
- 로라 모델 추가
    - directory : sd -> Stable diffusion Webui -> models -> Lora -> 로라파일추가
- img2img 에서 로라 적용


## stable diffusion 옵션
- prompt : 명령어 작성
- nagative prompt : 포함되지 않아야 하는 사항에 대한 명령어
- Sampling method : DPM++ 2M 사용 ( 3가지 좋은 method 만을 주로 사용하며 현재 DPM++ 2M 이 가장 좋다는 분위기임 )
- resize to : 가로 세로 사이즈를 기존 사진과 동일하게 설정 ( 비율이 무너짐 )
- batch count : 추출할 사진 개수
- batch size : 사진 개수만큼 반복할 횟수
- CFG scale : 프롬프트 참고할 비율
- Denoising strength : img를 참고할 비율
- seed : 랜덤 사진 번호 ( 2023 사용예정 )
- script -> 추후 알아볼 예정

## stable diffusion 사용
# 모델 ( 체크포인트 )
- 확장자 : .ckpt , .safetensors
- 참고 사이트
    - https://civitai.com/
    - https://huggingface.co/

# VAE 
- 모델의 디테일을 추가하는 작업에 사용
- 모델과 함께 사용하며 단독은 불가 (23.05)
- 참고 사이트 (허깅페이스)
    - https://huggingface.co/ygdm123/kl-f8-anime2.ckpt/blob/main/kl-f8-anime2.ckpt

# 프롬프트
- 긍정 프롬프트, 부정 프롬프트로 나누어진다
- 명령 형식보다 단어 나열 형식이 더 잘된다 (23.05)
- 프롬프트 형식
    - 강조 형식 (prompt)
    - 약화 형식 [prompt]
    - 수치 지정 (prompt:1.3)
    - 프롬프트 순서 : 단어A, B, C, D -> A 단어 강조
    - 언더바 _ : 띄어쓰기에 
    - 괄호 프롬프트 : ex) long hair\(blue_hair) -> 괄호 앞에 \를 추가
# 로라
- VAE와 같이 모델에 추가적으로 사용
- 확장자 : .pt , .safetensors
- 프롬프트에 <lora:파일명:가중치> 로 입력해서 사용
- tip
    - 여러개 사용 가능
    - 특정 로라는 트리거 워드라고 특정 단어를 입력해야 효과가 나온다
    - 그림체 로라는 트리거 워드 없이 로라 자체만으로 작동하는게 대부분이다 (23.05)
    - 로라 여러개를 쓸 경우 가중치 합이 1.5 넘어가지 않는것이 좋음 (23.05)

## 프롬프트 작성 방법 공부
- 각종 태그 모음 : https://arca.live/b/aiart/61336136 

# 아카라 팁 공부
- 프롬프트에 현재 사진에 대해 프롬프트 추가후 변경점 설정 하면 효과가 좋음
- 로라 값은 0.1 ~ 0.7이 일반적이지만 캐릭터는 1.0 까지도 사용한다
