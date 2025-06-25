document.addEventListener("DOMContentLoaded", (event) => {
  const tagInputArea = document.getElementById("tag_input");
  const tagList = document.getElementById("tag-list");
  const hiddenTagNamesField = document.getElementById('article_tag_names_hidden');
  let currentTags = []
  //初期表示時(データ取得時)処理
  //タグの重複チェック
  function isTagAlreadyAdded(tagName) {
    const alreadyTags = tagList.querySelectorAll(".tag-items");
    if (alreadyTags) {
      const result = Array.from(alreadyTags).some((element) => {
        return element.textContent.trim() === tagName;
      });
      return result;
    }
  }

  function updateTagDisplay() {
    const tagElement = document.createElement("li");
    tagElement.classList.add("tag-items", "tag-default", "tag-pill");
    tagElement.textContent = tagInputArea.value;
    tagList.appendChild(tagElement);
    tagInputArea.textContent = "";
  }

  //タグの入力要素エンター時イベント
  tagInputArea.addEventListener("keydown", (event) => {
    if (event.key !== "Enter") {
      return;
    }
    event.preventDefault();
    const tagContext = tagInputArea?.value.trim();
    if (isTagAlreadyAdded(tagContext)) {
      throw new Error("すでにこのタグは登録されています。");
    }
    if (tagContext !== "") {
      updateTagDisplay();
      currentTags.push(tagContext)

      const tagText = currentTags.toString()
      hiddenTagNamesField.value = tagText
      tagInputArea.value = ''
    }
  });

  //追加タグのクリック時の削除イベント
  tagList.addEventListener("click", (event) => {
    const targetTag = event.target;
    currentTags = currentTags.filter((item) => {
      return item !== targetTag.textContent
    })

    tagList.removeChild(targetTag);
  });
});
