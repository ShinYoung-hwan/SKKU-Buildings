const displayCircleDot = (srcPos, dstPos, distance, map) => {
  // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
  const position = new kakao.maps.LatLng(
    (srcPos.Ma + dstPos.Ma) / 2,
    (srcPos.La + dstPos.La) / 2
  );

  var circleOverlay = new kakao.maps.CustomOverlay({
    content: '<span class="dot"></span>',
    position: position,
    zIndex: 1,
  });

  // 지도에 표시합니다
  circleOverlay.setMap(map);

  if (distance > 0) {
    // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
    var distanceOverlay = new kakao.maps.CustomOverlay({
      content:
        '<div class="dotOverlay">거리 <span class="number">' +
        distance +
        "</span>m</div>",
      position: position,
      yAnchor: 1,
      zIndex: 2,
    });

    // 지도에 표시합니다
    distanceOverlay.setMap(map);
  }
};

const get_marker_image = (imageSrc) => {
  var imageSize = new kakao.maps.Size(42, 46), // 마커이미지의 크기입니다
    imageOption = { offset: new kakao.maps.Point(18, 46) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

  // 마커의 이미지정보를 가지고 있는 마커이미지를 생성해 반환
  return new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
};

//
const set_current_position = () => {
  // 현재위치 찍기
  navigator.geolocation.getCurrentPosition((position) => {
    // 현재 위치 객체
    const srcPos = new kakao.maps.LatLng(
      position.coords.latitude,
      position.coords.longitude
    );

    // 지도 중앙 설정
    var map = new kakao.maps.Map(container, {
      center: srcPos,
      level: 3,
    });

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
      position: srcPos,
      image: get_marker_image("./assets/src_marker.png"), // 마커이미지 설정
    });

    marker.setMap(map);
  });
};

//
const set_target_position = (lat, lng) => {
  // 현재위치와 목표 위치를 동시에 찍기
  navigator.geolocation.getCurrentPosition((position) => {
    // 맵 바운더리 설정을 위한 변수
    var bounds = new kakao.maps.LatLngBounds();

    // 현재 위치 객체
    const srcPos = new kakao.maps.LatLng(
      position.coords.latitude,
      position.coords.longitude
    );
    bounds.extend(srcPos);
    var map = new kakao.maps.Map(container, {
      center: srcPos,
      level: 3,
    });

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
      position: srcPos,
      image: get_marker_image("./assets/src_marker.png"), // 마커이미지 설정
    });

    marker.setMap(map);

    // 목적지 위치 객체
    const dstPos = new kakao.maps.LatLng(lat, lng);
    bounds.extend(dstPos);

    // 마커를 생성합니다
    marker = new kakao.maps.Marker({
      position: dstPos,
      image: get_marker_image("./assets/dst_marker.png"), // 마커이미지 설정
    });

    marker.setMap(map);

    // 맵 크기 재설정
    map.setBounds(bounds);

    // 지도에 직선거리 표시하기
    var polyline = new kakao.maps.Polyline({
      path: [srcPos, dstPos], // 선을 구성하는 좌표배열 입니다
      strokeWeight: 5, // 선의 두께 입니다
      strokeColor: "#FFAE00", // 선의 색깔입니다
      strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
      strokeStyle: "solid", // 선의 스타일입니다
    });

    // 지도에 선을 표시합니다
    polyline.setMap(map);
    var distance = Math.round(polyline.getLength());
    displayCircleDot(srcPos, dstPos, distance, map);
  });
};
