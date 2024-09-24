import os
from collections import OrderedDict
from time import sleep
import logging
import random

import requests
from requests.exceptions import RequestException
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import NoSuchElementException, WebDriverException

class Crawler:
    """_summary_ 성균관대학교 지도 웹페이지에서 건물 정보들을 읽는 크롤러
    """
    
    def __init__(self, url: str, campus: str) -> None:
        """ 멤버변수 초기화 및 크롤링할 캠퍼스 url 주소 설정

        Args:
            url (str): 크롤링할 캠퍼스 지도 url 주소
            campus (str): 크롤링할 캠퍼스 (인문사회과학캠퍼스 or 자연과학캠퍼스)
        """
        self.url = url
        self.campus = campus
        self.data: list[dict] = list()
        
    def get_data(self) -> list[dict]:
        """ 크롤러가 읽은 건물 정보들을 반환한다.

        Returns:
            list (list[dict]): 건물 정보 리스트
        """
        return self.data
        
    def download_building_images(self, folder_name: str="images") -> None:
        """ 크롤링한 건물정보들에 대응되는 건물 이미지를 folder_name에 다운로드 받는다.

        Args:
            folder_name (str): 이미지들을 다운로드할 폴더명. Defaults to "images".
        """
        logging.info(f"Start downlading images")
        # 다운로드할 폴더를 생성한다.
        if not os.path.exists(folder_name):
            os.mkdir(folder_name)
        
        # 처음 다운로드 시도거나 다운로드에 실패한 이미지들이 있으면 다시 다운로드 시도.
        isFirst = True
        lost: list[dict] = []
        while isFirst or lost:
            isFirst = False
            data = lost if lost else self.data
            
            for building_info in data:
                # 웹에 있는 이미지 주소에서 파일명 구하기
                url = building_info["building_image"]
                filename = url.split("/")[-1]
                
                # 웹 상에서 파일 다운로드
                try: 
                    logging.info(f"Try to download image of {building_info['building_name']}")
                    response = requests.get(url, 
                                            headers={"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:39.0)"}
                    )
                    response.raise_for_status()
                    
                    download_path = os.path.join(folder_name, filename)
                    
                    with open(download_path, "wb") as file:
                        file.write(response.content)
                        
                    logging.info(f"Successfully download image of {building_info['building_name']}")
                    
                # 실패시 싶패 내역을 기록한다.
                except RequestException as err:
                    lost.append(building_info)
                    logging.warning(f"{err}")

                sleep(random.random(0.5, 1.5))
                    
        self._renewal_building_images()
        
    def _renewal_building_images(self) -> None:
        """ (url 주소 + 파일 이름) 형태에서 (파일 이름)로 변환 """
        for i in range(len(self.data)):
            src = self.data[i]["building_image"]
            filename = src.split("/")[-1]
            self.data[i]["building_image"] = filename
    
    def crawl_webpage(self) -> None:
        """ 주어진 웹페이지에서 건물정보를 모두 크롤링
        """
        # building_number, building_name, building_address, building_image, building_info, campus, 
        logging.info(f"Start crawling {self.url}")

        chrome_options = Options()
        chrome_options.add_argument("--headless")  # 헤드리스 모드 설정
        chrome_options.add_argument("--disable-gpu")  # GPU 비활성화
        chrome_options.add_argument("--no-sandbox")  # 샌드박스 비활성화 (일부 Linux 환경에서 필요)

        # 웹 드라이버 시작
        driver = webdriver.Chrome(options=chrome_options)
        driver.get(self.url)

        positions = driver.find_elements(By.CLASS_NAME, "position")
        cMap_mores = driver.find_elements(By.CLASS_NAME, "cMap_more")
        roads = driver.find_elements(By.CLASS_NAME, "road")
        
        isFirst = True
        lost: list[dict] = []
        
        while isFirst or lost:
            isFirst = False
            n = lost if lost else range(len(positions))
        
            for i in n:
                try :
                    position, cMap_more = positions[i], cMap_mores[i]
                    
                    # 건물 번호와 건물 이름 추출
                    building_id = position.find_element(By.CLASS_NAME, "locIcon").text
                    building_name = position.find_element(By.CLASS_NAME, "locTxt").text
                    
                    # 만약 building_id가 없는 건물이면 skip한다.
                    if building_id == "": continue
                    
                    logging.info(f"Try to crawl ({building_id}: {building_name}) datas")

                    # 리스트 클릭
                    position.click()
                    
                    # 상세보기 클릭
                    cMap_more.click()
                    sleep(0.5)
                    
                    # 텍스트 정보
                    building_info = driver.find_element(By.CLASS_NAME, "more_imgTxt").text.split("\n")[0]
                    
                    # 이미지 정보
                    flL = driver.find_element(By.CLASS_NAME, "flL")
                    img = flL.find_element(By.TAG_NAME, "img")
                    building_image = img.get_attribute("src")
                    
                    # 도착 버튼 클릭
                    road = roads[i]
                    road.click()
                    
                    # 다음페이지로 이동
                    last_tab = driver.window_handles[-1]
                    driver.switch_to.window(window_name=last_tab)
                    
                    # 위도 경도 정보 가져오기
                    current_url = driver.current_url.split("&")
                    building_latitude = float(current_url[2].split("=")[1])
                    building_longitude = float(current_url[3].split("=")[1])
                    
                    # 페이지를 닫고 기존 페이지로 돌아가기
                    driver.close()
                    first_tab = driver.window_handles[0]
                    driver.switch_to.window(window_name=first_tab)
                    
                    self.data.append(OrderedDict({
                        "building_id": building_id,
                        "building_name": building_name,
                        "building_image": building_image,
                        "building_info": building_info,
                        "building_latitude": building_latitude,
                        "building_longitude": building_longitude,
                        "campus": self.campus
                    }))
                    logging.info(f"Sucessfully crawl ({building_id}: {building_name}) datas")
                    
                # 실패시 실패 내역을 기록한다.
                except NoSuchElementException or WebDriverException as err:
                    lost.append(i)
                    logging.warning(f"{i}: {err}")
        
        driver.close()
        
        