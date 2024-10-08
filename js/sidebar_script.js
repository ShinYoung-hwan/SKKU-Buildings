/* 클릭한 건물에 대한 자세한 정보를 보여준다. */
const show_building_info_overlay = (building_info) => {
  modal_title.replaceChildren();
  modal_title.append(
    `${building_info.building_id}: ${building_info.building_name} - ${building_info.campus}`
  );

  modal_body.replaceChildren();

  const building_image = document.createElement("img");
  building_image.setAttribute(
    "src",
    "./assets/" + building_info.building_image
  );
  building_image.setAttribute("style", "width: 100%;");

  const building_detail = document.createElement("div");
  building_detail.append(building_info.building_info);

  modal_body.append(building_image);
  modal_body.append(building_detail);
};

/* 주어진 입력에 맞게 building list를 최신화해준다. */
const set_buildings_list = (text) => {
  buildings_nav.replaceChildren(); // 비워주기

  for (building of building_infos) {
    if (
      text &&
      !(
        building.building_id.includes(text) ||
        building.building_name.includes(text)
      )
    )
      continue;

    var li = document.createElement("li");
    li.setAttribute(
      "class",
      "nav-item d-flex justify-content-between align-items-center"
    );

    var link = document.createElement("a");
    link.setAttribute("class", "nav-link");
    link.setAttribute(
      "onclick",
      `set_target_position(${building.building_latitude}, ${building.building_longitude})`
    );
    link.append(building.building_name + "(" + building.building_id + ")");

    var span = document.createElement("span");
    span.setAttribute("class", "info-btn");
    span.setAttribute("data-bs-toggle", "modal");
    span.setAttribute("data-bs-target", "#overlayModal");
    span.setAttribute(
      "onclick",
      `show_building_info_overlay(${JSON.stringify(building)})`
    );
    var i = document.createElement("i");
    i.setAttribute("class", "bi bi-info-circle");

    span.appendChild(i);

    li.appendChild(link);
    li.appendChild(span);

    buildings_nav.appendChild(li);
    buildings_nav.append(document.createElement("br"));
  }
};
