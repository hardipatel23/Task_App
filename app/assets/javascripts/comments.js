// comments.js

document.addEventListener("DOMContentLoaded", () => {
    const addCommentLink = document.getElementById("add-comment-link");
    const commentsContainer = document.getElementById("comments-container");
  
    addCommentLink.addEventListener("click", (event) => {
      event.preventDefault();
  
      const url = event.target.getAttribute("href");
  
      fetch(url, {
        headers: { "X-Requested-With": "XMLHttpRequest" },
      })
        .then((response) => response.text())
        .then((html) => {
          commentsContainer.innerHTML = html;
        })
        .catch((error) => {
          console.error("Error:", error);
        });
    });
  });
  