document.addEventListener('DOMContentLoaded', () => {
  const input = document.getElementById('avatar-input');
  const preview = document.getElementById('avatar-preview');
  const fileNameDisplay = document.getElementById('avatar-filename'); // ← ファイル名用要素

  if (input && preview && fileNameDisplay) {
    input.addEventListener('change', event => {
      const file = event.target.files[0];
      if (file) {
        // プレビュー画像を更新
        const reader = new FileReader();
        reader.onload = e => {
          preview.src = e.target.result;
        };
        reader.readAsDataURL(file);

        // ファイル名を更新
        fileNameDisplay.textContent = file.name;
      } else {
        preview.src = '/assets/default-avatar.png'; // fallback（任意）
        fileNameDisplay.textContent = '選択されていません';
      }
    });
  }
});
