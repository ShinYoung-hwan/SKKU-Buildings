import os
import shutil
import logging

from crawler.crawler import Crawler
from crawler.utils import write_json_file

def convert_json_to_load_html(filename: str="building_infos.json") -> None:
    """ html에서 직접 load할 수 있도록 json 파일 맨 앞에 변수명을 추가해준다.

    Args:
        filename (str): 변경할 json 파일명. Defaults to "building_infos.json".
    """
    text_to_add = "building_infos = "

    # 1. 기존 파일 내용 읽기
    with open(filename, "r") as file:
        original_content = file.read()

    # 2. 새 내용을 파일의 맨 앞에 추가
    new_content = text_to_add + original_content

    # 3. 새로운 내용을 파일에 다시 쓰기
    with open(filename, "w") as file:
        file.write(new_content)
    logging.info("Successfully convert basic json file to load html")

def move_to_main_directory(json: str="building_infos.json", folder: str="images") -> None:
    """ 건물 정보와 이미지 파일들을 메인 디렉터리로 이동시킨다.

    Args:
        json (str): 옮길 json 파일명. Defaults to "building_infos.json".
        folder (str): 옮길 이미지들이 저장되어 있는 폴더명. Defaults to "images".
    """
    dst = os.path.join("..", "assets")
    
    # json 파일 이동
    shutil.move(json, os.path.join(dst, json))
    
    # images 이동
    for image in os.listdir(folder):
        src = os.path.join(folder, image)
        shutil.move(src, os.path.join(dst, image))
    
    # 이동 후 빈 폴더 삭제
    os.rmdir(folder)
    logging.info("Successfully move assets to main directory")
    
def copy_to_mobile_directory(json: str="building_infos.json", folder: str="images") -> None:
    """ 건물 정보와 이미지 파일들을 모바일 디렉터리에 복사한다.
    
        Args:
        json (str): 옮길 json 파일명. Defaults to "building_infos.json".
        folder (str): 옮길 이미지들이 저장되어 있는 폴더명. Defaults to "images".
    """
    dst = os.path.json("..", "skku_buildings_mobile", "assets")
    
    # json 파일 복사
    shutil.copyfile(json, os.path.join(dst, json))
    
    # images 복사
    for image in os.listdir(folder):
        src = os.path.join(folder, image)
        shutil.copy(src, os.path.join(dst, image))
    
    logging.info("Successfully move assets to mobile directory")
    
if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    
    json_filename = "building_infos.json"
    image_download_folder = "images"
    
    crawler_suwon = Crawler("https://www.skku.edu/skku/about/campusInfo/campusMap.do?campusCd=2", "자연과학캠퍼스")
    crawler_suwon.crawl_webpage()
    crawler_suwon.download_building_images(image_download_folder)
    
    crawler_seoul = Crawler("https://www.skku.edu/skku/about/campusInfo/campusMap.do?campusCd=1", "인문사회과학캠퍼스")
    crawler_seoul.crawl_webpage()
    crawler_seoul.download_building_images(image_download_folder)
    
    data = crawler_seoul.get_data() + crawler_suwon.get_data()
    write_json_file(json_filename, data)
    
    copy_to_mobile_directory(json_filename, image_download_folder)
    
    convert_json_to_load_html(json_filename)
    move_to_main_directory(json_filename, image_download_folder)