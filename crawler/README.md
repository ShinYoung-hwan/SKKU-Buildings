# SKKU Buildings: Cralwer

## INTRO

- 성균관대학교의 건물 정보들을 공식 웹사이트에서 크롤링 해온다.
- 건물번호, 건물이름, 건물정보, 건물 위/경도, 건물 이미지 총 5가지 정보를 불러온다.

## How to use

1. Run python file

   ```sh
    $ conda create -n cralwer python=3.10
    $ pip install -r requirements.txt
    $ python main.py
   ```

2. See building_infos.json file & images folder

## JSON Form

```json
// building_infos.json
[
  {
    "building_id": "01",
    "building_name": "600주년기념관",
    "building_image": "wdvzbhwlwznihxqgvdlq.jpg",
    "building_info": "건학 600주년을 기념하기 위해서 1999년 11월에 완공되었다. 총장실, 부총장실을 비롯한 대학본부가 자리잡고 있으며, 각종 행사를 위한 대규모 공연장인 새천년홀과 조병두국제홀이 있다. 이 밖에 패컬티식당과 은행골, SUBWAY와 도미노피자가 입점해 있고, 수시로 전시회를 개최하는 박물관과 동아시아 연구의 메카인 동아시아학술원이 위치하고 있다.",
    "building_latitude": 37.587361,
    "building_longitude": 126.994479,
    "campus": "인문사회과학캠퍼스"
  },
   ... etc
]
```

## Requirement

- python 3.10
