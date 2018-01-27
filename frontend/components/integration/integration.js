import "./integration.css";

const $ = require("jquery");

$(".duplicate_album").click(function duplicate(e) {
  e.preventDefault();
  const nestedExchange = $(this)
    .closest(".albums")
    .children(".album")
    .last();
  const newNestedForm = $(nestedExchange).clone();
  const formsOnPage =
    parseInt(
      $(nestedExchange)
        .find(".vk_group_albums_album_id input")
        .attr("step"),
      10
    ) + 1;
  $(newNestedForm)
    .find("input")
    .each(function formClone() {
      $(this).attr("step", formsOnPage);
      const oldId = $(this)
        .attr("id")
        .split("_");
      oldId[4] = formsOnPage;
      $(this).attr("id", oldId.join("_"));
      const oldName = $(this)
        .attr("name")
        .split("[");
      oldName[2] = `${formsOnPage}]`;
      $(this).attr("name", oldName.join("["));
      $(this).val("");
    });
  $(newNestedForm).insertAfter(nestedExchange);
});

$(".need_key label").click(function showLabel() {
  const current = $(this)
    .closest("div")
    .children("input")
    .is(":checked");
  if (current === false) {
    $(".key_fields").addClass("visible");
  } else {
    $(".key_fields").removeClass("visible");
  }
});
