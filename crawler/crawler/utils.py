import json

def write_json_file(file_name, file_data):
    with open(file_name, "w") as f:
        json.dump(file_data, f, ensure_ascii=False, indent="\t")
        
def read_json_file(file_name):
    data = list
    with open(file_name, "r") as f:
        json.load(f, )
    
def rename_files_to_lowercase(directory):
    import os
    try:
        # 디렉토리 내의 모든 파일 및 디렉토리 목록 가져오기
        for filename in os.listdir(directory):
            # 원본 파일 경로
            original_file_path = os.path.join(directory, filename)

            # 대문자를 소문자로 변환한 새 파일 경로
            new_file_path = os.path.join(directory, filename.lower())

            # 파일 이름이 변경될 경우에만 변경 수행
            if original_file_path != new_file_path:
                os.rename(original_file_path, new_file_path)
                print(f"'{original_file_path}'가 '{new_file_path}'로 변경되었습니다.")
    
    except Exception as err:
        print(err)
    
if __name__ == "__main__":
    # download_image("building_info.json")
    # convert_building_image("building_info.json")
    rename_files_to_lowercase("download")