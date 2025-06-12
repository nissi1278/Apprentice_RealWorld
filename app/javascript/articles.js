document.addEventListener("DOMContentLoaded", (event) => {
  const tagInputArea = document.getElementById("tag_input");
  const tagList = document.getElementById("tag-list");

  //タグの入力要素エンター時イベント
  tagInputArea.addEventListener("keydown", (event) => {
    event.preventDefault();
    if (event.key === "Enter" && tagInputArea.value?.trim() !== "") {
      const tagElement = document.createElement("li");
      tagElement.classList.add("tag-default", "tag-pill");
      tagElement.textContent = tagInputArea.value;
      tagInputArea.appendChild(tagElement);
    }
  });
  //追加タグのクリック時の削除イベント
  tagList.addEventListener("click", (event) => {
    const targetTag = event.target;
    tagList.removeChild(targetTag);
  });
});
